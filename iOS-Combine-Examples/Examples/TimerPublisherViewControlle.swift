//
//  TimerPublisherViewControlle.swift
//  iOS-Combine-Examples
//
//  Created by Zeeshan Waheed on 20/03/2026.
//

import Foundation
import UIKit
import Combine

final class TimerPublisherViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Timer Publisher"
        view.backgroundColor = .systemBackground
    }

    @IBAction func runExample(_ sender: UIButton) {
        runTimerExample()
    }

    // MARK: - Timer Example

    func runTimerExample() {

        print("\n----- TIMER PUBLISHER -----")

        let timerPublisher = Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()

        print("Timer publisher created")

        timerPublisher
            .handleEvents(
                receiveSubscription: { _ in
                    print("Subscription started")
                },
                receiveOutput: { date in
                    print("handleEvents output:", date)
                },
                receiveCancel: {
                    print("Timer cancelled")
                }
            )
            .sink { date in
                print("Timer emitted:", date)
            }
            .store(in: &cancellables)

        print("Subscription stored")
    }
}
