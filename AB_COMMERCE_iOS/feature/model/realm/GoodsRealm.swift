//
//  GoodsWishRealm.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/09.
//

import Foundation

import RealmSwift

class GoodsWishRealm: Object {
  
  static let shared = GoodsWishRealm()
  
  /// 상품 ID
  @objc dynamic var id: Int = 0
  
  /// 상품 이름
  @objc dynamic var name: String = ""

  /// 상품 이미지 url
  @objc dynamic var image: String = ""
  
  /// 상품 기본 가격
  @objc dynamic var actualPrice: Int = 0
  
  /// 상품 실제 가격(기본가격 X 할인율 / 100 = 실제가격)
  @objc dynamic var price: Int = 0
  
  /// 신상품 여부
  @objc dynamic var isNew: Bool = false
  
  /// 구매중 갯수
  @objc dynamic var sellCount: Int = 0
  
  override class func primaryKey() -> String? {
    return "id"
  }
  
  func click(goods: Goods) {
    if self.isExist(id: goods.id) == false {
      self.add(goods: goods)
    } else {
      self.remove(id: goods.id)
    }
  }
  
  private func add(goods: Goods) {
    guard let realm = try? Realm() else { return }
    
    let goodsWishRealmData = GoodsWishRealm()
    goodsWishRealmData.id = goods.id ?? 0
    goodsWishRealmData.name = goods.name ?? ""
    goodsWishRealmData.image = goods.image ?? ""
    goodsWishRealmData.actualPrice = goods.actualPrice ?? 0
    goodsWishRealmData.price = goods.price ?? 0
    goodsWishRealmData.isNew = goods.isNew ?? false
    goodsWishRealmData.sellCount = goods.sellCount ?? 0
    
    try? realm.write {
      realm.add(goodsWishRealmData)
    }
  }
  
  private func remove(id: Int?) {
    guard let realm = try? Realm() else { return }
    
    let goodsWishRealmDatas = realm.objects(GoodsWishRealm.self).filter({ $0.id == id })
    
    try? realm.write {
      realm.delete(goodsWishRealmDatas)
    }
  }
  
  func read() -> [Goods] {
    guard let realm = try? Realm() else { return [] }
    
    return realm.objects(GoodsWishRealm.self).map {
      Goods(id: $0.id,
            name: $0.name,
            image: $0.image,
            actualPrice: $0.actualPrice,
            price: $0.price,
            isNew: $0.isNew,
            sellCount: $0.sellCount)
    }.reversed()
  }
  
  func isExist(id: Int?) -> Bool? {
    guard let realm = try? Realm(), let id = id else { return nil }
    
    return realm.objects(GoodsWishRealm.self).contains { $0.id == id }
  }
  
}
