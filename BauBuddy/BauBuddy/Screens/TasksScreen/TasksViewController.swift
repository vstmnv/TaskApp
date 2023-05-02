//
//  TasksViewController.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import UIKit
import Combine

final class TasksViewController: UIViewController {

	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var searchBar: UISearchBar!

	private var cancellables: [AnyCancellable] = []
	private let viewModel = TasksViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()

		viewModel.$tasks
			.receive(on: DispatchQueue.main)
			.sink { [weak self] _ in
				self?.tableView.reloadData()
			}
			.store(in: &cancellables)

		viewModel.$errorMessage
			.receive(on: DispatchQueue.main)
			.sink { [weak self] errorMessage in
				if let errorMessage {
					self?.showAlert(message: errorMessage)
				}
			}
			.store(in: &cancellables)

		viewModel.getTasks()
	}

	// MARK: - Private

	private func showAlert(message: String) {
		let alert = UIAlertController(title: "Tasks Failure", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
}

// MARK: - UITableViewDataSource

extension TasksViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.tasks.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.taskCell, for: indexPath) else {
			return UITableViewCell()
		}

		cell.configure(viewModel: viewModel.cellViewModel(at: indexPath))

		return cell
	}
}
