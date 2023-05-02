//
//  TaskResponse.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

struct TaskResponse: Decodable {

	enum CodingKeys: String, CodingKey {
		case task
		case title
		case description
		case sort
		case wageType
		case businessUnitKey = "BusinessUnitKey"
		case businessUnit
		case parentTaskID
		case colorCode
		case isAvailableInTimeTrackingKioskMode
	}

	let task: String
	let title: String
	let description: String
	let sort: String
	let wageType: String
	let businessUnitKey: String?
	let businessUnit: String
	let parentTaskID: String
	let colorCode: String
	let isAvailableInTimeTrackingKioskMode: Bool
}
