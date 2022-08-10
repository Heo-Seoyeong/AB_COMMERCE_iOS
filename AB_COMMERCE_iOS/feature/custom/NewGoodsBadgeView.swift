//
//  NewGoodsBadgeView.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

import SnapKit

class NewGoodsBadgeView: BaseView {
  
  private let newLabel: UILabel = {
    let label = UILabel()
    label.text = "NEW"
    label.textColor = UIColor.aTextSecondary
    label.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
    return label
  }()
  
  override func commonInit() {
    super.commonInit()
    
    self.setUI()
    self.setConstraints()
  }
  
}

extension NewGoodsBadgeView {
  
  private func setUI() {
    self.layer.borderWidth = 1.0
    self.layer.borderColor = UIColor.aTextSecondary.cgColor
    self.layer.cornerRadius = 4.0
    
    self.addSubview(self.newLabel)
  }
  
  private func setConstraints() {
    self.newLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().offset(6.0)
      make.trailing.equalToSuperview().offset(-6.0)
    }
  }
  
}
