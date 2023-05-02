//
//  TasksViewModel.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

final class TasksViewModel {

	@Published private(set) var tasks: [TaskResponse] = []
	@Published private(set) var errorMessage: String?

	// MARK: - Public

	func getTasks() {
		let taskService = TaskService()
		taskService.getTasks { [weak self] response in
			switch response {
			case .success(let tasks):
				self?.tasks = tasks
			case .failure(let error):
				if let error = error as? ErrorResponse,
				   error.error.code == 401 {
					ControllerManager.shared.switchRoot(screen: .login)
				}
				self?.errorMessage = error.localizedDescription
			}
		}
	}

	func cellViewModel(at indexPath: IndexPath) -> TaskCellViewModel {
		return TaskCellViewModel(task: tasks[indexPath.row])
	}
}
