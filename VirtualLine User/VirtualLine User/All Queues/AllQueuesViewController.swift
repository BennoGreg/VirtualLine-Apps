//
//  AllQueuesViewController.swift
//  VirtualLine User
//
//  Created by Niklas Wagner on 07.06.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit

struct Section {
    let letter: String
    let names: [String]
}

class AllQueuesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var allQueuesCollectionView: UICollectionView!
    var data = QueuesData()
    var sections = [Section]()
    var letters = [String]()

    override func viewWillAppear(_ animated: Bool) {
        allQueuesCollectionView.delegate = self
        allQueuesCollectionView.dataSource = self
        configureQueueData()

        setUpUI()
    }

    func configureQueueData() {
        var queueNames: [String] = []

        for curQueue in data.allQueues {
            queueNames.append(curQueue.name)
        }

        // groups the array to ["H": ["H&M"], "K": ["Klipp", "KTM Shop"],...
        let groupedDictionary = Dictionary(grouping: queueNames, by: { String($0.prefix(1)) })
        // get the keys and sort them
        letters = groupedDictionary.keys.sorted()
        // map the sorted keys to a struct
        sections = letters.map { Section(letter: $0, names: groupedDictionary[$0]!.sorted()) }
    }

    func setUpUI() {
        parent?.title = "Alle Warteschlangen"

        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true

        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].names.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

   
    // Section Header View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "allQueuesSectionHeader", for: indexPath) as! AllQueuesSectionHeader

        sectionHeaderView.update(sectionName: letters[indexPath.section])

        return sectionHeaderView
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AllQueuesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "allQueuesCell", for: indexPath) as! AllQueuesCell
        updateCellDesign(cell: cell)
        let section = sections[indexPath.section]
        let queueName = section.names[indexPath.row]

        cell.update(queueName: queueName, queueTime: 3, queueLength: 4)

        return cell
    }

    func updateCellDesign(cell: UICollectionViewCell) {
        cell.layer.cornerRadius = 10
       // cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
    }
}

extension AllQueuesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 100
        return CGSize(width: collectionView.bounds.size.width - 32, height: CGFloat(height))
    }
}
