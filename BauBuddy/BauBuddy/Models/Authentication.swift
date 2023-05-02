//
//  Authentication.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

struct Authentication: Decodable {
	let access_token: String
	let expires_in: Int
	let token_type: String
	let refresh_token: String
}
