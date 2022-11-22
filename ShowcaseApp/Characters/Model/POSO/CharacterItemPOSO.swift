//
//  CharacterItemPOSO.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 14/11/22.
//

import Foundation

struct CharacterItemPOSO: Decodable, Equatable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: CharacterSpecie
    let type: String
    let gender: CharacterGender
    let origin: CharacterOriginPOSO //origin & location have same structure. Maybe use enum pattern
    let location: CharacterLocationPOSO
    let image: String
    let episode: [String]
    let url: String
    let created: String //Use BetterCodable?

    init(id: Int, name: String, status: CharacterStatus, species: CharacterSpecie, type: String, gender: CharacterGender, origin: CharacterOriginPOSO, location: CharacterLocationPOSO, image: String, episode: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }

    static func == (lhs: CharacterItemPOSO, rhs: CharacterItemPOSO) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.status == rhs.status &&
        lhs.species == rhs.species &&
        lhs.type == rhs.type &&
        lhs.gender == rhs.gender &&
        lhs.origin == rhs.origin &&
        lhs.location == rhs.location &&
        lhs.image == rhs.image &&
        lhs.episode == rhs.episode &&
        lhs.url == rhs.url &&
        lhs.created == rhs.created
    }
}

extension CharacterItemPOSO {
    func asDTO() -> CharacterItemDTO {
        .init(id: id,
              name: name,
              status: status,
              species: species,
              type: type,
              gender: gender,
              origin: origin.asDTO(),
              location: location.asDTO(),
              image: image,
              episode: episode,
              url: url,
              created: created
        )
    }
}
