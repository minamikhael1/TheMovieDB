//
//  URLRequestExtentionTests.swift
//  TheMovieDBTests
//
//  Created by Mina Mikhael on 28.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation
import XCTest
@testable import TheMovieDB

class URLRequestExtentionTests: XCTestCase {
    
    func testInit() {
        let parameters = ["MockParamter": "value"]
        let mockService = MockService(paramters: parameters)
        let urlRequest = URLRequest(service: mockService)
        let urlStringWithParmaters = "https://MockService/ios?MockParamter=value"
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?.first?.key, mockService.headers?.keys.first)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?.first?.value, mockService.headers?.values.first)
        XCTAssertEqual(urlRequest.httpMethod, mockService.method.rawValue)
        XCTAssertEqual(urlRequest.url?.absoluteString, urlStringWithParmaters)
    }
}
