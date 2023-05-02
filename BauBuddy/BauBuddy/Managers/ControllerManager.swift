//
//  ControllerManager.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import UIKit

final class ControllerManager {

	enum Screen {
		case home
		case login

		var storyboardName: String {
			switch self {
			case .home:
				return R.storyboard.tabBar.name
			case .login:
				return R.storyboard.loginScreen.name
			}
		}
	}

	static let shared = ControllerManager()

	private init() {}

	func switchRoot(screen: Screen) {
		guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
			  let window = sceneDelegate.window else {
			return
		}

		let storyboard = UIStoryboard(name: screen.storyboardName, bundle: nil)
		let viewController = storyboard.instantiateInitialViewController()
		window.rootViewController = viewController
	}
}
