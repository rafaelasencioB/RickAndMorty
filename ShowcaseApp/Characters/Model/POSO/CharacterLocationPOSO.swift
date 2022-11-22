//
//  CharacterLocationPOSO.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 15/11/22.
//

import Foundation

struct CharacterLocationPOSO: Decodable, Equatable {
    let name: String
    let url: String
}

extension CharacterLocationPOSO {
    func asDTO() -> CharacterLocationDTO {
        .init(name: name,
              url: url
        )
    }
}
