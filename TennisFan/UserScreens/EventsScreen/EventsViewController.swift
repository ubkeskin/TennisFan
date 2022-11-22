//
//  EventsViewController.swift
//  TennisFan
//
//  Created by OS on 16.11.2022.
//

import UIKit

protocol EventsViewInterface: AnyObject {
  func refreshCollectionView()
}
extension EventsViewController: EventsViewInterface {
  func refreshCollectionView() {
    collectionViewDataSource()
    collectionViewSnapshot()
  }
}
// MARK: -Controller
class EventsViewController: UIViewController {
  // MARK: -Enums
  enum ItemDataType: Hashable {
    case header([Event]), expandable(Event)
  }
  enum SectionType {
    case main
  }
  // MARK: -Properties
  var collectionView: UICollectionView!
  var dataSource: collectionDataSource?
  lazy var viewModel: EventsViewModel? = EventsViewModel(view: self)
  
  typealias collectionDataSource = UICollectionViewDiffableDataSource<SectionType, ItemDataType>
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel?.viewWillAppear()
  }
  private func setupUI() {
    collectionView = try? UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: collectionViewLayout())
    view.addSubview(collectionView)
  }
  //MARK: -CollectionVİEW DataSource & Layout
  private func collectionViewLayout() throws -> UICollectionViewCompositionalLayout {
    var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    layoutConfig.headerMode = .none
    let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
    return listLayout
  }
  
  private func collectionViewDataSource() {
    let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Event> {cell,indexPath,itemIdentifier in
      var content = cell.defaultContentConfiguration()
      content.text = itemIdentifier.slug
      cell.contentConfiguration = content
      
      let headerDisclosureOption = UICellAccessory.OutlineDisclosureOptions(style: .header)
      cell.accessories = [.outlineDisclosure(options:headerDisclosureOption)]
    }
    
    let expandableCellRegistration = UICollectionView.CellRegistration<ExpandableCollactionViewCell, Event> {cell,indexPath,itemIdentifier in
      cell.event = itemIdentifier
    }
    
    dataSource = collectionDataSource(collectionView: collectionView, cellProvider: { [self] collectionView, indexPath, itemIdentifier in
      guard let results = viewModel?.matches else {fatalError()}
      
      switch itemIdentifier {
        case .expandable(_):
          let collectionViewCell = collectionView.dequeueConfiguredReusableCell(using: expandableCellRegistration, for: indexPath, item: results[indexPath.item - 1])
          return collectionViewCell
          
        case .header(_):
          let collectionViewCell = collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration, for: indexPath, item: results[indexPath.item] )
          return collectionViewCell
      }
    })
    
    collectionView.dataSource = dataSource
  }
  private func collectionViewSnapshot() {
    var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<ItemDataType>()
    var dataSourceSnapshot = dataSource?.snapshot()
    dataSourceSnapshot?.appendSections([.main])
    viewModel?.matches.forEach { result in
      let headerForCell = ItemDataType.header([result])
      sectionSnapshot.append([headerForCell])
      let expandable = ItemDataType.expandable(result)
      sectionSnapshot.append([expandable], to: headerForCell)
      sectionSnapshot.expand([expandable])
    }
    dataSource?.apply(sectionSnapshot, to: .main)
  }
}


