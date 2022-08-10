//
//  BannerHeaderImageCell.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/09.
//

import UIKit

class BannerHeaderImageCell: BaseCollectionViewCell {
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  override func commonInit() {
    super.commonInit()
    
    self.setUI()
    self.setNeedsUpdateConstraints()
  }

  func bind(_ image: String?) {
    if let image = image {
      self.imageView.sd_setImage(with: URL(string: image))
    }
  }
  
}

extension BannerHeaderImageCell {
  
  private func setUI() {
    self.addSubview(self.imageView)
  }
  
  override func updateConstraints() {
    self.imageView.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalToSuperview()
    }
    
    super.updateConstraints()
  }
  
}
