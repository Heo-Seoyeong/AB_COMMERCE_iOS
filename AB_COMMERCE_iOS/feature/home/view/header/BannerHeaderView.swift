//
//  BannerHeaderView.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

class BannerHeaderView: UICollectionReusableView {
  
  private let collection: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = .zero
    layout.minimumLineSpacing = .zero
    layout.scrollDirection = .horizontal
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  private let pageView = PageControlView()
  
  var banners: [Banners] = []
  
  func bind(_ banners: [Banners]) {
    self.banners = banners
    self.collection.reloadData()
    
    self.pageView.totalCount = self.banners.count
    self.pageView.currentCount = 1
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setUI()
    self.setConstraints()
    self.setCollectionView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension BannerHeaderView {
  
  private func setUI() {
    self.addSubview(self.collection)
    self.addSubview(self.pageView)
  }
  
  private func setConstraints() {
    self.collection.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalToSuperview()
    }
    
    self.pageView.snp.makeConstraints { make in
      make.trailing.equalToSuperview().offset(-16.0)
      make.bottom.equalToSuperview().offset(-16.0)
      make.height.equalTo(24.0)
      make.width.equalTo(40.0)
    }
  }
  
  private func setCollectionView() {
    self.collection.bounces = false
    self.collection.showsVerticalScrollIndicator = false
    self.collection.showsHorizontalScrollIndicator = false
    self.collection.backgroundColor = .white
    self.collection.isPagingEnabled = true
    self.collection.dataSource = self
    self.collection.delegate = self
    
    self.collection.register(BannerHeaderImageCell.self, forCellWithReuseIdentifier: "BannerHeaderImageCell")
  }
  
}

extension BannerHeaderView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.banners.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerHeaderImageCell", for: indexPath)
    if let cell = cell as? BannerHeaderImageCell {
      cell.bind(self.banners[indexPath.item].image)
    }
    return cell
  }
  
}

extension BannerHeaderView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.width
    let height = ceil(UIScreen.main.bounds.width / 750.0 * 527.0)
    
    return CGSize(width: width, height: height)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
    if let indexPath = self.collection.indexPathForItem(at: center) {
      self.pageView.currentCount = indexPath.item + 1
    }
  }
  
}
