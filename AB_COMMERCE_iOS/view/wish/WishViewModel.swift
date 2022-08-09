//
//  WishViewModel.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/09.
//

import Foundation

import RxSwift
import RxCocoa

class WishViewModel {
  
  //DisposeBag
  lazy var disposeBag = DisposeBag()
  
  var reloadAction: BehaviorSubject<ReloadType> = BehaviorSubject(value: .last)
  var wishValueChanged: PublishSubject<Int?> = PublishSubject()
  
  private(set) var goods: [Goods] = []
  
  init() {
    self.setNotification()
  }
  
}

extension WishViewModel {
  
  func getRefresh() {
    self.goods = GoodsWishRealm.shared.read()
    self.reloadAction.onNext(.last)
  }
  
}

extension WishViewModel {
  
  private func setNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(didRecieveWishNotification(_:)), name: NSNotification.Name("WishDidTap"), object: nil)
  }
  
  @objc private func didRecieveWishNotification(_ notification: Notification) {
    if let userInfo = notification.userInfo,
       let id = userInfo["id"] as? Int,
       let goods = self.goods.first(where: { $0.id == id }) {
      self.wishValueChanged.onNext(goods.id)
    }
  }
  
}
