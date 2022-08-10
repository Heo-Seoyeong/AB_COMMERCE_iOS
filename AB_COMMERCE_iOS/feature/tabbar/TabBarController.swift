//
//  TabBarController.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

import RxCocoa
import RxSwift

class TabBarController: UITabBarController {

  lazy var disposeBag = DisposeBag()

  var previousIndex = 0

  deinit {
    self.disposeBag = DisposeBag()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupTabBarStyle()
    self.setTab()
  }
  
  private func setupTabBarStyle() {
    self.tabBar.tintColor = UIColor.aPink
  }
  
  private func setTab() {
    let homeVC = HomeViewController()
    homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
    let homeNaviVC = UINavigationController(rootViewController: homeVC)
    
    let wishVC = WishViewController()
    wishVC.tabBarItem = UITabBarItem(title: "좋아요", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
    let wishNaviVC = UINavigationController(rootViewController: wishVC)
    
    let controllers = [homeNaviVC, wishNaviVC]
    self.viewControllers = controllers
  }

}
