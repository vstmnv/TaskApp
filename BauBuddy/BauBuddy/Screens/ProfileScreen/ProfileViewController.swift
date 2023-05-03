//
//  ProfileViewController.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import UIKit

class ProfileViewController: UIViewController {

	private let viewModel = ProfileViewModel()

	@IBOutlet private weak var personalNumberLabel: UILabel!
	@IBOutlet private weak var firstNameLabel: UILabel!
	@IBOutlet private weak var lastNameLabel: UILabel!
	@IBOutlet private weak var displayNameLabel: UILabel!
	@IBOutlet private weak var statusLabel: UILabel!
	@IBOutlet private weak var businessUnitLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		setupProfile()
	}

	// MARK: - Private

	private func setupProfile() {
		personalNumberLabel.text = viewModel.profile.personalNumber
		firstNameLabel.text = viewModel.profile.firstName
		lastNameLabel.text = viewModel.profile.lastName
		displayNameLabel.text = viewModel.profile.displayName
		statusLabel.text = viewModel.profile.status
		businessUnitLabel.text = viewModel.profile.businessUnit
	}

	// MARK: - IBAction

	@IBAction private func logOut(_ sender: UIButton) {
		viewModel.logOut()
	}
}
