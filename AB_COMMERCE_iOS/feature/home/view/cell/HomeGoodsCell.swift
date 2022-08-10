//
//  HomeGoodsCell.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

class HomeGoodsCell: BaseCollectionViewCell {
  
  private let goodsView = GoodsView()
  
  override func commonInit() {
    super.commonInit()
    
    self.setUI()
    
    self.setConstraints()
  }

  func bind(_ data: Goods) {
    self.goodsView.bind(data)
    self.goodsView.isWish = true
  }
  
}

extension HomeGoodsCell {
  
  private func setUI() {
    self.addSubview(self.goodsView)
  }
  
  private func setConstraints() {
    self.goodsView.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalToSuperview()
    }
  }
 
  override func layoutSubviews() {
    super.layoutSubviews()
  }
}

extension HomeGoodsCell {
  
  static func cellHeight(goods: Goods) -> CGFloat {
    let maxSize = CGSize(width: UIScreen.main.bounds.width - 124.0, height: 1000.0)
    
    let nameHeight = ceil(NSString(string: goods.name ?? "").boundingRect(with: maxSize,
                                                                          options: .usesFontLeading.union(.usesLineFragmentOrigin),
                                                                          attributes: [.font: UIFont.systemFont(ofSize: 15.0, weight: .regular)],
                                                                          context: nil).height)
    /* 높이 계산
     topMargin = 16
     priceStackViewHeight = 20.0
     space = 10
     nameHeight
     space = 20
     sellStackViewHeight = 24.0
     bottomMargin = 16
     */
    return nameHeight + 106.0
  }
  
}
