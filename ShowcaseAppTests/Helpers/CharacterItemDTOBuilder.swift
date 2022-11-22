//
//  CharacterItemDTOBuilder.swift
//  ShowcaseAppTests
//
//  Created by Rafael Asencio on 17/11/22.
//

import Foundation
import ShowcaseApp

class CharacterItemDTOBuilder {

    private var id: Int = 1
    private var name: String = "Rick Sanchez"
    private var status: CharacterStatus = .alive
    private var species: CharacterSpecie = .human
    private var type: String = ""
    private var gender: CharacterGender = .male
    private var origin: CharacterOrigin = .init(name: "Earth",
                                                url: "https://rickandmortyapi.com/api/location/1")
    private var location: CharacterLocationDTO = .init(name: "Earth",
                                                       url: "https://rickandmortyapi.com/api/location/20")
    private var image: String = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
    private var episode: [String] = [
        "https://rickandmortyapi.com/api/episode/1",
        "https://rickandmortyapi.com/api/episode/2"
    ]
    private var url: String = "https://rickandmortyapi.com/api/character/1"
    private var created: String = "2017-11-04T18:48:46.250Z"

    @discardableResult
    func build() -> CharacterItemDTO {
        .init(id: id,
              name: name,
              status: status,
              species: species,
              type: type,
              gender: gender,
              origin: origin,
              location: location,
              image: image,
              episode: episode,
              url: url,
              created: created)
    }

    @discardableResult
    func withName(_ name: String) -> CharacterItemDTOBuilder {
        self.name = name
        return self
    }
}
