//
//  KeyChain.swift
//  Color
//
//  Created by 장서영 on 2021/11/02.
//

import Security
import Alamofire

final class TokenUtils {
    
    static let shared = TokenUtils()
    
    private let account = "Color"
    private let service = Bundle.main.bundleIdentifier
    
    private lazy var query: [CFString: Any]? = {
        guard let service = service else {
            return nil
        }
        return [kSecClass: kSecClassGenericPassword,
          kSecAttrService: service,
          kSecAttrAccount: account]
    }()
    
    func save(_ user: Tokens) -> Bool {
        guard let data = try? JSONEncoder().encode(user) else { return false }
        guard let service = service else { return false }
        
        let keyChainQurey: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                          kSecAttrService: service,
                                          kSecAttrAccount: account,
                                          kSecAttrGeneric: data]
        
        let status: OSStatus = SecItemAdd(keyChainQurey as CFDictionary, nil)
        assert(status == noErr, "failed to save Tokens")
        return status == errSecSuccess
    }
    
    func load() -> Tokens? {
        let keyChinQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service!,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ]
        
        var dataTypeRef: CFTypeRef?
        let status = SecItemCopyMatching(keyChinQuery, &dataTypeRef)
        
        if status == errSecSuccess {
            let item = dataTypeRef as! Data
            let value = try? JSONDecoder().decode(Tokens.self, from: item)
            return value
        } else {
            return nil
        }
    }
    
    func delete() -> Bool {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service!,
            kSecAttrAccount: account
        ]
        
        let status = SecItemDelete(keyChainQuery)
        return status == errSecSuccess
    }
}
