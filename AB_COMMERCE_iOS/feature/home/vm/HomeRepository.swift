//
//  HomeRepository.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import Foundation

import Moya
import RxSwift
import RxCocoa

class HomeRepository {
  
  let provider = MoyaProvider<Commerce>()
  
}

extension HomeRepository {
  
  func getHomeData(lastId: Int? = nil) -> Observable<Home> {
    return self.provider.rx.request(.goodsList(lastId: lastId))
      .map(Home.self)
      .asObservable()
  }
  
}
