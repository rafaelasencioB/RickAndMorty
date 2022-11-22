//
//  ViewController.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 13/11/22.
//

import UIKit

class CharacterViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    var viewModel: CharacterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.onLoadCompleted = { [weak self] items in
            self?.activityIndicator.stopAnimating()
            self?.tableView.reloadData()
        }
        loadCharacters()
    }

    private func loadCharacters() {
        activityIndicator.startAnimating()
        viewModel.loadCharacters()
    }

    private func navigateToCharacterDetails() {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = viewModel.item(at: indexPath)
        guard let controller = UIStoryboard(name: "Character", bundle: nil)
            .instantiateViewController(withIdentifier: CharacterDetailsViewController.identifier) as? CharacterDetailsViewController else { fatalError("invalid controller") }
        controller.item = character
        present(controller, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension CharacterViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharaterItemCell.identifier, for: indexPath) as? CharaterItemCell else { fatalError("invalid cell with identifier \(CharaterItemCell.identifier)") }
        let item = viewModel.item(at: indexPath)
        cell.configure(withItem: item)
        return cell
    }
}

extension CharacterViewController: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard !viewModel.isFetching else { return }
            loadCharacters()
        }
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToCharacterDetails()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
