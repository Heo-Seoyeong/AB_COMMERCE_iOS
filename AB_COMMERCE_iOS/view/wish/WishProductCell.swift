//
//  WishProductCell.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

class WishProductCell: BaseCollectionViewCell {
  
  private let productView = ProductView()
  
  override func commonInit() {
    super.commonInit()
    
    self.setUI()
    self.setNeedsUpdateConstraints()
  }

  func bind(_ data: Goods) {
    self.productView.bind(data)
    self.productView.isWish = false
  }
  
}

extension WishProductCell {
  
  private func setUI() {
    self.addSubview(self.productView)
  }
  
  override func updateConstraints() {
    self.productView.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalToSuperview()
    }
    
    super.updateConstraints()
  }
  
}

extension WishProductCell {
  
  static func cellHeight(goods: Goods) -> CGFloat {
    let maxSize = CGSize(width: UIScreen.main.bounds.width - 124.0, height: 1000.0)
    
    let priceStackViewHeight = 20.0
      
    let nameHeight = ceil(NSString(string: goods.name ?? "").boundingRect(with: maxSize,
                                                                          options: .usesFontLeading.union(.usesLineFragmentOrigin),
                                                                          attributes: [.font: UIFont.systemFont(ofSize: 15.0, weight: .regular)],
                                                                          context: nil).height)
    
    let sellStackViewHeight = 24.0
    
    return priceStackViewHeight + nameHeight + sellStackViewHeight + 62.0
  }
  
}
