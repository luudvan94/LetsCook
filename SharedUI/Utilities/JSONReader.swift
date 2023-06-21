//
//  JSONReader.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/20/23.
//

import Foundation

public class JSONReader {
	public enum JSONReaderError: Error {
		case fileNotFound
		case readingError(Error)
	}

	public static func readJSONFromFile<T: Decodable>(
		named fileName: String,
		fileType: String = "json",
		bundle: Bundle = .main
	) throws -> T {
		guard let fileURL = bundle.url(forResource: fileName, withExtension: fileType) else {
			throw JSONReaderError.fileNotFound
		}

		do {
			let jsonData = try Data(contentsOf: fileURL)
			let decoder = JSONDecoder()
			let object = try decoder.decode(T.self, from: jsonData)
			return object
		} catch {
			throw JSONReaderError.readingError(error)
		}
	}
}
