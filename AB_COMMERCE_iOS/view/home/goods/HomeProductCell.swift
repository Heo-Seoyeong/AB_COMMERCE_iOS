//
//  HomeProductCell.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

class HomeProductCell: BaseCollectionViewCell {
  
  private let productView = ProductView()
  
  override func commonInit() {
    super.commonInit()
    
    self.setUI()
    
    self.setNeedsUpdateConstraints()
    self.updateConstraintsIfNeeded()
    self.layoutIfNeeded()
  }

  func bind(_ data: Goods) {
    self.productView.bind(data)
    self.productView.isWish = true
  }
  
}

extension HomeProductCell {
  
  private func setUI() {
    self.addSubview(self.productView)
  }
  
  override func updateConstraints() {
    self.productView.snp.makeConstraints { make in
      make.top.left.right.bottom.equalToSuperview()
    }
    
    super.updateConstraints()
  }
 
  override func layoutSubviews() {
    super.layoutSubviews()
  }
}
