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
    self.setConstraints()
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
  
  private func setConstraints() {
    self.productView.snp.makeConstraints { make in
      make.top.left.right.bottom.equalToSuperview()
    }
  }
  
}
