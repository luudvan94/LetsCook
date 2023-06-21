//
//  EnvironmentInfo.swift
//  SharedNetwork
//
//  Created by Luu Van on 6/21/23.
//

import Foundation

public struct EnvironmentInfo: Codable {
	public let baseURL: URL
	public let headers: [String: String]?
	public let authTokenKey: String?
}
