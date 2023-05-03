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

	private let refreshControl = UIRefreshControl()
	private var cancellables: [AnyCancellable] = []
	private let viewModel = TasksViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()

		viewModel.$tasks
			.receive(on: DispatchQueue.main)
			.sink { [weak self] _ in
				self?.tableView.reloadData()
				self?.refreshControl.endRefreshing()
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

		viewModel.getTasks(method: .localStorage)
		setupPullToRefresh()
	}

	// MARK: - Private

	private func setupPullToRefresh() {
		refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
		tableView.refreshControl = refreshControl
	}

	@objc private func refresh() {
		viewModel.getTasks(method: .server)
	}

	private func showAlert(message: String) {
		let alert = UIAlertController(title: "Tasks Failure", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
			self?.refreshControl.endRefreshing()
			self?.viewModel.handleError()
		})
		self.present(alert, animated: true, completion: nil)
	}

	// MARK: - IBAction

	@IBAction private func tapToDimiss(_ sender: UITapGestureRecognizer) {
		view.endEditing(true)
	}
}

// MARK: - UISearchBarDelegate

extension TasksViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		viewModel.searchTasks(searchText: searchText)
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
