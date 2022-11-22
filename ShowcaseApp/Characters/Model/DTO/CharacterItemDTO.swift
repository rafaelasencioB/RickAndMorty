//
//  CharacterItemDTO.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 15/11/22.
//

import Foundation

public struct CharacterItemDTO: Equatable {
    public let id: Int
    public let name: String
    public let status: CharacterStatus
    public let species: CharacterSpecie
    public let type: String
    public let gender: CharacterGender
    public let origin: CharacterOriginDTO //origin & location have same structure. Maybe use enum pattern
    public let location: CharacterLocationDTO
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String

    public init(id: Int, name: String, status: CharacterStatus, species: CharacterSpecie, type: String, gender: CharacterGender, origin: CharacterOriginDTO, location: CharacterLocationDTO, image: String, episode: [String], url: String, created: String) {
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

    public static func == (lhs: CharacterItemDTO, rhs: CharacterItemDTO) -> Bool {
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
