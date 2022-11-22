//
//  CharacterOriginDTO.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 20/11/22.
//

import Foundation

public struct CharacterOriginDTO: Decodable, Equatable {
    public let name: String
    public let url: String

    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
