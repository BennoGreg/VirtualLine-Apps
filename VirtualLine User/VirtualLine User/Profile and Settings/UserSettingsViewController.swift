//
//  UserSettingsViewController.swift
//  VirtualLine User
//
//  Created by Niklas Wagner on 09.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SettingsCell"

class UserSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Properties

    var tableView: UITableView!
    var userInfoHeader: UserInfoHeader!

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        // title = "User"
    }

    override func viewWillDisappear(_ animated: Bool) {
    }

    // MARK: - Helper Functions

    func configureTableView() {
        tableView = UITableView()
        let color = UIColor(displayP3Red: 6 / 255, green: 14 / 255, blue: 79 / 255, alpha: 1)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60

        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame

        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader = UserInfoHeader(frame: frame)
        tableView.tableHeaderView = userInfoHeader
        tableView.tableFooterView = UIView()
    }

    func configureUI() {
        configureTableView()

        parent?.title = "User"

        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true

        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

       
    }

    // MARK: TableView:

    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        switch section {
        case .profile:
            return ProfileOptions.allCases.count
        case .settings:
            return SettingsOptions.allCases.count
        case .aboutUs:
            return AboutUsOptions.allCases.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell

        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
            
        case .profile:
            let profile = ProfileOptions.init(rawValue: indexPath.row)
            cell.sectionType = profile
            
        case .settings:

            let setting = SettingsOptions.init(rawValue: indexPath.row)
            cell.sectionType = setting
        case .aboutUs:
            
            let aboutUs = AboutUsOptions.init(rawValue: indexPath.row)
              cell.sectionType = aboutUs
        }
        
        

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()

        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 24)
        title.textColor = .black
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true

        title.text = SettingsSection(rawValue: section)?.description

        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return}
        
        
        switch section {
            
        case .profile:
            
             print(ProfileOptions.init(rawValue: indexPath.row)?.description)
            
        case .settings:

            print(SettingsOptions.init(rawValue: indexPath.row)?.description)
           
        case .aboutUs:
            
            print(AboutUsOptions.init(rawValue: indexPath.row)?.description)
              
        }
    }
}
