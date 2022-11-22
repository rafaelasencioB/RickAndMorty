//
//  CharacterResponsePOSO.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 15/11/22.
//

import Foundation

struct ResponseInfoPOSO: Decodable {
    let count: Int
    let pages: Int
    let next: String
    let prev: String?

    init(count: Int, pages: Int, next: String, prev: String? = nil) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}

extension ResponseInfoPOSO {
    func asDTO() -> ResponseInfoDTO {
        .init(count: count,
              pages: pages,
              next: next,
              prev: prev)
    }
}


struct CharacterResponsePOSO: Decodable {
    let info: ResponseInfoPOSO
    let items: [CharacterItemPOSO]

    enum CodingKeys: String, CodingKey {
        case info
        case items = "results"
    }
}

extension CharacterResponsePOSO {
    func asDTO() -> CharacterResponseDTO {
        .init(info: info.asDTO(),
              items: items.map { $0.asDTO() })
    }
}
