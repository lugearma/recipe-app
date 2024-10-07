//
//  FileContentLoader.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 07/10/24.
//

import Foundation

class FileContentLoader {
  let fileName: String

  init(fileName: String) {
    self.fileName = fileName
  }

  func loadContent() -> String {
    let bundle = Bundle(for: FileContentLoader.self)
    guard let filePath = bundle.path(forResource: fileName, ofType: "txt") else {
      preconditionFailure("Invalid path for file: \(fileName).txt")
    }

    do {
      return try String(contentsOfFile: filePath, encoding: .utf8)
    } catch {
      preconditionFailure("Unable to get file content.")
    }
  }
}

