//
//  CombineErrorHandlingViewController.swift
//  iOS-Combine-Examples
//
//  Created by Zeeshan Waheed on 18/03/2026.
//

import Foundation
import UIKit
import Combine

final class CombineErrorHandlingViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Error Handling"
        view.backgroundColor = .systemBackground
    }

    @IBAction func runExample(_ sender: UIButton) {
        runErrorHandlingExample()
    }

    // MARK: - Error Handling Example

    func runErrorHandlingExample() {

        print("\n----- ERROR HANDLING -----")

        let numbers = [10, 5, 0, 2].publisher

        numbers
            .tryMap { number -> Int in
                print("Processing number:", number)

                if number == 0 {
                    throw DivisionError.divideByZero
                }

                return 100 / number
            }

            .catch { error -> Just<Int> in
                print("Error occurred:", error)

                return Just(-1)
            }

            .sink(
                receiveCompletion: { completion in
                    print("Pipeline completion:", completion)
                },
                receiveValue: { value in
                    print("Subscriber received:", value)
                }
            )
            .store(in: &cancellables)
    }
}

// MARK: - Custom Error

enum DivisionError: Error {
    case divideByZero
}
