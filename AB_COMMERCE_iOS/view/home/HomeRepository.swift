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
  
  func getHomeFirstData() -> Observable<([Banners], [Goods])> {
    return self.provider.rx.request(.productList())
      .map(Home.self)
      .flatMap{ homeData -> Single<([Banners], [Goods])> in
        let banners = homeData.banners ?? []
        let goods = homeData.goods ?? []
        return .just((banners, goods))
      }
      .asObservable()
  }
  
  func getHomeProductList(lastId: Int) -> Observable<[Goods]> {
    return self.provider.rx.request(.productList(lastId: lastId))
      .map(Home.self)
      .flatMap{ homeData -> Single<[Goods]> in
        let goods = homeData.goods ?? []
        return .just(goods)
      }
      .asObservable()
  }
  
}
