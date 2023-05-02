//
//  KeychainManager..swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation
import KeychainAccess

final class KeychainManager {

	private enum Key: String {
		case accessToken
	}

	private let keychain = Keychain(service: "com.vessy.BauBuddy")

	static let shared = KeychainManager()

	private init() {}

	var isLoggedIn: Bool {
		getToken() != nil
	}

	func setToken(token: String) {
		keychain[Key.accessToken.rawValue] = token
	}

	func removeToken() {
		keychain[Key.accessToken.rawValue] = nil
	}

	func getToken() -> String? {
		return keychain[Key.accessToken.rawValue]
	}
}
