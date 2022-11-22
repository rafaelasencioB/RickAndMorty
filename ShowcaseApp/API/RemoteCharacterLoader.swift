//
//  RemoteCharacterLoader.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 14/11/22.
//

import Foundation

public protocol CharacterLoader {
    func load(fromURL url: URL, page: Int, completion: @escaping (LoadCharacterResult) -> Void )
}

public enum LoadCharacterResult {
    case success(CharacterResponseDTO)
    case failure(Error)
}
public class RemoteCharacterLoader: CharacterLoader {

    private let client: HTTPClient
    public init(client: HTTPClient) {
        self.client = client
    }

    public func load(fromURL url: URL, page: Int = 0, completion: @escaping (LoadCharacterResult) -> Void ) {
        client.get(from: url, completion: { result in
            switch result {
            case let .success((data, response)):
                guard response.statusCode == 200 else { completion(.failure(HTTPClientError.invalidResponse)); return }
                do {
                    let response = try JSONDecoder().decode(CharacterResponsePOSO.self, from: data)
                    completion(.success(response.asDTO()))
                } catch {
                    print("DEBUG: \(error)")
                    completion(.failure(HTTPClientError.invalidData))
                }
            case .failure:
                completion(.failure(HTTPClientError.connectivity))
            }
        })
    }
}
