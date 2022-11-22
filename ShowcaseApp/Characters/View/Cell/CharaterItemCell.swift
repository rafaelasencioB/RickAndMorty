//
//  CharaterItemCell.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 17/11/22.
//

import UIKit

class CharaterItemCell: UITableViewCell {

    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterNameTextLabel: UILabel!
    @IBOutlet private weak var characterGenderTextLabel: UILabel!
    @IBOutlet private weak var characterOriginTextLabel: UILabel!

    static let identifier = "CharaterItemCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        characterImageView.layer.cornerRadius = characterImageView.frame.width / 2
        characterImageView.layer.masksToBounds = true
    }

    func configure(withItem character: CharacterItemDTO?) {
        guard let character = character else { return }
        characterNameTextLabel.text = character.name
        
        characterGenderTextLabel.text = character.gender.rawValue
        characterOriginTextLabel.text = character.origin.name

        guard let url = URL(string: character.image) else { return }
        Task {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.characterImageView.image = UIImage(data: data)
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
        characterNameTextLabel.text = nil
        characterGenderTextLabel.text = nil
        characterOriginTextLabel.text = nil


    }
    
}
