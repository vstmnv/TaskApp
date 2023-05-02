//
//  ProfileViewController.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import UIKit

class ProfileViewController: UIViewController {

	private let viewModel = ProfileViewModel()

	// MARK: - IBAction

	@IBAction private func logOut(_ sender: UIButton) {
		viewModel.logOut()
	}
}
