//
//  ReqresEndpoint.swift
//  SaltCodeTest
//
//  Created by Chrismanto Natanail Manik on 13/11/22.
//

import Foundation

public enum ReqresAPI{
    case login
    case fetchData
}
extension ReqresAPI: EndPointType{
    var baseUrl: String {
        return "reqres.in"
    }
    
    var path: String {
        switch self {
        case .login:
            return "/api/login"
        case .fetchData:
            return "/api/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .fetchData:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type" : "application/json; charset=utf-8"]
    }
    
    
}
