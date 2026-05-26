//
//  CombineMemoryManagementViewController.swift
//  iOS-Combine-Examples
//
//  Created by Zeeshan Waheed on 20/03/2026.
//

import Foundation
import UIKit
import Combine

final class CombineMemoryManagementViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()
    private var manualCancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Memory Management"
        view.backgroundColor = .systemBackground
    }

    @IBAction func runExample(_ sender: UIButton) {
        runMemoryExample()
    }

    // MARK: - Memory Management Example

    func runMemoryExample() {

        print("\n----- MEMORY MANAGEMENT -----")

        let publisher = ["A", "B", "C"].publisher

        print("Publisher created")

        // MARK: Case 1 - NOT stored

        publisher
            .handleEvents(receiveSubscription: { _ in
                print("Case 1: Subscriber attached")
            }, receiveCancel: {
                print("Case 1: Cancelled immediately (not stored)")
            })
            .sink { value in
                print("Case 1 received:", value)
            }

        print("Case 1 finished (no storage)\n")

        // MARK: Case 2 - Stored in cancellables

        publisher
            .handleEvents(receiveSubscription: { _ in
                print("Case 2: Subscriber attached")
            }, receiveCancel: {
                print("Case 2: Cancelled")
            })
            .sink { value in
                print("Case 2 received:", value)
            }
            .store(in: &cancellables)

        print("Case 2 stored in cancellables\n")

        // MARK: Case 3 - Manual cancellable

        manualCancellable = publisher
            .handleEvents(receiveSubscription: { _ in
                print("Case 3: Subscriber attached")
            }, receiveCancel: {
                print("Case 3: Manually cancelled")
            })
            .sink { value in
                print("Case 3 received:", value)
            }

        print("Case 3 stored manually")

        // Simulate manual cancel after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.manualCancellable?.cancel()
        }
    }
}
