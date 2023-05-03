//
//  UserInfo.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

struct UserInfo: Codable {
	let personalNo: Int
	let firstName: String
	let lastName: String
	let displayName: String
	let active: Bool
	let businessUnit: String
}
