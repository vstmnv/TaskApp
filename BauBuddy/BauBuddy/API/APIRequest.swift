//
//  APIRequest.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

final class APIRequest<I: Encodable, O: Decodable> {
	let path: String
	let parameters: [String: Any]?

	init(path: String, parameters: [String: Any]? = nil) {
		self.path = path
		self.parameters = parameters
	}
}
