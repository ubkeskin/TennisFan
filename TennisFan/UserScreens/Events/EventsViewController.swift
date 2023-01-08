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
    case header(Event), expandable(Event)
  }
  enum SectionType {
    case main
  }
  // MARK: -Properties
  typealias collectionDataSource = UICollectionViewDiffableDataSource<SectionType, ItemDataType>
  lazy var viewModel: EventsViewModel? = EventsViewModel(view: self)
  var collectionView: UICollectionView!
  var dataSource: collectionDataSource?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    collectionView.delegate = self

  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel?.viewWillAppear()
  }
  private func setupUI() {
    collectionView =
    try? UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width,
                                        height: UIScreen.main.bounds.height),
                          collectionViewLayout: collectionViewLayout())
    view.addSubview(collectionView)
  }
  
  // MARK: -CollectionVİEW DataSource & Layout
  private func collectionViewLayout() throws -> UICollectionViewCompositionalLayout {
    var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    layoutConfig.headerMode = .none
    let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
    return listLayout
  }
  
  private func collectionViewDataSource() {
    let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Event>
    {cell,indexPath,itemIdentifier in
      let homeName = itemIdentifier.homeTeam?.name ?? ""
      let awayName = itemIdentifier.awayTeam?.name ?? ""
      var content = cell.defaultContentConfiguration()
      content.text = "\(homeName) vs \(awayName)"
      cell.contentConfiguration = content
      
      let headerDisclosureOption = UICellAccessory.OutlineDisclosureOptions(style: .header)
      cell.accessories = [.outlineDisclosure(options:headerDisclosureOption)]
    }
    
    let expandableCellRegistration = UICollectionView.CellRegistration<ExpandableEventViewCell, Event>
    {cell,indexPath,itemIdentifier in
      
      cell.event = itemIdentifier
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
    viewModel?.matches.forEach { result in
      let headerForCell = ItemDataType.header(result)
      sectionSnapshot.append([headerForCell])
      let expandable = ItemDataType.expandable(result)
      sectionSnapshot.append([expandable], to: headerForCell)
      sectionSnapshot.expand([expandable])
    }
    dataSource?.apply(sectionSnapshot, to: .main)
  }
}

extension EventsViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard let selectedCell = collectionView.cellForItem(at: indexPath) as? ExpandableEventViewCell,
          let selectedEvent = selectedCell.event
    else { return }

    let imageDictionary = ["homeImage" : selectedCell.homeImage?.image?.pngData(),
                           "awayImage" : selectedCell.awayImage?.image?.pngData()]
    let rankingDictionary = ["homeRanking" : selectedCell.homeRanking,
                             "awayRanking" : selectedCell.awayRanking]
    let eventsDetailViewController = EventsDetailViewController()
    eventsDetailViewController.viewModel.event = selectedEvent
    eventsDetailViewController.viewModel.imageDictionary = imageDictionary
    eventsDetailViewController.viewModel.rankingsDictionary = rankingDictionary
    present(eventsDetailViewController, animated: true)
  }
}

