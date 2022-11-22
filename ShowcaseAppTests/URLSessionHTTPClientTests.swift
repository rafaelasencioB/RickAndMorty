//
//  URLSessionHTTPClientTests.swift
//  ShowcaseAppTests
//
//  Created by Rafael Asencio on 14/11/22.
//

import XCTest
import ShowcaseApp


final class URLSessionHTTPClientTests: XCTestCase {

    private var sut: URLSessionHTTPClient!
    private var session: URLProtocolStub!

    override func setUp() {
        super.setUp()
        sut = URLSessionHTTPClient()
        URLProtocolStub.startInterceptingRequest()

    }
    override func tearDown() {
        super.tearDown()
        sut = nil
        URLProtocolStub.stopInterceptingRequest()
    }

    func test_getFromURL_performsGETRequestWithURL() {
        let url = URL(string: "https://any-url.com")!
        let exp = expectation(description: "wait for completion")

        URLProtocolStub.observeRequest { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
        }
        sut.get(from: url, completion: { _ in })
        wait(for: [exp], timeout: 5.0)
    }

    func test_getFromURL_failsOnRequestError() {
        let url = URL(string: "https://any-url.com")!
        let error = NSError(domain: "Test", code: 0)
        URLProtocolStub.stub(data: nil, response: nil, error: error)

        let exp = expectation(description: "wait for completion")
        sut.get(from: url) { result in
            switch result {
            case let .failure(receivedError as NSError):
                XCTAssertEqual(receivedError.code, error.code)
                XCTAssertEqual(receivedError.domain, error.domain)
            default:
                XCTFail("Expected error, got \(result)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
    }

    func test_getFromURL_succeedsHTTPURLResponseWithEmptyData() {
        let url = URL(string: "https://any-url.com")!
        let data = Data()
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        URLProtocolStub.stub(data: data, response: response, error: nil)
        let exp = expectation(description: "wait for completion")
        sut.get(from: url, completion: { result in
            switch result {
            case let .success((receivedData, receivedResponse)):
                XCTAssertEqual(receivedData, data)
                XCTAssertEqual(receivedResponse.url, response?.url)
                XCTAssertEqual(receivedResponse.statusCode, response?.statusCode)
            default:
                XCTFail("Expected success, got \(result)")
            }
            exp.fulfill()
        })
        wait(for: [exp], timeout: 5.0)
    }

    func test_getFromURL_succeedsHTTPURLResponseWithData() {
        let url = URL(string: "https://any-url.com")!
        let data = Data("any data".utf8)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        URLProtocolStub.stub(data: data, response: response, error: nil)
        let exp = expectation(description: "wait for completion")
        sut.get(from: url, completion: { result in
            switch result {
            case let .success((receivedData, receivedResponse)):
                XCTAssertEqual(receivedData, data)
                XCTAssertEqual(receivedResponse.url, response?.url)
                XCTAssertEqual(receivedResponse.statusCode, response?.statusCode)
            default:
                XCTFail("Expected success, got \(result)")
            }
            exp.fulfill()
        })
        wait(for: [exp], timeout: 5.0)
    }

    //MARK: Helpers
    private class URLProtocolStub: URLProtocol {
        struct Stub {
            let data: Data?
            let response: URLResponse?
            let error: Error?
        }

        private static var stub: Stub?
        private static var requestObserver: ((URLRequest) -> Void)?

        static func stub(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
            stub = Stub(data: data, response: response, error: error)
        }

        static func observeRequest(observer: @escaping (URLRequest) -> Void) {
            requestObserver = observer
        }

        static func startInterceptingRequest() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }

        static func stopInterceptingRequest() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
            stub = nil
            requestObserver = nil
        }

        override class func canInit(with request: URLRequest) -> Bool {
            requestObserver?(request)
            return  true
        }

        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }

        override func startLoading() {

            if let data = URLProtocolStub.stub?.data {
                client?.urlProtocol(self, didLoad: data)
            }
            if let response = URLProtocolStub.stub?.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let error = URLProtocolStub.stub?.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            client?.urlProtocolDidFinishLoading(self)
        }

        override func stopLoading() {}
    }

}
