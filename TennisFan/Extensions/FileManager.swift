//
//  FileManager.swift
//  TennisFan
//
//  Created by OS on 20.12.2022.
//

import Foundation

extension FileManager {
  static var documentsDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
  func favoritesURL() throws -> URL {
    try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
      .appendingPathComponent("favorites.data")
  }
}
