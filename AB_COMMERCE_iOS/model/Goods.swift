//
//  Goods.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import Foundation

struct Goods: Codable {
  
  /// 상품 ID
  let id: Int?
  
  /// 상품 이름
  let name: String?
  
  /// 상품 이미지 url
  let image: String?
  
  /// 상품 기본 가격
  let actualPrice: Int?
  
  /// 상품 실제 가격(기본가격 X 할인율 / 100 = 실제가격)
  let price: Int?
  
  /// 신상품 여부
  let isNew: Bool?
  
  /// 구매중 갯수
  let sellCount: Int?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case image
    case actualPrice = "actual_price"
    case price
    case isNew = "is_new"
    case sellCount = "sell_count"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = try values.decodeIfPresent(Int.self, forKey: .id)
    self.name = try values.decodeIfPresent(String.self, forKey: .name)
    self.image = try values.decodeIfPresent(String.self, forKey: .image)
    self.actualPrice = try values.decodeIfPresent(Int.self, forKey: .actualPrice)
    self.price = try values.decodeIfPresent(Int.self, forKey: .price)
    self.isNew = try values.decodeIfPresent(Bool.self, forKey: .isNew)
    self.sellCount = try values.decodeIfPresent(Int.self, forKey: .sellCount)
  }
  
  init(id: Int?, name: String?, image: String?, actualPrice: Int?, price: Int?, isNew: Bool?, sellCount: Int?) {
    self.id = id
    self.name = name
    self.image = image
    self.actualPrice = actualPrice
    self.price = price
    self.isNew = isNew
    self.sellCount = sellCount
  }
  
}

extension Goods {
  
  /// 할인율 = 실제가격 * 100 / 기본가격 : (data.price * 100) / data.actualPrice
  var sellPercent: Double? {
    guard let price = self.price, let actualPrice = self.actualPrice, price < actualPrice else { return nil }
    return Double(price) / Double(actualPrice) * 100.0
  }
  
}
