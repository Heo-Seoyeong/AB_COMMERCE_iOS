//
//  BaseViewController.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

import RxCocoa
import RxSwift

class BaseViewController: UIViewController {
  
  lazy var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
  }
  
  deinit {
    self.disposeBag = DisposeBag()
  }

}
