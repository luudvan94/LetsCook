//
//  NetworkClientTests.swift
//  SharedNetworkTests
//
//  Created by Luu Van on 6/21/23.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift
import Dependencies
@testable import SharedNetwork

final class NetworkClientTests: XCTestCase {
	var networkClient: NetworkClient!

	override func setUp() {
		super.setUp()
		networkClient = NetworkClient()
	}

	override func tearDown() {
		super.tearDown()
		HTTPStubs.removeAllStubs()
	}

	func testSuccessfulRequest() async {
		// Prepare
		let expectedData = "Successful data".data(using: .utf8)!
		stub(condition: isHost("mock.url")) { _ in
			return HTTPStubsResponse(data: expectedData, statusCode: 200, headers: nil)
		}

		let endpoint = withDependencies {
			$0.environmentProvider = EnvironmentProvider(jsonFileName: "testEnvironment", bundle: Bundle(for: type(of: self)))!
			$0.endpointProvider = EndpointProvider(jsonFileName: "testEndpoints", bundle: Bundle(for: type(of: self)))!
		} operation: {
			ServiceEndpoint(name: "success")
		}

		guard let endpoint = endpoint else {
			XCTFail("endpoint is not available")
			return
		}
		// Execute
		do {
			let data = try await networkClient.performRequest(for: endpoint)
			// Assert
			XCTAssertEqual(data, expectedData, "The data is not as expected.")
		} catch {
			XCTFail("The request failed with error: \(error)")
		}
	}

	func testErrorResponse() async {
		// Prepare
		stub(condition: isHost("mock.url")) { _ in
			return HTTPStubsResponse(data: Data(), statusCode: 500, headers: nil)
		}

		let endpoint = withDependencies {
			$0.environmentProvider = EnvironmentProvider(jsonFileName: "testEnvironment", bundle: Bundle(for: type(of: self)))!
			$0.endpointProvider = EndpointProvider(jsonFileName: "testEndpoints", bundle: Bundle(for: type(of: self)))!
		} operation: {
			ServiceEndpoint(name: "error")
		}

		guard let endpoint = endpoint else {
			XCTFail("endpoint is not available")
			return
		}

		// Execute
		do {
			_ = try await networkClient.performRequest(for: endpoint)
			XCTFail("The request should have failed.")
		} catch NetworkError.serverError(let statusCode) {
			// Assert
			XCTAssertEqual(statusCode, 500, "The status code is not as expected.")
		} catch {
			XCTFail("The error is not as expected.")
		}
	}
}
