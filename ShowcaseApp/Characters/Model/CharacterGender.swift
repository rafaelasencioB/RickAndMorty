//
//  CharacterGender.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 15/11/22.
//

import Foundation
import RealmSwift

public enum CharacterGender: String, Decodable, Equatable, PersistableEnum {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown
}
