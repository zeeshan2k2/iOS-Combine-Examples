//
//  PublisherSubscriberViewController.swift
//  iOS-Combine-Examples
//
//  Created by Zeeshan Waheed on 17/03/2026.
//

import Foundation
import UIKit
import Combine

final class PublisherSubscriberViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Publisher → Subscriber"
        view.backgroundColor = .systemBackground
    }

    @IBAction func runExample(_ sender: UIButton) {

        runPublisherSubscriberExample()

    }

    // MARK: - Publisher → Subscriber Model

    func runPublisherSubscriberExample() {

        print("\n----- PUBLISHER → SUBSCRIBER MODEL -----")

        let numbers = [1, 2, 3, 4, 5]

        let publisher = numbers.publisher

        print("Publisher created from array")

        publisher
            .handleEvents(
                receiveSubscription: { _ in
                    print("Subscriber attached")
                },
                receiveOutput: { value in
                    print("Publisher emitted:", value)
                },
                receiveCompletion: { completion in
                    print("Publisher completed:", completion)
                }
            )
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
