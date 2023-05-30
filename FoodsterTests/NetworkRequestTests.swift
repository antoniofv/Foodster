//
//  NetworkRequestTests.swift
//  FoodsterTests
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import XCTest
@testable import Foodtests


final class NetworkRequestTests: XCTestCase {

    func testNetworkRequest() throws {
        let baseUrl = "http://mock.com"
        let path = "/users"
        let parameters = [
            URLQueryItem(name: "name", value: "Peter"),
            URLQueryItem(name: "surname", value: "Pan"),
        ]


        let request = NetworkRequest<String>(baseUrl: baseUrl)

        XCTAssertEqual(request.url, URL(string: baseUrl)!)


        let request2 = NetworkRequest<String>(
            baseUrl: baseUrl,
            path: path
        )

        XCTAssertEqual(request2.url, URL(string: "http://mock.com/users")!)


        let request3 = NetworkRequest<String>(
            baseUrl: baseUrl,
            path: path,
            parameters: parameters
        )

        XCTAssertEqual(request3.url, URL(string: "http://mock.com/users?name=Peter&surname=Pan")!)


        let request4 = NetworkRequest<String>(
            baseUrl: baseUrl,
            parameters: parameters
        )

        XCTAssertEqual(request4.url, URL(string: "http://mock.com?name=Peter&surname=Pan")!)


        let request5 = NetworkRequest<String>(
            baseUrl: baseUrl + "/v1/1",
            path: path,
            parameters: parameters
        )

        XCTAssertEqual(request5.url, URL(string: "http://mock.com/v1/1/users?name=Peter&surname=Pan")!)
    }

}
