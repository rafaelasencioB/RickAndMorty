//
//  CharacterUIComposer.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 15/11/22.
//

import UIKit

final class CharacterUIComposer {
    private init() {}

    static func makeController(withLoader loader: CharacterLoader) -> CharacterViewController {
        guard let viewController = UIStoryboard(name: "Character", bundle: nil).instantiateViewController(withIdentifier: "CharacterViewController") as? CharacterViewController else { fatalError("couldnt find storyboard") }
        let vm = CharacterViewModel(loader: loader)
        viewController.viewModel = vm
        return viewController
    }
}
