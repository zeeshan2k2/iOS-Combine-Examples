//
//  CombineUIBindingViewController.swift
//  iOS-Combine-Examples
//
//  Created by Zeeshan Waheed on 20/03/2026.
//

import Foundation
import UIKit
import Combine

final class CombineUIBindingViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()

    // MARK: - UI

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!

    // MARK: - Subject

    private let textSubject = PassthroughSubject<String, Never>()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UI Binding"
        view.backgroundColor = .systemBackground

        setupBinding()
        setupUI()
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        textField?.borderStyle = .none
        textField?.layer.cornerRadius = 8
        textField?.layer.borderWidth = 1
        textField?.layer.borderColor = UIColor.systemGray4.cgColor
        textField?.clipsToBounds = true

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField?.frame.height ?? 0))
        textField?.leftView = paddingView
        textField?.leftViewMode = .always
        textField?.rightView = paddingView
        textField?.rightViewMode = .always
    }

    // MARK: - Setup Binding

    func setupBinding() {

        print("\n----- UI BINDING -----")

        // UITextField → Subject
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

        // Subject → Combine Pipeline → UI

        textSubject
            .handleEvents(
                receiveSubscription: { _ in
                    print("Subscriber attached")
                },
                receiveOutput: { value in
                    print("handleEvents output:", value)
                }
            )
            .map { text in
                text.uppercased()
            }
            .sink { [weak self] value in
                print("Subscriber received:", value)
                self?.label.text = value
            }
            .store(in: &cancellables)

        print("Binding setup complete")
    }

    // MARK: - UITextField Event

    @objc func textDidChange() {
        let text = textField.text ?? ""
        print("TextField emitted:", text)
        textSubject.send(text)
    }
}
