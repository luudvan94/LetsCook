//
//  EndpointInfo.swift
//  SharedNetwork
//
//  Created by Luu Van on 6/21/23.
//

import Foundation

public struct EndpointInfo: Codable {
	public let name: String
	public let path: String
	public let httpMethod: HTTPMethod
	public let headers: [String: String]?
}
