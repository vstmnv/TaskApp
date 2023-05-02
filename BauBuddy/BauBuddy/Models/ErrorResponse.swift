//
//  ErrorResponse.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

struct ErrorResponse: LocalizedError, Decodable {
	let error: BauBuddyError

	var errorDescription: String? {
		error.message
	}
}

struct BauBuddyError: Decodable {
	let code: Int
	let message: String
}
