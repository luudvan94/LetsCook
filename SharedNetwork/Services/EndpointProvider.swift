//
//  EndpointProvider.swift
//  SharedNetwork
//
//  Created by Luu Van on 6/21/23.
//

import Foundation
import Dependencies

public final class EndpointProvider {
	private let endpoints: [EndpointInfo]

	public init?(jsonFileName: String, bundle: Bundle = .main) {
		guard let url = bundle.url(forResource: jsonFileName, withExtension: "json") else {
			print("\(jsonFileName).json can not be found")
			return nil
		}

		guard let data = try? Data(contentsOf: url) else {
			print("Data can not be initialized")
			return nil
		}

		guard let endpoints = try? JSONDecoder().decode([EndpointInfo].self, from: data) else {
			print("EndpointInfo can not be decoded")
			return nil
		}
		print(endpoints)
		self.endpoints = endpoints
	}

	public func endpointInfo(forName name: String) -> EndpointInfo? {
		return endpoints.first(where: { $0.name == name })
	}
}

extension EndpointProvider: DependencyKey {
	public static var liveValue = EndpointProvider(jsonFileName: "test")
}

extension DependencyValues {
  var endpointProvider: EndpointProvider? {
	get { self[EndpointProvider.self] }
	set { self[EndpointProvider.self] = newValue }
  }
}
