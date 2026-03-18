//
//  CombineBasicsViewController.swift
//  iOS-Combine-Examples
//
//  Created by Zeeshan Waheed on 17/03/2026.
//

import Foundation
import UIKit
import Combine

final class CombineBasicsViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Combine Basics"
        view.backgroundColor = .systemBackground
    }

    @IBAction func runExample(_ sender: UIButton) {

        runCombineBasicsExample()

    }

    // MARK: - Combine Basics Example

    func runCombineBasicsExample() {

        print("\n----- COMBINE BASICS -----")

        // MARK: Publisher

        let publisher = Just("Hello Combine")

        print("Publisher created")

        // MARK: Subscriber

        publisher
            .handleEvents(receiveSubscription: { _ in
                print("Subscriber attached")
            })
            .sink(
                receiveCompletion: { completion in
                    print("Completion received:", completion)
                },
                receiveValue: { value in
                    print("Value received:", value)
                }
            )
            .store(in: &cancellables)

        print("Subscription stored in cancellables")
    }
}
