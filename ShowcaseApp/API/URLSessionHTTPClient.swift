//
//  URLSessionHTTPClient.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 14/11/22.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {

    private let session: URLSession
    public init(session: URLSession = .shared) {
        self.session = session
    }

    struct UnexpectedValuesRepresentation: Error {}
    public func get(from url: URL, completion: @escaping HTTPClientResult) {
        session.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(UnexpectedValuesRepresentation()))
                    return
                }
                completion(.success((data, response)))
            }
        }).resume()
    }
}
