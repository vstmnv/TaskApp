//
//  AppConstants.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

enum API {
	static let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String
	static let accessToken = Bundle.main.object(forInfoDictionaryKey: "ACCESS_TOKEN") as? String
}
