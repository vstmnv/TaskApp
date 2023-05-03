//
//  UserManager.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 3.05.23.
//

import Foundation

final class UserManager {
	private enum Constant {
		static let userInfoKey = "userInfo"
	}

	static let shared = UserManager()
	private init() {}

	// MARK: - Public

	func getUserInfo() -> UserInfo? {
		guard let data = UserDefaults.standard.data(forKey: Constant.userInfoKey) else {
			return nil
		}
		return try? JSONDecoder().decode(UserInfo.self, from: data)
	}

	func authenticate(response: LoginResponse) {
		KeychainManager.shared.setToken(token: response.oauth.accessToken)
		setUserInfo(response.userInfo)
	}

	func deauthenticate() {
		LocalStorageManager.shared.clear()
		KeychainManager.shared.removeToken()
		removeUserInfo()
	}

	// MARK: - Private

	private func setUserInfo(_ userInfo: UserInfo) {
		if let data = try? JSONEncoder().encode(userInfo) {
			UserDefaults.standard.set(data, forKey: Constant.userInfoKey)
		}
	}

	private func removeUserInfo() {
		UserDefaults.standard.set(nil, forKey: Constant.userInfoKey)
	}
}
