//
//  Commerce.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import Foundation

import Moya

enum Commerce {
  case productList(lastId: Int? = nil)
}

extension Commerce: TargetType {
  
  var baseURL: URL {
    guard let url = URL(string: BASE_URL) else {
      fatalError("FAILED: \(BASE_URL)")
    }
    
    return url
  }
  
  var path: String {
    switch self {
    case let .productList(lastId):
      return lastId != nil ? "home/goods" : "home"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .productList:
      return .get
    }
  }
  
  var task: Task {
    switch self {
    case let .productList(lastId):
      if let lastId = lastId {
        var params: [String: Any] = [:]
        params["lastId"] = lastId
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
      }
      return .requestPlain
    }
  }
  
  var headers: [String: String]? {
    return nil
  }
  
}
