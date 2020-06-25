

const functions = require('firebase-functions');

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions


/*exports.helloWorld = functions.https.onRequest((request, response) => {
response.send("Hello from Firebase!");
});*/


var admin = require("firebase-admin");

admin.initializeApp();

const db = admin.firestore();

/*const express = require('express');
const cors = require('cors');
const app = express();
app.use(cors({ origin: true }));

app.get('/hello-world:item,id', (req, res) => {
    return res.status(200).send('Hello World!');
});

exports.app = functions.https.onRequest(app);*/
/*
app.get('/api/read/:item_id', (req, res) => {
    (async () => {
        try {
            const document = db.collection('queue').doc(req.params.item_id);
            let item = await document.get();
            let response = item.data();
            return res.status(200).send(response);
        } catch (error) {
            console.log(error);
            return res.status(500).send(error);
        }
    })();
});

app.post('/api/create', (req, res) => {
    (async () => {
        try {
            const ref = admin.firestore().ref('user/User2');
            console.log(ref);
            await db.collection('queue').doc('/'+req.body.id+'/').update({UserQueue: admin.firestore.FieldValue.arrayUnion(ref)});
            //await db.collection('user').doc('/'+req.body.id+'/').create({name: req.body.name});
            return res.status(200).send(res.body);
        } catch (error) {
            console.log(error);
            return res.status(500).send(error);
        }
    })();
});*/

/*
    console.log("Total Users in Queue: ", users.length);

    const fetch = users[0].get().then(snapshot =>{
        console.log("current User: ", snapshot.data());
        return 1;
    }).catch(error =>{
        console.log("Error occurred: ", error);
        return 0;
    });*/



exports.queue = functions.region('europe-west1').firestore.document('queue/{queueID}').onUpdate((change,context) =>{

    const newValue = change.after.data();


    const users = newValue.UserQueue;
    const token = newValue.DeviceToken;
    const update = updateUser(users.slice(-1)[0], newValue, token, change.after.id);
    const time = newValue.TimePerCustomer;


    //sendToAdmin(token,newValue, change.after.id);

    for (i = 0; i < users.length; i++){
        sendToUser(users[i], users, time);
    }

    return 0;

});

function updateUser(user, data, token,id) {
    return  user.update({
        NumberInQueue: data.CurrentNumber
    }).then(() => {
        let promises = [];
        for(i = 0; i<2; i++){
            if (i===data.UserQueue.length) break;
            let ref = data.UserQueue[i];
            const p = ref.get()
            promises.push(p);
        }
        return Promise.all(promises);
    }).then(snapshots =>{
        const result = [];
        snapshots.forEach(userSnap =>{
            const data = userSnap.data();
            console.log('Data: ',data)
            result.push(data);
        })
        sendToAdmin(token,data,result,id);
        return 1;
    }).then(()=>{
        return console.log("Success");
    }).catch((error) => {
        console.log(error);
        throw new functions.https.HttpsError('unknown', error.message, error);
    });


}

function sendToAdmin(token, data, userData, id){

    let firstUserName = "";
    let firstPosition = "0";
    if(!(userData[0] === undefined)){
        firstUserName = userData[0].Name;
        firstPosition = userData[0].NumberInQueue;
    }
    let secondUserName = "";
    if (!(userData[1] === undefined)){
        secondUserName = userData[1].Name;
    }


    let message = {
        apns: {
            payload: {
                aps: {
                    category: "QUEUE_UPDATE",
                    alert: {
                        title: 'This is a message for the admin',
                        body: 'This Queue contains ' + data.UserQueue.length + ' users in the queue!',
                    },
                    badge: 42,
                    sound: "bingbong.aiff",
                    contentAvailable: 1,
                },
                data: {
                    customerCount: data.UserQueue.length,
                    first: firstUserName,
                    numberFirst: firstPosition,
                    second: secondUserName,
                }
            },
        },
        token: token,
    };


    const sending = admin.messaging().send(message).then(function (response){
        return console.log("Successfully sent message: ", response);
    }).catch(function (error){
        console.log(error);
        throw new functions.https.HttpsError('unknown', error.message, error);
    });
}




function sendToUser(reference, users, time){
    let token = null;
    const fetch = reference.get().then(snapshot =>{
        const data = snapshot.data();
        //console.log("current User: ", snapshot.data());

        token = data.DeviceToken;
        let index = getIndex(users, reference);
        const count = users.length;
        const totalTime = count * time;

        let message = {
            apns: {
                payload: {
                    aps: {
                        category: "QUEUE_UPDATE",
                        alert: {
                            title: 'UserUpdate',
                        },
                        badge: 42,
                        sound: "bingbong.aiff",
                        contentAvailable: 1,
                    },
                    data: {
                        TotalNumber: count,
                        TotalTime: totalTime,
                        CurrentIndex: index
                    }
                },
            },
            token: token,
        };
        pushMessage(message);
        return 1;
    }).catch(error =>{
        console.log("Error occurred: ", error);
        return 0;
    });

}

