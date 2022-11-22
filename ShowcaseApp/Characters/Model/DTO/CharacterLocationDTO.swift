//
//  CharacterLocationDTO.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 15/11/22.
//

import Foundation

public struct CharacterLocationDTO: Decodable, Equatable {
    public let name: String
    public let url: String

    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
