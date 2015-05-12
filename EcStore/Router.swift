//
//  Router.swift
//  EcStore
//
//  Created by takayama minoru on 2015/05/10.
//  Copyright (c) 2015年 minoru takayama. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "https://api.thebase.in/1"
    static let clientId = "eb6d3098e22806d424cf9f7afe610794"
    static let clientSecret = "8000e50038e59bb32c9dfb55f5dbd88b"
    static let code = "754efd17330019c4361713cdcf8ad55b"
    static let redirectUri = "http://taka.base.ec/"
    static var OAuthToken: String?

    
    case OAuth
    case ReOAuth
    case Items

    
    var method: Alamofire.Method {
        switch self {
        case .OAuth:
            return .POST
        case .ReOAuth:
            return .POST
        case .Items:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .OAuth:
            return "/oauth/token"
        case .ReOAuth:
            return "/oauth/token"
        case .Items:
            return "/items"
        }
    }
    
    var parameters: [String : AnyObject] {
        switch self {
        case .OAuth:
            return [
                "grant_type": "authorization_code",
                "client_id": Router.clientId,
                "client_secret": Router.clientSecret,
                "code": Router.code,
                "redirect_uri": Router.redirectUri
            ]
        case .ReOAuth:
            var userDefault = NSUserDefaults.standardUserDefaults()
            var refreshToken: String
            if let token = userDefault.objectForKey("refresh_token") as? String {
                refreshToken = token
            } else {
                refreshToken = "b43f4acb286f4f295f4ab39ad4242646"
            }
            return [
                "grant_type": "refresh_token",
                "client_id": Router.clientId,
                "client_secret": Router.clientSecret,
                "refresh_token": refreshToken,
                "redirect_uri": Router.redirectUri
            ]
        default:
            return ["":""]
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSURLRequest {
        let URL = NSURL(string: Router.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        println("0:\(parameters)")
        
        switch self {
        case .OAuth:
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
        case .ReOAuth:
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
        default:
            var userDefault = NSUserDefaults.standardUserDefaults()
            if let token = userDefault.objectForKey("access_token") as? String {
                mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        }
        return mutableURLRequest
    }
}