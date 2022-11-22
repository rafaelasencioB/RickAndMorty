//
//  HTTPClient.swift
//  ShowcaseApp
//
//  Created by Rafael Asencio on 14/11/22.
//

import Foundation

public protocol HTTPClient {
    typealias HTTPClientResult = (Result<(Data, HTTPURLResponse), Error>) -> Void

    func get(from url: URL, completion: @escaping HTTPClientResult)
}

public enum HTTPClientError: Error {
    case connectivity
    case invalidResponse
    case invalidData
}
