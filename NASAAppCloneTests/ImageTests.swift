//
//  ImageTests.swift
//  NASAAppCloneTests
//
//  Created by Kirti S on 2/22/23.
//

import XCTest
@testable import NASAAppClone

final class ImageTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testImageModel() {
        let image = Image(title: "Sample Image", date: "2023-22-02", explanation: "Sample explanation for an image", url: "Sample url for image")
        XCTAssertEqual(image.title, "Sample Image")
        XCTAssertEqual(image.date, "2023-22-02")
        XCTAssertEqual(image.explanation, "Sample explanation for an image")
        XCTAssertEqual(image.url, "Sample url for image")
    }
}
