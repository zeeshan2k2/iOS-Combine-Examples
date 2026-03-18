//
//  PublishersViewController.swift
//  iOS-Combine-Examples
//
//  Created by Zeeshan Waheed on 17/03/2026.
//

import Foundation
import UIKit
import Combine

final class PublishersViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Publishers"
        view.backgroundColor = .systemBackground
    }

    @IBAction func runExample(_ sender: UIButton) {
        runPublishersExample()
    }

    // MARK: - Publishers Example

    func runPublishersExample() {

        print("\n----- PUBLISHERS -----")

        // MARK: Just Publisher (single value)

        Just("Hello Combine")
            .sink { value in
                print("Just emitted:", value)
            }
            .store(in: &cancellables)


        // MARK: Sequence Publisher (multiple values)

        [1, 2, 3].publisher
            .sink { value in
                print("Array publisher emitted:", value)
            }
            .store(in: &cancellables)


        // MARK: Future Publisher (network request)

        fetchUser()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Network request finished")

                    case .failure(let error):
                        print("Network request failed:", error)
                    }
                },
                receiveValue: { user in
                    print("Got user:", user.name, user.email)
                }
            )
            .store(in: &cancellables)
    }

    // MARK: - Models

    struct User: Decodable {
        let name: String
        let email: String
    }

    enum NetworkError: Error {
        case invalidURL
        case requestFailed
    }

    // MARK: - Future Publisher

    func fetchUser() -> Future<User, NetworkError> {

        return Future { promise in

            guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/1") else {
                promise(.failure(.invalidURL))
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in

                if error != nil {
                    promise(.failure(.requestFailed))
                    return
                }

                guard let data = data,
                      let user = try? JSONDecoder().decode(User.self, from: data) else {
                    promise(.failure(.requestFailed))
                    return
                }

                promise(.success(user))

            }.resume()
        }
    }
}
