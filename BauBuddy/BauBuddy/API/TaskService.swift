//
//  TaskService.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

final class TaskService {

	func getTasks(completion: @escaping (Result<[TaskResponse], Error>) -> Void) {
		let apiManager = APIManager()
		let apiRequest = APIRequest<EmptyInput, [TaskResponse]>(path: "v1/tasks/select")

		apiManager.run(request: apiRequest, httpMethod: .get, completion: completion)
	}
}
