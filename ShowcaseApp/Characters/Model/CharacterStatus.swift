//
//  CharacterStatus.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 15/11/22.
//

import Foundation
import RealmSwift

public enum CharacterStatus: String, Decodable, Equatable, PersistableEnum {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
}
