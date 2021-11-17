//
//  MockURLProtocol.swift
//  CoffeeExplorerTests
//
//  Created by ar on 18/11/2021.
//

import Foundation

@objc class MockURLProtocol: URLProtocol {
    
    static var mocks = [String: Data]()
    static var response: URLResponse?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canInit(with task: URLSessionTask) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    
    override func startLoading() {
        
        if let path = request.url?.path,
           let data = MockURLProtocol.mocks[path]  {
            self.client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = MockURLProtocol.response {
            self.client?.urlProtocol(self,
                                     didReceive: response,
                                     cacheStoragePolicy: .notAllowed)
        }
        
        if let error = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
