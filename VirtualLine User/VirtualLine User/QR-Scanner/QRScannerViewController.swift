//
//  QRScannerViewController.swift
//  VirtualLine User
//
//  Created by Niklas Wagner on 09.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
  
    @IBOutlet weak var qrCodeFrameView: UIView!
    @IBOutlet weak var infoTextLabel: UILabel!
    var captureSession: AVCaptureSession!
        var previewLayer: AVCaptureVideoPreviewLayer!
       
    
    override func viewWillAppear(_ animated: Bool) {
             
    //    setUpUI()
        
          
//                     if (captureSession?.isRunning == false) {
//                        captureSession.startRunning()
//                    }
       }

       override func viewWillDisappear(_ animated: Bool) {
        
         //  navigationItem.largeTitleDisplayMode = .always
//navigationController?.navigationBar.prefersLargeTitles = true
         //  navigationController?.navigationBar.isTranslucent = true
           
         //  super.viewWillDisappear(animated)
          
        
          // if (captureSession?.isRunning == true) {
              // captureSession.stopRunning()
         //  }
       }
    
        override func viewDidLoad() {
            super.viewDidLoad()
    }/*
            setUpUI()

            captureSession = AVCaptureSession()

            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
            let videoInput: AVCaptureDeviceInput

            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                return
            }

            if (captureSession.canAddInput(videoInput)) {
                captureSession.addInput(videoInput)
            } else {
                failed()
                return
            }

            let metadataOutput = AVCaptureMetadataOutput()

            if (captureSession.canAddOutput(metadataOutput)) {
                captureSession.addOutput(metadataOutput)

                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
            } else {
                failed()
                return
            }

            let previewView = UIView(frame: view.frame)
            let testView = UIView(frame: view.frame)
            testView.backgroundColor = .blue
            view.addSubview(previewView)
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = view.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
            previewView.layer.addSublayer(previewLayer)

            captureSession.startRunning()
//
            // Initialize QR Code Frame to highlight the QR code
               qrCodeFrameView?.layer.borderColor = UIColor.red.cgColor
               qrCodeFrameView?.layer.borderWidth = 4
            view.addSubview(qrCodeFrameView!)
            view.addSubview(infoTextLabel)
            view.addSubview(testView)

            infoTextLabel.text = "Bitte positioniern Sie den QR-Code\nin der Mitte der Box."
        }
    
   
    func setUpUI(){
//        self.parent?.title = "Scan"
//
//        qrCodeFrameView.translatesAutoresizingMaskIntoConstraints = false
//        qrCodeFrameView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        qrCodeFrameView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//           navigationItem.largeTitleDisplayMode = .never
//           navigationController?.navigationBar.prefersLargeTitles = false
//           navigationController?.navigationBar.isTranslucent = true
    }
    

        func failed() {
            let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            captureSession = nil
        }

    

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            captureSession.stopRunning()

            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                found(code: stringValue)
            }

            dismiss(animated: true)
        }

        func found(code: String) {
            print(code)
        }

        override var prefersStatusBarHidden: Bool {
            return true
        }

        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }*/
    }
    
