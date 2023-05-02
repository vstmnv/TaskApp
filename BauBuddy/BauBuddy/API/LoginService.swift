//
//  LoginService.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

final class LoginService {
	
	func login(username: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
		let apiManager = APIManager()
		let input = LoginInput(username: username, password: password)
		let apiRequest = APIRequest<LoginInput, LoginResponse>(path: "login")
		
		apiManager.run(request: apiRequest, input: input, httpMethod: .post, completion: completion)
	}
}
