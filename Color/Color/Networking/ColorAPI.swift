//
//  ColorAPI.swift
//  Color
//
//  Created by 장서영 on 2021/10/30.
//

import Moya
import Foundation

enum ColorAPI {
    // Auth API
    case login(_ email: String, _ password: String, _ device_token: String)
    case tokenRefresh
    case signUp(_ email: String, _ password: String, _ nickname: String)
    case confirmNickName(_ nickname: String)
    case sendEmail(_ email: String)
    case confirmEmail(_ email: String, _ code: String)
    
    // Post API
    case createPost(_ content: String, _ feel: String, _ hash_tag: [String])
    case deletePost(_ post_id: String)
    case patchPost(_ post_id: String, _ content: String, _ feel: String, _ hash_tag: [String])
    case postList(_ page: Int, _ feel: String)
    
    // Comment API
    case getComment(_ postId: String)
    case createComment(_ post_id: String, _ content: String)
    case deleteComment(_ commen_id: String, _ post_id: String)
    
    // like API
    case like(_ post_id: Int)
    
    // report API
    case report(_ id: String,_ type: String, _ reason: String, _ feel: String)
    
    // profile API
    case myPage(_ id: String, _ feel: String, _ filter: String, _ page: Int)
    case patchNickName(_ nickName: String)
    
}

extension ColorAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .like, .report, .myPage, .patchNickName:
            return URL(string: "http://13.209.8.210:5000")!
        default:
            return URL(string: "http://211.38.86.92:8009")!
        }
    }
    
    var path: String {
        switch self {
        case .login, .tokenRefresh:
            return "/auth"
        case .signUp:
            return "/user"
        case .confirmNickName(let nickname):
            return "/user/\(nickname)"
        case .sendEmail:
            return "/email"
        case .confirmEmail(let email, let code):
            return "/email/\(email)/\(code)"
        case .createPost:
            return "/post"
        case .deletePost(let post_id):
            return "/post/\(post_id)"
        case .patchPost(let post_id, _ , _ , _ ):
            return "/post/\(post_id)"
        case .postList(let page, let feel):
            return "/post//?page=\(page)&feel=\(feel)"
        case .getComment(let postId):
            return "/comment/\(postId)"
        case .createComment(let post_id, _ ):
            return "/comment/\(post_id)"
        case .deleteComment(let comment_id, let post_id):
            return "/comment/\(comment_id)/\(post_id)"
        case .like(let post_id):
            return "/like/?post_id=\(post_id)"
        case .report(let id, let type, _ , _ ):
            return "/report/?id=\(id)&type=\(type)"
        case .myPage(let id, let feel, let filter, let page):
            return "/profile/?id=\(id)&feel=\(feel)&filter=\(filter)&page=\(page)"
        case .patchNickName:
            return "/profile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .signUp, .sendEmail, .createPost, .createComment, .report:
            return .post
        case .tokenRefresh, .patchPost, .like, .patchNickName:
            return .put
        case .confirmNickName, .confirmEmail:
            return .head
        case .deletePost, .deleteComment:
            return .delete
        case .postList, .getComment, .myPage:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password, let device_token):
            return .requestParameters(parameters: ["email": email, "password": password, "device_token": device_token], encoding: JSONEncoding.prettyPrinted)
        case .signUp(let email, let password, let nickname):
            return .requestParameters(parameters: ["email": email, "password": password, "nickname": nickname], encoding: JSONEncoding.prettyPrinted)
        case .sendEmail(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.prettyPrinted)
        case .createPost(let content, let feel, let hash_tag):
            return .requestParameters(parameters: ["content": content, "feel": feel, "hash_tag": hash_tag], encoding: JSONEncoding.prettyPrinted)
        case .patchPost(_, let content, let feel, let hash_tag):
            return .requestParameters(parameters: ["content": content, "feel": feel, "hash_tag": hash_tag], encoding: JSONEncoding.prettyPrinted)
        case .createComment(_ , let content):
            return .requestParameters(parameters: ["content": content], encoding: JSONEncoding.prettyPrinted)
        case .report(_ , _ , let reason, let feel):
            return .requestParameters(parameters: ["reason": reason, "feel": feel], encoding: JSONEncoding.prettyPrinted)
        case .patchNickName(let nickname):
            return .requestParameters(parameters: ["nickname" : nickname], encoding: JSONEncoding.prettyPrinted)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .tokenRefresh:
            guard let refreshToken = Token.confirmToken?.refresh_token else {return nil}
            return ["Authorization" : "Bearer " + refreshToken ]
        default:
            guard let accessToken = Token.confirmToken?.access_token else {return nil}
            return ["Authorization" : "Bearer " + accessToken ]
        }
    }
    
    var validationType: Moya.ValidationType {
        return .successCodes
    }
    
    
}
