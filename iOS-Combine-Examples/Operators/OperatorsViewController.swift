//
//  OperatorsViewController.swift
//  iOS-Combine-Examples
//
//  Created by Zeeshan Waheed on 18/03/2026.
//

import Foundation
import UIKit
import Combine

final class OperatorsViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Operators"
        view.backgroundColor = .systemBackground
    }

    @IBAction func runExample(_ sender: UIButton) {
        runOperatorsExample()
    }

    // MARK: - Operators Example

    func runOperatorsExample() {

        print("\n----- OPERATORS -----")

        let numbers = [1, 2, 2, 3, 4, 5].publisher

        numbers
            .handleEvents(receiveOutput: { value in
                print("Original value:", value)
            })

            // MARK: Filter
            .filter { $0 % 2 == 0 }

            // MARK: Remove Duplicates
            .removeDuplicates()

            // MARK: Map
            .map { $0 * 10 }

            .sink(
                receiveCompletion: { completion in
                    print("Pipeline completed:", completion)
                },
                receiveValue: { value in
                    print("Subscriber received:", value)
                }
            )
            .store(in: &cancellables)
    }
}
