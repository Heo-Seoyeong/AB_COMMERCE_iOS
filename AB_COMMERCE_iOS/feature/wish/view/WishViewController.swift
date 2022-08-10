//
//  WishViewController.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

import RxSwift

class WishViewController: BaseViewController {
  
  private let collection: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = .zero
    layout.minimumLineSpacing = .zero
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()

  private let refreshControl = UIRefreshControl()
  
  private let viewModel = WishViewModel()
  
}

extension WishViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "좋아요"
    
    self.setUI()
    self.setConstraints()
    self.setCollectionView()
    self.setObservable()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.viewModel.getRefresh()
  }

  private func setUI() {
    self.view.addSubview(self.collection)
  }
  
  private func setConstraints() {
    self.collection.snp.makeConstraints { make in
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
    }
  }
  
  private func setCollectionView() {
    self.collection.backgroundColor = .white
    self.collection.dataSource = self
    self.collection.delegate = self
    self.collection.showsVerticalScrollIndicator = false
    self.collection.showsHorizontalScrollIndicator = false
    self.collection.refreshControl = self.refreshControl
    self.refreshControl.addTarget(self, action: #selector(refreshHome), for: .valueChanged)
    
    self.collection.register(WishGoodsCell.self, forCellWithReuseIdentifier: "WishGoodsCell")
  }
  
  @objc private func refreshHome() {
    self.collection.refreshControl?.beginRefreshing()
    self.viewModel.getRefresh()
  }
  
}

extension WishViewController {
  
  private func setObservable() {
    self.viewModel.reloadAction.asObservable()
      .subscribe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        guard let self = self else { return }
        self.collection.reloadData()
        self.collection.refreshControl?.endRefreshing()
      })
      .disposed(by: self.disposeBag)
    
    self.viewModel.wishValueChanged.asObserver()
      .subscribe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] goodsId in
        guard let self = self else { return }
        
        self.viewModel.getRefresh()
      })
      .disposed(by: self.disposeBag)
  }
  
}

extension WishViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.viewModel.goods.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishGoodsCell", for: indexPath)
    if let cell = cell as? WishGoodsCell {
      cell.bind(self.viewModel.goods[indexPath.item])
    }
    return cell
  }
  
}

extension WishViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.width
    let height = WishGoodsCell.cellHeight(goods: self.viewModel.goods[indexPath.item])

    return CGSize(width: width, height: height)
  }
  
}
