//
//  LocalStorageManager.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 3.05.23.
//

import Foundation

final class LocalStorageManager {

	private enum Constant {
		static let tasksFileName = "BauBuddyTasks"
	}

	static let shared = LocalStorageManager()

	private init() {}

	private var documentsURL: URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}

	private var tasksFilePath: URL {
		return documentsURL.appendingPathComponent(Constant.tasksFileName).appendingPathExtension("plist")
	}

	// MARK: - Public

	func save(tasks: [TaskResponse]) {
		let encoder = PropertyListEncoder()
		let tasksData = try? encoder.encode(tasks)

		do {
			try tasksData?.write(to: tasksFilePath, options: .atomic)
		} catch {
			print(error)
			print(error.localizedDescription)
		}
	}

	func getTasks() -> [TaskResponse] {
		let decoder = PropertyListDecoder()

		if let tasksData = try? Data(contentsOf: tasksFilePath) {
			return (try? decoder.decode([TaskResponse].self, from: tasksData)) ?? []
		} else {
			return []
		}
	}

	func clear() {
		try? FileManager.default.removeItem(at: tasksFilePath)
	}
}
