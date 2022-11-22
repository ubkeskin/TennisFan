//
//  CollectionViewCell.swift
//  TennisFan
//
//  Created by OS on 16.11.2022.
//

import UIKit

class CollectionViewHeaderCell: UICollectionViewCell {
  // MARK: - properties
  static let reusableID: String = String(describing: CollectionViewHeaderCell.self)
  var label: UILabel?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension CollectionViewHeaderCell: CollectionViewCellInterface {
  override func layoutSubviews() {
    guard let label = label else { return }
    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: contentView.topAnchor),
      label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      label.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      label.rightAnchor.constraint(equalTo: contentView.rightAnchor)
    ])
  }
  func set(with event: Event) {
    label?.text = event.slug
  }
}
