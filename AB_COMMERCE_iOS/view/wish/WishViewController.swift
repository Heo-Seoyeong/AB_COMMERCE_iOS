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
      make.left.right.equalToSuperview()
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
    
    self.collection.register(WishProductCell.self, forCellWithReuseIdentifier: "WishProductCell")
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
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishProductCell", for: indexPath)
    if let cell = cell as? WishProductCell {
      cell.bind(self.viewModel.goods[indexPath.row])
    }
    return cell
  }
  
}

extension WishViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.width
    let height = self.cellHeight(row: indexPath.row)

    return CGSize(width: width, height: height)
  }
  
  private func cellHeight(row: Int) -> CGFloat {
    let goods = self.viewModel.goods[row]
    
    let maxSize = CGSize(width: UIScreen.main.bounds.width - 112.0, height: 1000.0)
    
    let priceHeight = NSString(string: goods.price?.decimalString ?? "").boundingRect(with: maxSize,
                                                                                      options: .usesFontLeading.union(.usesLineFragmentOrigin),
                                                                                      attributes: [.font: UIFont.systemFont(ofSize: 15.0, weight: .bold)],
                                                                                      context: nil).height
      
    let nameHeight = NSString(string: goods.name ?? "").boundingRect(with: maxSize,
                                                                     options: .usesFontLeading.union(.usesLineFragmentOrigin),
                                                                     attributes: [.font: UIFont.systemFont(ofSize: 15.0, weight: .regular)],
                                                                     context: nil).height
    let newBadgeHeight = NSString(string: "new").boundingRect(with: maxSize,
                                                              options: .usesFontLeading.union(.usesLineFragmentOrigin),
                                                              attributes: [.font: UIFont.systemFont(ofSize: 15.0, weight: .medium)],
                                                              context: nil).height + 8.0
    
    return priceHeight + nameHeight + newBadgeHeight + 62.0
  }
  
}
