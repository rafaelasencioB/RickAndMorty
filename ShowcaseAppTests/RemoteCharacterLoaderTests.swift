//
//  ShowcaseAppTests.swift
//  ShowcaseAppTests
//
//  Created by Rafael Asencio on 13/11/22.
//

import XCTest
import Foundation
import ShowcaseApp

final class RemoteCharacterLoaderTests: XCTestCase {

    private var sut: RemoteCharacterLoader!
    private var client: HTTPClientSpy!
    private let url = URL(string: "https://any-url.com")!

    override func setUp() {
        super.setUp()
        client = HTTPClientSpy()
        sut = RemoteCharacterLoader(client: client)
    }

    override func tearDown() {
        super.tearDown()
        client = nil
        sut = nil
    }

    func test_load_deliversErrorOnClientError() {
        sut.load(fromURL: url) { result in
            switch result {
            case .failure(let error as HTTPClientError):
                XCTAssertEqual(error, HTTPClientError.connectivity)
            default:
                XCTFail("Expected error, got \(result)")
            }
        }
        client.complete(with: HTTPClientError.connectivity)
    }

    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        sut.load(fromURL: url) { result in
            switch result {
            case .failure(let error as HTTPClientError):
                XCTAssertEqual(error, .invalidData)
            default:
                XCTFail("expected error, got \(result)")
            }
        }
        let invalidJSONData = Data("invalid json".utf8)
        client.complete(withStatusCode: 200, data: invalidJSONData)
    }

    func test_load_deliversErrorOnNon200HTTPResponse() {

        [199, 201, 300, 400].enumerated().forEach { index, code in
            let emptyData = Data("".utf8)
            sut.load(fromURL: url) { result in
                switch result {
                case .failure(let error as HTTPClientError):
                    XCTAssertEqual(error, HTTPClientError.invalidResponse)
                default:
                    XCTFail("expected error, got \(result)")
                }
            }
            client.complete(withStatusCode: code, data: emptyData, at: index)
        }
    }

    func test_load_deliversItemsOn200HTTPResponse() {
        let character1 = CharacterItemDTOBuilder().build()

        sut.load(fromURL: url) { result in
            switch result {
            case .success(let items):
                XCTAssertEqual(items, [character1])
            default:
                XCTFail("Expected error, got \(result)")
            }
        }

        let origin1JSON = [
            "url": character1.origin.url,
            "name": character1.origin.name
        ]
        let location1JSON = [
            "url": character1.location.url,
            "name": character1.location.name
        ]
        let character1JSON: [String : Any] = [
            "id": character1.id,
            "name": character1.name,
            "status": character1.status.rawValue,
            "species": character1.species.rawValue,
            "type": character1.type,
            "gender": character1.gender.rawValue,
            "origin": origin1JSON,
            "location": location1JSON,
            "image": character1.image,
            "episode": character1.episode,
            "url": character1.url,
            "created": character1.created
        ]
        let characterInfoJSON: [String: Any?] = [
            "count": 826,
            "pages": 42,
            "next": "https://rickandmortyapi.com/api/character/?page=2",
            "prev": nil
        ]
        let objects: [String : Any] = [
            "info": characterInfoJSON,
            "results": [character1JSON]
        ]

        let data = try! JSONSerialization.data(withJSONObject: objects)
        client.complete(withStatusCode: 200, data: data)
    }

    //MARK: Helpers
    private class HTTPClientSpy: HTTPClient {
        var requestedURLs: [URL] {
            return receivedMessages.map { $0.url }
        }

        var receivedMessages = [(url: URL, completion: HTTPClientResult)]()

        func get(from url: URL, completion: @escaping HTTPClientResult) {
            receivedMessages.append((url, completion))
        }

        func complete(with error: Error, at index: Int = 0) {
            receivedMessages[index].completion(.failure(error))
        }

        func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[index], statusCode: code, httpVersion: nil, headerFields: nil)!
            receivedMessages[index].completion(.success((data, response)))
        }
    }

}
