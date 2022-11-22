//
//  CharacterDetailsViewController.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 22/11/22.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

    static let identifier = "CharacterDetailsViewController"
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet private weak var characterOriginLabel: UILabel!
    @IBOutlet private weak var characterSpecieLabel: UILabel!
    @IBOutlet private weak var characterGenderLabel: UILabel!
    @IBOutlet private weak var characterImageView: UIImageView!

    var item: CharacterItemDTO?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCharacterInfo()
        configureUI()
    }

    private func configureUI() {
        characterImageView.layer.cornerRadius = 12
        characterImageView.layer.masksToBounds = true
    }

    private func configureCharacterInfo() {
        guard let item = item else { return }
        characterNameLabel.text = item.name
        characterOriginLabel.text = item.origin.name
        characterSpecieLabel.text = item.species.rawValue
        characterGenderLabel.text = item.gender.rawValue

        guard let url = URL(string: item.image) else { return }
        Task { [weak self] in
            let (data, _) = try await URLSession.shared.data(from: url)
            self?.characterImageView.image = UIImage(data: data)
        }
    }
}
