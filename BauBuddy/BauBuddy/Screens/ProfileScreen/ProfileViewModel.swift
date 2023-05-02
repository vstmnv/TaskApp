//
//  ProfileViewModel.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

final class ProfileViewModel {

	// MARK: - Public

	func logOut() {
		KeychainManager.shared.removeToken()
		ControllerManager.shared.switchRoot(screen: .login)
	}
}
