//
//  URL+.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 20/11/22.
//

import Foundation

extension URL {

  // returns an absolute URL to the desired file in documents folder
  static func inDocumentsFolder(fileName: String) -> URL {
    return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0], isDirectory: true)
      .appendingPathComponent(fileName)
  }
}
