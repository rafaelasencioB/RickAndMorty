//
//  CharacterSpecie.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 15/11/22.
//

import Foundation
import RealmSwift

public enum CharacterSpecie: String, Decodable, Equatable, PersistableEnum {
    case human = "Human"
    case alien = "Alien"
    case robot = "Robot"
    case animal = "Animal"
    case disease = "Disease"
    case humanoid = "Humanoid"
    case cronenberg = "Cronenberg"
    case poopybutthole = "Poopybutthole"
    case mythologicalCreature = "Mythological Creature"
    case unknown
}
