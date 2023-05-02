//
//  BauBuddyResponse.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

struct LoginResponse: Decodable {
	let oauth: Authentication
	let userInfo: UserInfo
}
