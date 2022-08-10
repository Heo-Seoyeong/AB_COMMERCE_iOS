//
//  Commerce.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import Foundation

import Moya

enum Commerce {
  case goodsList(lastId: Int? = nil)
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
    case let .goodsList(lastId):
      return lastId != nil ? "home/goods" : "home"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .goodsList:
      return .get
    }
  }
  
  var task: Task {
    switch self {
    case let .goodsList(lastId):
      if let lastId = lastId {
        let params: [String: Any] = ["lastId": lastId]
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
      }
      return .requestPlain
    }
  }
  
  var headers: [String: String]? {
    return nil
  }
  
}
