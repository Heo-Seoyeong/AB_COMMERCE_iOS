//
//  GoodsView.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

import SnapKit
import SDWebImage

class GoodsView: BaseView {
  
  private let thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 4.0
    return imageView
  }()
  
  private let wishButton: UIButton = {
    let button = UIButton()
    let normalImage = UIImage(systemName: "heart")?.mask(with: UIColor.aWhite)
    button.setImage(normalImage, for: .normal)
    let selectedImage = UIImage(systemName: "heart.fill")?.mask(with: UIColor.aPink)
    button.setImage(selectedImage, for: .selected)
    return button
  }()
  
  private let infoStackView = BaseStackView(axis: .vertical, spacing: 10.0)
  
  private let priceStackView = BaseStackView(axis: .horizontal, spacing: 6.0)
  
  private let percentLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.aPink
    label.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
    return label
  }()
  
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.aTextPrimary
    label.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
    return label
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.aTextSecondary
    label.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
    label.numberOfLines = 0
    return label
  }()
  
  private let sellStackView = BaseStackView(axis: .horizontal, spacing: 6.0)
  
  private let newBadgeView = NewGoodsBadgeView()
  
  private let sellCountLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.aTextSecondary
    label.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
    return label
  }()
  
  private let bottomBarView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.separator
    return view
  }()
  
  var isWish: Bool = false {
    didSet {
      self.wishButton.isHidden = !isWish
    }
  }
  
  private var goods: Goods?
  
  override func commonInit() {
    super.commonInit()
    
    self.setUI()
    self.setConstraints()
  }
  
  func bind(_ data: Goods) {
    self.goods = data
    
    if let url = data.image {
      self.thumbnailImageView.sd_setImage(with: URL(string: url))
    }
    
    if let price = data.price {
      self.priceStackView.isHidden = false
      self.priceLabel.text = price.decimalString
      
      if let sellPercent = data.sellPercent {
        self.percentLabel.isHidden = false
        self.percentLabel.text = "\(Int(sellPercent))%"
      } else {
        self.percentLabel.isHidden = true
      }
      
    } else {
      self.priceStackView.isHidden = true
    }
    
    self.nameLabel.text = data.name
    
    self.newBadgeView.isHidden = data.isNew != true
    
    if let sellCount = data.sellCount, sellCount >= 10 {
      self.sellCountLabel.text = "\(sellCount)개 구매중"
      self.sellCountLabel.isHidden = false
    } else {
      self.sellCountLabel.isHidden = true
    }
    
    self.sellStackView.isHidden = self.newBadgeView.isHidden && self.sellCountLabel.isHidden
    
    self.wishButton.isSelected = GoodsWishRealm.shared.isExist(id: data.id) == true
  }
  
  @objc private func wishButtonDidTap() {
    if let id = self.goods?.id {
      NotificationCenter.default.post(name: .wishDidTap, object: nil, userInfo: ["id": id])
    }
  }
  
}

extension GoodsView {
  
  private func setUI() {
    self.wishButton.addTarget(self, action: #selector(wishButtonDidTap), for: .touchUpInside)
    
    self.addSubview(self.thumbnailImageView)
    self.addSubview(self.wishButton)
    self.addSubview(self.infoStackView)
    self.addSubview(self.bottomBarView)
    
    self.infoStackView.addArrangedSubview(self.priceStackView)
    self.priceStackView.addArrangedSubview(self.percentLabel)
    self.priceStackView.addArrangedSubview(self.priceLabel)
    self.priceStackView.addArrangedSubview(UIView())
    
    self.infoStackView.addArrangedSubview(self.nameLabel)
    
    newBadgeView.setContentHuggingPriority(.init(rawValue: 800.0), for: .horizontal)
    newBadgeView.setContentHuggingPriority(.init(rawValue: 800.0), for: .vertical)
    
    sellCountLabel.setContentHuggingPriority(.init(rawValue: 800.0), for: .horizontal)
    sellCountLabel.setContentHuggingPriority(.init(rawValue: 800.0), for: .vertical)
    
    self.infoStackView.addArrangedSubview(self.sellStackView)
    self.sellStackView.addArrangedSubview(self.newBadgeView)
    self.sellStackView.addArrangedSubview(self.sellCountLabel)
    self.sellStackView.addArrangedSubview(UIView())
    
    self.infoStackView.setCustomSpacing(20.0, after: self.nameLabel)
  }
  
  private func setConstraints() {
    self.thumbnailImageView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(16.0)
      make.leading.equalToSuperview().offset(16.0)
      make.height.width.equalTo(80.0)
      make.bottom.lessThanOrEqualToSuperview()
    }
    
    self.wishButton.snp.makeConstraints { make in
      make.top.equalTo(self.thumbnailImageView.snp.top)
      make.trailing.equalTo(self.thumbnailImageView.snp.trailing)
      make.width.height.equalTo(44.0)
    }
    
    self.infoStackView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(16.0)
      make.leading.equalTo(self.thumbnailImageView.snp.trailing).offset(12.0)
      make.trailing.equalToSuperview().offset(-16.0)
    }
    
    self.priceStackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(20.0)
    }
    
    self.sellStackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(24.0)
    }
    
    self.bottomBarView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.height.equalTo(0.3)
    }
  }
  
}

