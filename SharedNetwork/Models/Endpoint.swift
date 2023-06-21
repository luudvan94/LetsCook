//
//  Endpoint.swift
//  SharedNetwork
//
//  Created by Luu Van on 6/21/23.
//

import Foundation

public protocol Endpoint {
	var baseURL: URL { get }
	var path: String { get }
	var httpMethod: HTTPMethod { get }
	var body: Data? { get }
	var authorization: [String: String]? { get }
	var headers: [String: String]? { get }
}

public enum HTTPMethod: String, Codable {
	case GET, POST, PUT, DELETE, PATCH
}
