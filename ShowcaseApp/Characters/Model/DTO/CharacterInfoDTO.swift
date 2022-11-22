//
//  CharacterInfoDTO.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 18/11/22.
//

import Foundation

public struct ResponseInfoDTO {
    public let count: Int
    public let pages: Int
    public let next: String
    public let prev: String?

    public init(count: Int, pages: Int, next: String, prev: String? = nil) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}

public struct CharacterResponseDTO {
    public let info: ResponseInfoDTO
    public let items: [CharacterItemDTO]
}
