//
//  CharacterViewModel.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 14/11/22.
//

import Foundation
import RealmSwift

final class CharacterViewModel {

    
    private let loader: CharacterLoader
    init(loader: CharacterLoader) {
        self.loader = loader
    }

    private var items = [CharacterItemDTO]()
    private(set) var isFetching = false
    public var currentCount: Int { items.count }
    var onLoadCompleted: (([CharacterItemDTO]) -> Void)?
    private let baseURL = "https://rickandmortyapi.com/api" + "/character"
    private var nextURL: String?

//    private let realm = try! Realm(configuration: RealmConfig.main.configuration)

    func loadCharacters(page: Int = 0) {
        guard isFetching == false else { return }
        isFetching = true

        guard let url = URL(string: nextURL ?? baseURL) else { return }

        loader.load(fromURL: url, page: page) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(response):
                    let items = response.items
                    self.items.append(contentsOf: items)
                    self.nextURL = response.info.next
                case .failure(let error):
                    print("DEBUG: \(error)")
                }
                self.isFetching = false
                self.onLoadCompleted?(self.items)
            }
        }
    }

    public func item(at indexPath: IndexPath) -> CharacterItemDTO {
        return items[indexPath.row]
    }


//    private func calculateIndexPathsToReload(from newItems: [CharacterItemDTO]) -> [IndexPath] {
//      let startIndex = currentCount - newItems.count
//      let endIndex = startIndex + newItems.count
//      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
//    }
}
