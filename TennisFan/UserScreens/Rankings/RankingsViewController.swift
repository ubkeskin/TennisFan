//
//  RankingsViewController.swift
//  TennisFan
//
//  Created by OS on 14.12.2022.
//

import UIKit

protocol RankingsViewInterface: AnyObject {
  func refreshCollectionView()
}
extension RankingsViewController: RankingsViewInterface {
  func refreshCollectionView() {
    collectionViewDataSource()
    collectionViewSnapshot()
  }
}
extension RankingsViewController {
  enum ItemDataType: Hashable {
    case header(Rankings), expandable(Rankings)
  }
  enum SectionType {
    case main
  }
}

class RankingsViewController: UIViewController {
 
  lazy var viewModel: RankingsViewModel = { RankingsViewModel(view: self) }()
  lazy var segmentController: UISegmentedControl = {
    let segmentController = UISegmentedControl()
    segmentController.insertSegment(withTitle: "ATP", at: 0, animated: true)
    segmentController.insertSegment(withTitle: "WTA", at: 1, animated: true)
    segmentController.selectedSegmentIndex = 0
    segmentController.addTarget(self, action: #selector(scAction), for: .valueChanged)
    return segmentController
  }()
  
  typealias collectionDataSource = UICollectionViewDiffableDataSource<SectionType, ItemDataType>
  
  var collectionView: UICollectionView!
  var dataSource: collectionDataSource?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.viewWillAppear()
  }
  @objc private func scAction() {
    refreshCollectionView()
  }
  private func collectionViewLayout() throws -> UICollectionViewCompositionalLayout {
    var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    layoutConfig.headerMode = .none
    let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
    return listLayout
  }
  private func setupUI() {
    navigationItem.titleView = segmentController
    collectionView =
    try? UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width,
                                        height: UIScreen.main.bounds.height),
                          collectionViewLayout: collectionViewLayout())
    view.addSubview(collectionView)
  }
  private func collectionViewDataSource() {
    let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Rankings>
    {cell,indexPath,itemIdentifier in
      let playerName = itemIdentifier.rowName ?? ""
      let playerRanking = itemIdentifier.ranking ?? 0
      var content = cell.defaultContentConfiguration()
      content.text = "#\(playerRanking) \(playerName)"
      cell.contentConfiguration = content
      
      let headerDisclosureOption = UICellAccessory.OutlineDisclosureOptions(style: .cell)
      cell.accessories = [.outlineDisclosure(options:headerDisclosureOption)]
    }
    
    let expandableCellRegistration = UICollectionView.CellRegistration<ExpandableRankingsViewCell, Rankings>
    {cell,indexPath,itemIdentifier in
      cell.rankings = itemIdentifier
    }
    
    dataSource = collectionDataSource(collectionView: collectionView, cellProvider:
                                        { collectionView, indexPath, itemIdentifier in
      
      switch itemIdentifier {
        case .expandable(let expandable):
          let collectionViewCell = collectionView
            .dequeueConfiguredReusableCell(using: expandableCellRegistration,
                                           for: indexPath,
                                           item: expandable)
          return collectionViewCell
          
        case .header(let header):
          let collectionViewCell = collectionView
            .dequeueConfiguredReusableCell(using: headerCellRegistration,
                                           for: indexPath,
                                           item: header)
          return collectionViewCell
      }
    })
    
    collectionView.dataSource = dataSource
  }
  private func collectionViewSnapshot() {
    var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<ItemDataType>()
    var dataSourceSnapshot = dataSource?.snapshot()
    dataSourceSnapshot?.appendSections([.main])
    switch segmentController.selectedSegmentIndex {
      case 0:
        viewModel.atpRankings?.forEach { result in
          let headerForCell = ItemDataType.header(result)
          sectionSnapshot.append([headerForCell])
          let expandable = ItemDataType.expandable(result)
          sectionSnapshot.append([expandable], to: headerForCell)
          sectionSnapshot.expand([expandable])
        }
      case 1:
        viewModel.wtaRankings?.forEach { result in
          let headerForCell = ItemDataType.header(result)
          sectionSnapshot.append([headerForCell])
          let expandable = ItemDataType.expandable(result)
          sectionSnapshot.append([expandable], to: headerForCell)
          sectionSnapshot.expand([expandable])
        }
      default: return
    }
    dataSource?.apply(sectionSnapshot, to: .main)
  }
}
