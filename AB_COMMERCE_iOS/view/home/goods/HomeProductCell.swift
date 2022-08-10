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
      make.top.leading.trailing.bottom.equalToSuperview()
    }
    
    super.updateConstraints()
  }
 
  override func layoutSubviews() {
    super.layoutSubviews()
  }
}

extension HomeProductCell {
  
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
