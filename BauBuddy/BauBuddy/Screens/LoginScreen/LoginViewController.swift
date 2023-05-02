//
//  ViewController.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import UIKit
import Combine

class LoginViewController: UIViewController {

	@IBOutlet private weak var usernameTextField: UITextField!
	@IBOutlet private weak var passwordTextField: UITextField!

	private var cancellables: [AnyCancellable] = []
	private let viewModel = LoginViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.$errorMessage
			.receive(on: DispatchQueue.main)
			.sink { [weak self] errorMessage in
				if let errorMessage {
					self?.showAlert(message: errorMessage)
				}
			}
			.store(in: &cancellables)
	}

	private func showAlert(message: String) {
		let alert = UIAlertController(title: "Login Failure", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}

	@IBAction private func textFieldDidReturn(_ sender: UITextField) {
		switch sender {
		case usernameTextField:
			passwordTextField.becomeFirstResponder()
		case passwordTextField:
			sender.endEditing(true)
		default:
			break
		}
	}

	@IBAction private func tapGesture(_ sender: UITapGestureRecognizer) {
		view.endEditing(true)
	}

	@IBAction private func loginButtonTapped(_ sender: UIButton) {
		viewModel.login(username: usernameTextField.text, password: passwordTextField.text)
	}
}
