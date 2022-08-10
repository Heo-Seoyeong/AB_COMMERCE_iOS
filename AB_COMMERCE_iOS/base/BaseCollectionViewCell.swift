//
//  BaseCollectionViewCell.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
  
  lazy var disposeBag = DisposeBag()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    self.disposeBag = DisposeBag()
  }
  
  func commonInit() { }
  
}
