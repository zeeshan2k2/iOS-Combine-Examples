//
//  CombineNetworkingViewController.swift
//  iOS-Combine-Examples
//
//  Created by Zeeshan Waheed on 20/03/2026.
//

import Foundation
import UIKit
import Combine

final class CombineNetworkingViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Networking with Combine"
        view.backgroundColor = .systemBackground
    }

    @IBAction func runExample(_ sender: UIButton) {
        runNetworkingExample()
    }

    // MARK: - Model

    struct Post: Decodable {
        let id: Int
        let title: String
    }

    // MARK: - Networking Example

    func runNetworkingExample() {

        print("\n----- NETWORKING WITH COMBINE -----")

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {
            print("Invalid URL")
            return
        }

        print("URL created")

        // Publisher → Operators → Subscriber

        URLSession.shared.dataTaskPublisher(for: url)
            .handleEvents(
                receiveSubscription: { _ in
                    print("Subscription started")
                },
                receiveOutput: { output in
                    print("Raw response received")
                },
                receiveCompletion: { completion in
                    print("handleEvents completion:", completion)
                },
                receiveCancel: {
                    print("Request cancelled")
                }
            )
            .map(\.data)
            .decode(type: Post.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Request finished successfully")
                    case .failure(let error):
                        print("Error:", error)
                    }
                }, receiveValue: { post in
                    print("Decoded Post:")
                    print("ID:", post.id)
                    print("Title:", post.title)
                }
            )
            .store(in: &cancellables)

        print("Subscription stored")
    }
}
