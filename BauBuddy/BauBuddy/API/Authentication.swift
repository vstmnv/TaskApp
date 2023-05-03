//
//  Authentication.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

struct Authentication: Decodable {

	enum CodingKeys: String, CodingKey {
		case accessToken = "access_token"
	}

	let accessToken: String
}
