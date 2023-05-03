//
//  TasksViewModel.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

final class TasksViewModel {

	private var allTasks: [TaskResponse] = []
	@Published private(set) var tasks: [TaskResponse] = []
	@Published private(set) var errorMessage: String?

	// MARK: - Private

	private func containsSearchText(task: TaskResponse, searchText: String) -> Bool {
		let properties = [
			task.task,
			task.title,
			task.description,
			task.sort,
			task.wageType,
			task.businessUnit,
			task.parentTaskID,
			task.colorCode
		]

		return properties.contains { property in
			property.localizedCaseInsensitiveContains(searchText)
		}
	}

	private func forceLogOut() {
		KeychainManager.shared.removeToken()
		ControllerManager.shared.switchRoot(screen: .login)
	}

	// MARK: - Public

	func searchTasks(searchText: String) {
		if searchText.isEmpty {
			tasks = allTasks
		} else {
			tasks = allTasks.filter { task in
				return containsSearchText(task: task, searchText: searchText)
			}
		}
	}

	func getTasks() {
		let taskService = TaskService()
		taskService.getTasks { [weak self] response in
			switch response {
			case .success(let tasks):
				self?.allTasks = tasks
				self?.tasks = tasks
			case .failure(let error):
				if let error = error as? ErrorResponse, error.error.code == 401 {
					self?.forceLogOut()
				}
				self?.errorMessage = error.localizedDescription
			}
		}
	}

	func cellViewModel(at indexPath: IndexPath) -> TaskCellViewModel {
		return TaskCellViewModel(task: tasks[indexPath.row])
	}
}
