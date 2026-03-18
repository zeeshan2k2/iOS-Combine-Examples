//
//  CombineStreamsViewController.swift
//  iOS-Combine-Examples
//
//  Created by Zeeshan Waheed on 18/03/2026.
//

import Foundation
import UIKit
import Combine

final class CombineStreamsViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()

    private let usernameSubject = PassthroughSubject<String, Never>()
    private let passwordSubject = PassthroughSubject<String, Never>()

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Combining Streams"
        view.backgroundColor = .systemBackground

        setupUI()
        setupCombine()
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        
        let textfields = [usernameField, passwordField]
        
        for textfield in textfields {
            textfield?.borderStyle = .none
            textfield?.layer.cornerRadius = 8
            textfield?.layer.borderWidth = 1
            textfield?.layer.borderColor = UIColor.systemGray4.cgColor
            textfield?.clipsToBounds = true

            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textfield?.frame.height ?? 0))
            textfield?.leftView = paddingView
            textfield?.leftViewMode = .always
            textfield?.rightView = paddingView
            textfield?.rightViewMode = .always
        }
    }

    // MARK: - Combine Setup

    func setupCombine() {

        print("CombineStreamsViewControllerLogs, setupCombine() called")

        usernameSubject
            .handleEvents(receiveOutput: { value in
                print("CombineStreamsViewControllerLogs, usernameSubject emitted:", value)
            })
            .combineLatest(
                passwordSubject.handleEvents(receiveOutput: { value in
                    print("CombineStreamsViewControllerLogs, passwordSubject emitted:", value)
                })
            )
            .handleEvents(receiveOutput: { username, password in
                print("CombineStreamsViewControllerLogs, combineLatest produced tuple:", username, password)
            })
            .sink { username, password in
                print("CombineStreamsViewControllerLogs, SINK received → Username:", username, "| Password:", password)
            }
            .store(in: &cancellables)

        print("CombineStreamsViewControllerLogs, Subscriber attached to combined stream")
    }

    // MARK: - Username Changed

    @IBAction func usernameChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        print("CombineStreamsViewControllerLogs, usernameChanged fired →", text)
        usernameSubject.send(text)
    }

    // MARK: - Password Changed

    @IBAction func passwordChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        print("CombineStreamsViewControllerLogs, passwordChanged fired →", text)
        passwordSubject.send(text)
    }
}
