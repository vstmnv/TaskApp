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

	func getUserInfo() -> UserInfo? {
		guard let data = UserDefaults.standard.data(forKey: Constant.userInfoKey) else {
			return nil
		}
		return try? JSONDecoder().decode(UserInfo.self, from: data)
	}

	func setUserInfo(_ userInfo: UserInfo) {
		if let data = try? JSONEncoder().encode(userInfo) {
			UserDefaults.standard.set(data, forKey: Constant.userInfoKey)
		}
	}
}
