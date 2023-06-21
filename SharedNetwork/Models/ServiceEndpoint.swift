//
//  BaseEndpoint.swift
//  SharedNetwork
//
//  Created by Luu Van on 6/21/23.
//

import Foundation
import KeychainAccess
import Dependencies

struct ServiceEndpoint: Endpoint {
	@Dependency(\.environmentProvider) var environmentProvider
	@Dependency(\.endpointProvider) var endpointProvider

	private var environment: EnvironmentInfo?
	private var info: EndpointInfo?

	init?(name: String) {
		guard let nonNilInfo = endpointProvider?.endpointInfo(forName: name) else {
			return nil
		}

		guard let nonNilEnvironment = environmentProvider?.environment else {
			return nil
		}
		environment = nonNilEnvironment
		info = nonNilInfo
	}

	public var baseURL: URL {
		return environment?.baseURL ?? URL(string: "http://localhost")! // replace with your default URL
	}

	public var path: String {
		return info?.path ?? "" // replace with your default path
	}

	public var httpMethod: HTTPMethod {
		return info?.httpMethod ?? .GET // replace with your default HTTPMethod
	}

	public var body: Data? {
		return nil // Implement as needed
	}

	@KeychainStored(key: "authToken")
	var authToken: String?

	public var authorization: [String: String]? {
		guard let token = authToken else {
			return nil
		}
		return ["Authorization": "Bearer \(token)"]
	}

	public var headers: [String: String]? {
		// This combines the environment headers with the endpoint-specific headers.
		// If a header is defined in both places, the endpoint-specific header will be used.
		return environment?.headers?.merging(info?.headers ?? [:]) { (_, new) in new }
	}
}
