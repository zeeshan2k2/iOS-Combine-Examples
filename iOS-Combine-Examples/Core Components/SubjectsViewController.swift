//
//  SubjectsViewController.swift
//  iOS-Combine-Examples
//
//  Created by Zeeshan Waheed on 17/03/2026.
//

import Foundation
import UIKit
import Combine

final class SubjectsViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()
    
    // Subject that will emit whatever the text field sends
    private let textSubject = PassthroughSubject<String, Never>()
    
    @IBOutlet weak var textField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Subjects"
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupSubscriber()
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        textField.borderStyle = .none
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.clipsToBounds = true

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = paddingView
        textField.rightViewMode = .always

        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    // MARK: - Setup Subscriber
    
    func setupSubscriber() {
        textSubject
            .sink { value in
                print("Subscriber received:", value)
            }
            .store(in: &cancellables)
        
        print("Subscriber attached to subject")
    }
    
    // MARK: - Text Changed
    
    @objc func textChanged() {
        guard let text = textField.text else { return }
        textSubject.send(text) // manually pushing value into the subject
    }
}
