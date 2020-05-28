//
//  ViewController.swift
//  VirtualLine Admin
//
//  Created by Benedikt Langer on 04.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    func setUpUI() {
        let userImage = UIImageView(image: UIImage(named: "user.png"))
        let userBarButton = UIBarButtonItem(customView: userImage)
        self.navigationItem.rightBarButtonItem = userBarButton

        let presentationModeImage = UIImageView(image: UIImage(named: "video-player.png"))
        let presentationModeBarButton = UIBarButtonItem(customView: presentationModeImage)
        self.navigationItem.leftBarButtonItem = presentationModeBarButton
    }
}
