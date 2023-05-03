//
//  TasksViewModel.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

final class TasksViewModel {

	private enum Constant {
		static let unauthorizedCode = 401
	}

	enum FetchMethod {
		case localStorage
		case server
	}

	private var allTasks: [TaskResponse] = []
	private var error: ErrorResponse?

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

	private func getLocallyStoredTasks() {
		let locallyStoredTasks = LocalStorageManager.shared.getTasks()

		if locallyStoredTasks.isEmpty {
			fetchTasks()
		} else {
			allTasks = locallyStoredTasks
			tasks = locallyStoredTasks
		}
	}

	private func fetchTasks() {
		let taskService = TaskService()
		taskService.getTasks { [weak self] response in
			switch response {
			case .success(let tasks):
				self?.allTasks = tasks
				self?.tasks = tasks
				LocalStorageManager.shared.save(tasks: tasks)
			case .failure(let error):
				self?.error = error as? ErrorResponse
				self?.errorMessage = error.localizedDescription
			}
		}
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

	func getTasks(method: FetchMethod) {
		switch method {
		case .localStorage:
			getLocallyStoredTasks()
		case .server:
			fetchTasks()
		}
	}

	func handleError() {
		if error?.error.code == Constant.unauthorizedCode {
			UserManager.shared.deauthenticate()
			ControllerManager.shared.switchRoot(screen: .login)
		}
	}

	func cellViewModel(at indexPath: IndexPath) -> TaskCellViewModel {
		return TaskCellViewModel(task: tasks[indexPath.row])
	}
}
