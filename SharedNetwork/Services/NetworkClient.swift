//
//  NetworkClient.swift
//  SharedNetwork
//
//  Created by Luu Van on 6/21/23.
//

import Foundation

public final class NetworkClient {
	func performRequest(for endpoint: Endpoint) async throws -> Data {
		var urlComponents = URLComponents()
		urlComponents.scheme = endpoint.baseURL.scheme
		urlComponents.host = endpoint.baseURL.host
		urlComponents.path = endpoint.path
		guard let url = urlComponents.url else {
			throw NetworkError.invalidURL
		}

		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = endpoint.httpMethod.rawValue
		urlRequest.httpBody = endpoint.body
		urlRequest.allHTTPHeaderFields = endpoint.headers
		if let authorization = endpoint.authorization {
			urlRequest.allHTTPHeaderFields?.merge(authorization) { (_, new) in new }
		}

		let (data, response) = try await URLSession.shared.data(for: urlRequest)
		guard let httpResponse = response as? HTTPURLResponse else {
			throw NetworkError.serverError(statusCode: nil)
		}

		guard 200..<300 ~= httpResponse.statusCode else {
			throw NetworkError.serverError(statusCode: httpResponse.statusCode)
		}

		return data
	}
}

enum NetworkError: Error {
	case invalidURL
	case serverError(statusCode: Int?)
	// Add any other errors you might encounter
}
