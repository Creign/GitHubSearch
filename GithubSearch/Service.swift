//
//  Service.swift
//  GithubSearch
//
//  Created by Excell on 15/07/2021.
//

import Foundation

import Moya

public class NetworkService {
    let provider = MoyaProvider<Service>()
}

public enum Service {
    case code(txt: String)
}

extension Service: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.github.com/search")!
    }
    
    public var path: String {
        switch self {
        case .code(let txt):
            return "/code?q=\(txt)+user:Creign"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return ServiceHeader.shared.keyPair
    }
}

enum ServiceHeader {
    case shared
}

extension ServiceHeader {
    var keyPair: [String: String] {
        switch self {
        case .shared:
            return ["Content-Type" : "application/json",
                    "Accept": "application/vnd.github.v3+json"]
        }
    }
}

