//
//  Token.swift
//  Color
//
//  Created by 장서영 on 2021/11/02.
//

import Foundation

struct Token {
    enum TokenType {
        case access
        case refresh
    }
    
    static var confirmToken: Tokens? {
        return TokenUtils.shared.load()
    }
    
    static func confirmAccessToken() -> Bool {
        let value = confirmToken?.accessToken != nil ? true : false
        return value
    }
    
    static func confirmRefreshToken() -> Bool {
        let value = confirmToken?.refreshToken != nil ? true : false
        return value
    }
    
    static func removeTokens(){
        TokenUtils.shared.delete()
    }
}
