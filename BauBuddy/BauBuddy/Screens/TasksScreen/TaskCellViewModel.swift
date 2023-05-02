//
//  TaskCellViewModel.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

final class TaskCellViewModel {

	private enum Constant {
		static let empty = "-"
	}

	let task: String
	let title: String
	let description: String
	let color: String

	init(task: TaskResponse) {
		self.task = task.task.isEmpty ? Constant.empty : task.task
		self.title = task.title.isEmpty ? Constant.empty : task.title
		self.description = task.description.isEmpty ? Constant.empty : task.description
		self.color = task.colorCode
	}
}
