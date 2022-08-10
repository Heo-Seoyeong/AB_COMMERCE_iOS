//
//  PageControlView.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/09.
//

import UIKit

class PageControlView: BaseView {
  
  private let countLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = .systemFont(ofSize: 12.0, weight: .medium)
    return label
  }()
  
  override func commonInit() {
    super.commonInit()
    
    self.setUI()
    self.setConstraints()
  }
  
  var totalCount: Int = 0
  
  var currentCount: Int = 0 {
    didSet {
      self.countLabel.text = "\(self.currentCount)/\(self.totalCount)"
    }
  }
  
}

extension PageControlView {
  
  private func setUI() {
    self.backgroundColor = .black.withAlphaComponent(0.3)
    self.layer.cornerRadius = 12.0
    
    self.addSubview(self.countLabel)
  }
  
  private func setConstraints() {
    self.countLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
}
