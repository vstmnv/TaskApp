//
//  APIManager.swift
//  BauBuddy
//
//  Created by Vesela Stamenova on 2.05.23.
//

import Foundation

final class APIManager {
	
	private enum Constant {
		static let authorizationHeader = "Authorization"
		static let contentTypeKey = "Content-Type"
		static let contentType = "application/json"
	}
	
	enum HTTPMethod: String {
		case get
		case post
		case put
		case delete
		
		var value: String {
			return self.rawValue.uppercased()
		}
	}
	
	private let session = URLSession(configuration: .default)
	private var dataTask: URLSessionDataTask?
	
	func run<I: Encodable, O: Decodable>(
		request: APIRequest<I, O>,
		input: I? = nil,
		httpMethod: HTTPMethod = .get,
		completion: @escaping (Result<O, Error>) -> Void
	) {
		guard let baseURL = API.baseURL,
			  let accessToken = API.accessToken,
			  let url = URL(string: baseURL) else {
			completion(.failure(InternalError()))
			return
		}
		
		let urlWithPathAndQuery = url.appending(path: request.path)
		var request = URLRequest(url: urlWithPathAndQuery)
		request.httpMethod = httpMethod.value
		request.setValue(accessToken, forHTTPHeaderField: Constant.authorizationHeader)
		request.setValue(Constant.contentType, forHTTPHeaderField: Constant.contentTypeKey)
		
		if let input = input {
			do {
				request.httpBody = try JSONEncoder().encode(input)
			} catch {
				completion(.failure(error))
				return
			}
		}
		
		run(request: request) { data, error in
			if let error = error {
				completion(.failure(error))
			} else if let data = data {
				do {
					let decoded = try JSONDecoder().decode(O.self, from: data)
					completion(.success(decoded))
				} catch {
					do {
						let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: data)
						completion(.failure(decodedError))
					} catch {
						completion(.failure(error))
					}
					completion(.failure(error))
				}
			} else {
				completion(.failure(InternalError()))
			}
		}
		
		func run(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
			dataTask?.cancel()
			dataTask = session.dataTask(with: request) { data, _, error in
				DispatchQueue.main.async {
					completion(data, error)
				}
			}
			dataTask?.resume()
		}
	}
}

final class InternalError: Error {}
