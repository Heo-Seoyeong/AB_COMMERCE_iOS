//
//  BaseView.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

import RxSwift

class BaseView: UIView {
  
  var disposeBag = DisposeBag()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    commonInit()
  }
  
  deinit {
    self.disposeBag = DisposeBag()
  }
  
  func commonInit() {
    self.backgroundColor = .white
  }
  
}
