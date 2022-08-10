//
//  HomeViewController.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

import RxSwift

class HomeViewController: BaseViewController {
  
  private let collection: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = .zero
    layout.minimumLineSpacing = .zero
    layout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()

  private let refreshControl = UIRefreshControl()
  
  private let viewModel = HomeViewModel()
  
}

extension HomeViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "홈"
    
    self.setUI()
    self.setConstraints()
    self.setCollectionView()
    self.setObservable()
    
    self.viewModel.getHomeData()
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
    
    self.collection.register(HomeProductCell.self, forCellWithReuseIdentifier: "HomeProductCell")
    self.collection.register(BannerHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BannerHeaderView")
  }
  
  @objc private func refreshHome() {
    self.collection.refreshControl?.beginRefreshing()
    self.viewModel.getHomeData()
  }
  
}

extension HomeViewController {
  
  private func setObservable() {
    self.viewModel.reloadAction.asObservable()
      .subscribe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] reloadType in
        guard let self = self else { return }
        
        if case .first = reloadType {
          self.collection.reloadData()
        } else if case .more = reloadType {
          let cellCount = self.collection.numberOfItems(inSection: 0)
          let goodsCount = self.viewModel.goods.count
          
          let updateIndexPaths: [IndexPath] = Array<Int>(cellCount..<goodsCount)
            .map { offset -> IndexPath in
              return IndexPath(row: offset, section: 0)
            }
          
          self.collection.performBatchUpdates { [weak self] in
            guard let self = self else { return }
            self.collection.insertItems(at: updateIndexPaths)
          }
        } else {
          
        }
        
        self.collection.refreshControl?.endRefreshing()
      })
      .disposed(by: self.disposeBag)

    self.viewModel.wishValueChanged.asObserver()
      .subscribe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] goods in
        guard let self = self else { return }
        
        if let item = self.viewModel.goods.firstIndex(where: { $0.id == goods.id }) {
          let cell = self.collection.cellForItem(at: IndexPath(item: item, section: 0))
          if let cell = cell as? HomeProductCell {
            cell.bind(goods)
          }
        }
      })
      .disposed(by: self.disposeBag)
  }
  
}

extension HomeViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.viewModel.goods.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProductCell", for: indexPath)
    if let cell = cell as? HomeProductCell {
      cell.bind(self.viewModel.goods[indexPath.item])
    }
    return cell
  }
  
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.width
    let height = HomeProductCell.cellHeight(goods: self.viewModel.goods[indexPath.item])
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BannerHeaderView", for: indexPath) as! BannerHeaderView
      headerView.bind(self.viewModel.banners)
      return headerView
    }
    
    return UICollectionReusableView()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.width / 750.0 * 527.0

    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let reloadType = try? self.viewModel.reloadAction.value(), reloadType != .last else { return }
    
    if indexPath.item == self.viewModel.goods.count - 1 {
      self.viewModel.getHomeData(lastId: self.viewModel.goods.last?.id)
    }
  }
  
}