function pushMessage(payload){


    admin.messaging().send(payload).then(function (response){
        return console.log("Successfully sent message: ", response);
    }).catch(function (error){
        console.log(error);
        throw new functions.https.HttpsError('unknown', error.message, error);
    });
}

function getUser(reference){

    const prom =  reference.get().then(function(doc) {
            const data = doc.data();
            console.log(data);
            return data;
        }
    ).catch(error => {
        console.log("Error: ", error);
        return null;
    })
}

exports.putReference = functions.https.onCall((data, context) => {

    const queueID = data.id;
    const reference = data.reference;

    console.log(reference);
    let docRef = admin.firestore().doc('user/'+reference);
    console.log(docRef);
    let queueRef = admin.firestore().collection('queue').doc(queueID);
    return queueRef.get().then((snapshot) =>{
        let data = snapshot.data();
        let users = data.UserQueue;
        if (!users.includes(data)){
            return queueRef.update({
                CurrentNumber: admin.firestore.FieldValue.increment(1),
                UserQueue: admin.firestore.FieldValue.arrayUnion(docRef)
            });
        }
        return 0;
    }).then(() => {
        console.log("New User added to queue");
        return "Done successfully";
    }).catch((error) => {
        throw new functions.https.HttpsError('unknown', error.message, error);
    })
});


exports.deleteReference = functions.https.onCall((data,context) =>{

    const queueID = data.id;
    const userID = data.reference;

    let docRef = admin.firestore().doc('user/'+userID);
    console.log("QueueID: ", queueID, "UserID", userID);
    let lastNumber = 0;
    return admin.firestore().collection('queue').doc(queueID).update({
        UserQueue: admin.firestore.FieldValue.arrayRemove(docRef)
    }).then(() => {
        console.log("User removed from queue");
        return "Done successfully";
    }).catch((error) => {
        console.log(error);
        throw new functions.https.HttpsError('unknown', error.message, error);
    })
});



exports.fetchQueueData = functions.https.onCall((data, context) =>{

    let queueID = data.queueID;
    let userRefString = data.userID;
    let docRef = admin.firestore().doc('user/'+userRefString);

    return admin.firestore().collection('queue').doc(queueID).get().then(snapshot=>{

        console.log(snapshot.data());
        let data = snapshot.data();
        let userqueue = data.UserQueue;
        let count = data.UserQueue.length;
        let totalTime = data.TimePerCustomer * count;
        let index = getIndex(userqueue,docRef);
        return {TotalNumber: count, TotalTime: totalTime, CurrentIndex: index};

    }).catch((error) => {
        console.log(error);
        throw new functions.https.HttpsError('unknown', error.message, error);
    })
});

function getIndex( data, reference){
    for (i = 0; i< data.length; i++){
        if (data[i].id === reference.id){
            return i;
        }
    }
    return -1;
}



exports.fetchQueueDataForAdmin = functions.https.onCall((data, context) =>{
    let queueID = data.QueueID;
    let promise = admin.firestore().collection('queue').doc(queueID).get().then( (snapshot) =>{
        let data = snapshot.data();
        const userQueue = data.UserQueue;
        return 0;
    })
})

function getDataForAdmin(user, data,  id){
    return  user.update({
        NumberInQueue: data.CurrentNumber
    }).then(() => {
        let promises = [];
        for(i = 0; i<2; i++){
            if (i===data.UserQueue.length) break;
            let ref = data.UserQueue[i];
            const p = ref.get()
            promises.push(p);
        }
        return Promise.all(promises);
    }).then(snapshots =>{
        const result = [];
        snapshots.forEach(userSnap =>{
            const data = userSnap.data();
            console.log('Data: ',data)
            result.push(data);
        })
        return 1;
    }).then(()=>{
        return console.log("Success");
    }).catch((error) => {
        console.log(error);
        throw new functions.https.HttpsError('unknown', error.message, error);
    });

}







/*exports.printData = functions.https.onRequest((request, response) =>{
    db.collection('user').get().then((snapshot) => {
        snapshot.forEach((doc) => {
            response.send(doc.data().name);

        });

    }).catch((error) => {
        console.log('Error getting documents');
    });
});*/