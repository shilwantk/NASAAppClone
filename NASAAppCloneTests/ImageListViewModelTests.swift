//
//  ImageListViewModelTests.swift
//  NASAAppCloneTests
//
//  Created by Kirti S on 2/22/23.
//

import XCTest
@testable import NASAAppClone

final class ImageListViewModelTests: XCTestCase {
    
    let sut = ImageListViewModel()

    override func setUpWithError() throws {
        
        let image1 = Image(title: "Sample Image 1", date: "2023-22-01", explanation: "Sample explanation for an image 1", url: "Sample url for image 1")
        let image2 = Image(title: "Sample Image 2", date: "2023-22-02", explanation: "Sample explanation for an image 2", url: "Sample url for image 2")
        let image3 = Image(title: "Sample Image 3", date: "2023-22-03", explanation: "Sample explanation for an image 3", url: "Sample url for image 3")
        let image4 = Image(title: "Sample Image 4", date: "2023-22-04", explanation: "Sample explanation for an image 4", url: "Sample url for image 4")
        
        sut.imagesArray.append(image1)
        sut.imagesArray.append(image2)
        sut.imagesArray.append(image3)
        sut.imagesArray.append(image4)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetCollectionViewItemCount () {
        XCTAssertEqual(sut.imagesArray.count, 4)
    }
    
    func testGetSelectedImageDataAt() {
        let index = 1
        let image = sut.getSelectedImageDataAt(index: index)
        
        XCTAssertEqual(image.title, "Sample Image 2")
        XCTAssertEqual(image.date, "2023-22-02")
        XCTAssertEqual(image.explanation, "Sample explanation for an image 2")
        XCTAssertEqual(image.url, "Sample url for image 2")
    }
    
    func testSetSelectedImageTo() {
        
        let index = 2
        sut.setSelectedImageTo(index: index)
        
        XCTAssertEqual(sut.selectedImage!.title, "Sample Image 3")
        XCTAssertEqual(sut.selectedImage!.date, "2023-22-03")
        XCTAssertEqual(sut.selectedImage!.explanation, "Sample explanation for an image 3")
        XCTAssertEqual(sut.selectedImage!.url, "Sample url for image 3")
        XCTAssertEqual(sut.selectedIndex, 2)
    }
    
    func testGetSelectedImage() {
        
        let index = 2
        sut.setSelectedImageTo(index: index)
        let image = sut.selectedImage
        
        XCTAssertEqual(image?.title, "Sample Image 3")
        XCTAssertEqual(image?.date, "2023-22-03")
        XCTAssertEqual(image?.explanation, "Sample explanation for an image 3")
        XCTAssertEqual(image?.url, "Sample url for image 3")
    }
    
    func testUpdateSelectedIndexTo() {
        let index = 3
        sut.updateSelectedIndexTo(index: index)
        XCTAssertEqual(sut.selectedIndex,3)
    }
}
