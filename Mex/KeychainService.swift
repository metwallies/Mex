//
//  KeychainService.swift
//  Mex
//
//  Created by islam metwally on 01.05.24.
//

import Foundation
import Security

protocol KeychainServicing {
    func saveToKeychain(service: String, key: String, value: String)
    func loadFromKeychain(service: String, key: String) -> String?
}

extension KeychainServicing {
    func saveToKeychain(service: String, key: String, value: String) {
        if let data = value.data(using: .utf8) {
            let query = [
                kSecClass as String: kSecClassGenericPassword as String,
                kSecAttrService as String: service,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ] as CFDictionary

            SecItemDelete(query)

            let status = SecItemAdd(query, nil)
            guard status == errSecSuccess else {
                print("Error saving to Keychain: \(status)")
                return
            }
        }
    }

    func loadFromKeychain(service: String, key: String) -> String? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        guard status == errSecSuccess else {
            print("Error loading from Keychain: \(status)")
            return nil
        }

        guard let data = result as? Data,
              let value = String(data: data, encoding: .utf8) else {
            print("Error decoding data from Keychain")
            return nil
        }

        return value
    }
}


struct KeychainService: KeychainServicing {}
