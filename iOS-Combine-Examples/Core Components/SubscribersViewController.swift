//
//  SubscribersViewController.swift
//  iOS-Combine-Examples
//
//  Created by Zeeshan Waheed on 17/03/2026.
//

import Foundation
import UIKit
import Combine

final class SubscribersViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Subscribers"
        view.backgroundColor = .systemBackground
    }

    @IBAction func runExample(_ sender: UIButton) {
        runSubscribersExample()
    }

    // MARK: - Subscribers Example

    func runSubscribersExample() {

        print("\n----- SUBSCRIBERS -----")

        let publisher = ["A", "B", "C"].publisher

        print("Publisher created")

        publisher
            .handleEvents(receiveSubscription: { _ in
                print("Subscriber attached")
            })
            .sink(
                receiveCompletion: { completion in
                    print("Subscriber received completion:", completion)
                },
                receiveValue: { value in
                    print("Subscriber received value:", value)
                }
            )
            .store(in: &cancellables)

        print("Subscription stored")
    }
}
