//
//  TaskCell.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import UIKit

final class TaskCell: UITableViewCell {

	@IBOutlet private weak var taskLabel: UILabel!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var descriptionLabel: UILabel!
	@IBOutlet private weak var colorCodeView: UIView!

	func configure(viewModel: TaskCellViewModel) {
		taskLabel.text = viewModel.task
		titleLabel.text = viewModel.title
		descriptionLabel.text = viewModel.description
		colorCodeView.backgroundColor = UIColor(hex: viewModel.color)
	}
}
