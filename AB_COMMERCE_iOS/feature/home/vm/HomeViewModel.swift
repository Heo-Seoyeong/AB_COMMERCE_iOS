//
//  HomeViewModel.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import Foundation

import RxSwift
import RxCocoa

enum ReloadType {
  case first, more, last
}

class HomeViewModel {
    
  //DisposeBag
  lazy var disposeBag = DisposeBag()
  
  var reloadAction: BehaviorSubject<ReloadType> = BehaviorSubject(value: .last)
  var wishValueChanged: PublishSubject<Goods> = PublishSubject()
  
  private(set) var banners: [Banners] = []
  private(set) var goods: [Goods] = []
  
  private let repository = HomeRepository()
  
  init() {
    self.setNotification()
  }
  
}

extension HomeViewModel {
  
  func getHomeData(lastId: Int? = nil) {
    if let lastId = lastId {
      self.repository.getHomeGoodsList(lastId: lastId)
        .subscribe { goodsList in
          guard !goodsList.isEmpty else {
            self.reloadAction.onNext(.last)
            return
          }

          self.goods += goodsList
          self.reloadAction.onNext(.more)
        } onError: { error in
          print("API Error : getHomeGoodsList : \(error.localizedDescription)")
        }
        .disposed(by: self.disposeBag)
    } else {
      self.repository.getHomeFirstData()
        .subscribe { bannersList, goodsList in
          self.banners = bannersList
          self.goods = goodsList
          self.reloadAction.onNext(.first)
        } onError: { error in
          print("API Error : getHomeFirstData : \(error.localizedDescription)")
        }
        .disposed(by: self.disposeBag)
    }
  }
  
}

extension HomeViewModel {
  
  private func setNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(didRecieveWishNotification(_:)), name: NSNotification.Name("WishDidTap"), object: nil)
  }
  
  @objc private func didRecieveWishNotification(_ notification: Notification) {
    if let userInfo = notification.userInfo,
       let id = userInfo["id"] as? Int,
       let goods = self.goods.first(where: { $0.id == id }) {
      GoodsWishRealm.shared.click(goods: goods)
      self.wishValueChanged.onNext(goods)
    }
  }
  
}
