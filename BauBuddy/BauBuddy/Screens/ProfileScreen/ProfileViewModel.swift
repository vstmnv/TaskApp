//
//  ProfileViewModel.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

final class ProfileViewModel {

	private enum Constant {
		static let empty = "-"
	}

	struct Profile {
		let personalNumber: String
		let firstName: String
		let lastName: String
		let displayName: String
		let status: String
		let businessUnit: String
	}

	let profile: Profile

	init() {
		let userInfo = UserManager.shared.getUserInfo()
		profile = Profile(
			personalNumber: String(userInfo?.personalNo ?? 0),
			firstName: userInfo?.firstName ?? Constant.empty,
			lastName: userInfo?.lastName ?? Constant.empty,
			displayName: userInfo?.displayName ?? Constant.empty,
			status: (userInfo?.active ?? false) ? "Active" : "Inactive",
			businessUnit: userInfo?.businessUnit ?? Constant.empty
		)
	}

	// MARK: - Public

	func logOut() {
		KeychainManager.shared.removeToken()
		ControllerManager.shared.switchRoot(screen: .login)
	}
}
