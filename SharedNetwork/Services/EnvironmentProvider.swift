//
//  EnvironmentProvider.swift
//  SharedNetwork
//
//  Created by Luu Van on 6/21/23.
//

import Foundation
import Dependencies

public final class EnvironmentProvider {
	public let environment: EnvironmentInfo

	init?(jsonFileName: String, bundle: Bundle = .main) {
		guard let url = bundle.url(forResource: jsonFileName, withExtension: "json"),
			  let data = try? Data(contentsOf: url),
			  let environment = try? JSONDecoder().decode(EnvironmentInfo.self, from: data)
		else {
			return nil
		}

		self.environment = environment
	}
}

extension EnvironmentProvider: DependencyKey {
	public static var liveValue = EnvironmentProvider(jsonFileName: "test")
}

extension DependencyValues {
  var environmentProvider: EnvironmentProvider? {
	get { self[EnvironmentProvider.self] }
	set { self[EnvironmentProvider.self] = newValue }
  }
}
