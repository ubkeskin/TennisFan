//
//  Button.swift
//  TennisFan
//
//  Created by OS on 20.12.2022.
//
import Foundation
import UIKit
enum CurrentState: String, CodingKey, Encodable {
  case selected = "selected"
  case normal = "normal"
}

class FPButton: UIButton {
  private let images: [String: UIImage] =
  ["normal": UIImage(systemName: "star") ?? UIImage(),
   "selected": UIImage(systemName: "star.fill") ?? UIImage()]
  private var currentState: CurrentState?
  
  override init(frame: CGRect ) {
    super.init(frame: frame)
    setImage(images["normal"], for: .normal)
    setImage(images["selected"], for: .selected)
    addTarget(self, action: #selector(updateFavorites), for: .touchUpInside)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension FPButton {
  @objc private func updateFavorites() {
    saveCurrentState()
  }
  private func saveCurrentState() {
    let encoder = JSONEncoder()
    let data = try? encoder.encode(currentState)
    try? data?.write(to: FileManager.default.favoritesURL())
  }
//  private func loadFavorites() {
//    let decoder = JSONDecoder()
//    let facorites = try? decoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
//  }
}
