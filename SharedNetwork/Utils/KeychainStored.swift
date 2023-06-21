//
//  KeychainStored.swift
//  SharedNetwork
//
//  Created by Luu Van on 6/21/23.
//

import Foundation
import KeychainAccess

@propertyWrapper
struct KeychainStored {
	let key: String
	let keychain = Keychain(service: "com.yourapp.identifier")

	var wrappedValue: String? {
		get {
			return try? keychain.getString(key)
		}
		set {
			if let newValue = newValue {
				try? keychain.set(newValue, key: key)
			} else {
				try? keychain.remove(key)
			}
		}
	}
}
