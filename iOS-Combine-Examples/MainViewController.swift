//
//  ViewController.swift
//  iOS-Combine-Examples
//
//  Created by Zeeshan Waheed on 17/03/2026.
//

import UIKit

class MainMenuViewController: UITableViewController {

    let storyboardRef = UIStoryboard(name: "Main", bundle: nil)

    let sections = [
        ("Combine", [
            "Combine Basics",
            "Publisher → Subscriber Model"
        ]),
        ("Core Components", [
            "Publishers",
            "Subscribers",
            "Subjects"
        ]),
        ("Operators", [
            "Operators"
        ]),
        ("Combining Streams", [
            "Combine Publishers"
        ]),
        ("Error Handling", [
            "Handling Errors"
        ]),
        ("Practical Examples", [
            "Networking with Combine",
            "Timer Publisher",
            "UI Binding"
        ]),
        ("Memory Management", [
            "AnyCancellable & store(in:)"
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Combine Examples"

        tableView = UITableView(frame: .zero, style: .insetGrouped)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        sections[section].1.count
    }

    override func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        sections[section].0
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = sections[indexPath.section].1[indexPath.row]
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 && indexPath.row == 0 {
            
            let vc = storyboardRef.instantiateViewController(
                withIdentifier: "CombineBasicsViewController"
            ) as! CombineBasicsViewController
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.section == 0 && indexPath.row == 1 {
            
            let vc = storyboardRef.instantiateViewController(
                withIdentifier: "PublisherSubscriberViewController"
            ) as! PublisherSubscriberViewController
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.section == 1 && indexPath.row == 0 {

            let vc = storyboardRef.instantiateViewController(
                withIdentifier: "PublishersViewController"
            ) as! PublishersViewController

            navigationController?.pushViewController(vc, animated: true)

        } else if indexPath.section == 1 && indexPath.row == 1 {
            
            let vc = storyboardRef.instantiateViewController(
                withIdentifier: "SubscribersViewController"
            ) as! SubscribersViewController
            
            navigationController?.pushViewController(vc, animated: true)

        } else if indexPath.section == 1 && indexPath.row == 2 {
            
            let vc = storyboardRef.instantiateViewController(
                withIdentifier: "SubjectsViewController"
            ) as! SubjectsViewController
            
            navigationController?.pushViewController(vc, animated: true)

        } else if indexPath.section == 2 && indexPath.row == 0 {
            
            let vc = storyboardRef.instantiateViewController(
                withIdentifier: "OperatorsViewController"
            ) as! OperatorsViewController
            
            navigationController?.pushViewController(vc, animated: true)

        } else if indexPath.section == 3 && indexPath.row == 0 {
            
            let vc = storyboardRef.instantiateViewController(
                withIdentifier: "CombineStreamsViewController"
            ) as! CombineStreamsViewController
            
            navigationController?.pushViewController(vc, animated: true)

        } else if indexPath.section == 4 && indexPath.row == 0 {
            
            let vc = storyboardRef.instantiateViewController(
                withIdentifier: "CombineErrorHandlingViewController"
            ) as! CombineErrorHandlingViewController
            
            navigationController?.pushViewController(vc, animated: true)

        } else if indexPath.section == 5 && indexPath.row == 0 {
            
            let vc = storyboardRef.instantiateViewController(
                withIdentifier: "CombineNetworkingViewController"
            ) as! CombineNetworkingViewController
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.section == 5 && indexPath.row == 1 {
            
            let vc = storyboardRef.instantiateViewController(
                withIdentifier: "TimerPublisherViewController"
            ) as! TimerPublisherViewController
            
            navigationController?.pushViewController(vc, animated: true)

        } else if indexPath.section == 5 && indexPath.row == 2 {
            
            let vc = storyboardRef.instantiateViewController(
                withIdentifier: "CombineUIBindingViewController"
            ) as! CombineUIBindingViewController
            
            navigationController?.pushViewController(vc, animated: true)

        } else if indexPath.section == 6 && indexPath.row == 0 {

            let vc = storyboardRef.instantiateViewController(
                withIdentifier: "CombineMemoryManagementViewController"
            ) as! CombineMemoryManagementViewController

            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
