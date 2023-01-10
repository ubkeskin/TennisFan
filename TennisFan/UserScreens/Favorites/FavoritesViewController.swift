//
//  FavoritesViewController.swift
//  TennisFan
//
//  Created by OS on 8.01.2023.
//

import UIKit
protocol FavoritesViewInterface: AnyObject {
  func refreshCollectionView()

}
extension FavoritesViewController: FavoritesViewInterface {
  func refreshCollectionView() {
    collectionViewDataSource()
    collectionViewSnapshot()
  }
}
extension FavoritesViewController {
  enum Gender: String {
  case Male, Female
  }
}

class FavoritesViewController: UIViewController {
  typealias dataSourceType = UICollectionViewDiffableDataSource<Gender, Rankings>
  
  var dataSource: dataSourceType?
  var collectionView: UICollectionView!
  
  lazy var viewModel: FavoritesViewModel! = FavoritesViewModel(view: self)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel = FavoritesViewModel(view: self)
    refreshCollectionView()
  }
  
  private func setupUI() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    view.addSubview(collectionView)
    collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseIdentifier)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
  }
  private func collectionViewLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .absolute(120))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                   subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
  private func collectionViewDataSource() {
    dataSource = dataSourceType(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.reuseIdentifier, for: indexPath) as? FavoriteCell
      cell?.rankings = itemIdentifier
      return cell
    }
    collectionView.dataSource = dataSource
  }
  private func collectionViewSnapshot() {
    var currentSnapshot = NSDiffableDataSourceSnapshot<Gender, Rankings>()
    currentSnapshot.appendSections([.Male, .Female])
    viewModel.rankings?.forEach({ ranking in
      ranking.team?.gender == "M" ? currentSnapshot.appendItems([ranking], toSection: .Male) : currentSnapshot.appendItems([ranking], toSection: .Female)
    })
    dataSource?.apply(currentSnapshot)
  }
}
