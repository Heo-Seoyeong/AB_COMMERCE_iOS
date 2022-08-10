//
//  NewProductBadgeView.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

import SnapKit

class NewProductBadgeView: BaseView {
  
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
    self.setNeedsUpdateConstraints()
  }
  
}

extension NewProductBadgeView {
  
  private func setUI() {
    self.layer.borderWidth = 1.0
    self.layer.borderColor = UIColor.aTextSecondary.cgColor
    self.layer.cornerRadius = 4.0
    
    self.addSubview(self.newLabel)
  }
  
  override func updateConstraints() {
    self.newLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
    super.updateConstraints()
  }
  
}
