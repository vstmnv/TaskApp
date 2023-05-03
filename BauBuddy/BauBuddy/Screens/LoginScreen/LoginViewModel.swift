//
//  LoginViewModel.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

class LoginViewModel: ObservableObject {

	@Published private(set) var errorMessage: String?
	@Published private(set) var isLoading = false

	func login(username: String?, password: String?) {
		guard let username, !username.isEmpty,
			  let password, !password.isEmpty else {
			errorMessage = "Both fields must be filled in."
			return
		}

		let loginService = LoginService()
		isLoading = true

		loginService.login(username: username, password: password) { [weak self] result in
			switch result {
			case .success(let loginResponse):
				UserManager.shared.authenticate(response: loginResponse)
				ControllerManager.shared.switchRoot(screen: .home)
			case .failure(let error):
				self?.errorMessage = error.localizedDescription
			}
			self?.isLoading = false
		}
	}
}
