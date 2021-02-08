//
//  NavigateSpiderViewModelTests.swift
//  IngenieSolutionTests
//
//  Created by Caolan Owens on 08/02/2021.
//

import XCTest
@testable import IngenieSolution

class NavigateSpiderViewModelTests: XCTestCase {

    // MARK: Injected Properties
    
    var viewModel: NavigateSpiderViewModel!
    
    // MARK: Test Lifecycle
    
    override func setUp() {
        super.setUp()
        let rectangleWall = RectangleWall(width: 7, height: 15)
        let spider = Spider(xPosition: 2, yPosition: 4, direction: .left)
        self.viewModel = NavigateSpiderViewModel(rectangleWall: rectangleWall, spider: spider)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    // MARK: Testing Functionality
    
    // MARK: navigateSpider Tests
    
    func testNavigateSpiderSuccess() {
        
        // Setup
        
        let instructionSet = "FLFLFRFFLF"
        var finalXPosition: Int = 0
        var finalYPosition: Int = 0
        var finalDirection: Direction = .up
        
        // Test
        
        viewModel.navigateSpider(with: instructionSet) { spiderPosition, error in
            if let error = error {
                XCTFail("Something has went wrong: \(error)")
            } else if let spiderPosition = spiderPosition {
                finalXPosition = spiderPosition.xPosition
                finalYPosition = spiderPosition.yPosition
                finalDirection = spiderPosition.direction
            }
        }
        
        // Assert
        
        XCTAssertEqual(finalXPosition, 3)
        XCTAssertEqual(finalYPosition, 1)
        XCTAssertEqual(finalDirection, .right)
    }
    
    func testNavigateSpiderFailure() {
        
        // Setup
        
        let instructionSet = "31231"
        var finalXPosition: Int = 0
        var finalYPosition: Int = 0
        var finalDirection: Direction = .up
        
        // Test
        
        viewModel.navigateSpider(with: instructionSet) { spiderPosition, error in
            if let error = error {
                XCTAssertNotNil(error)
            } else if let spiderPosition = spiderPosition {
                finalXPosition = spiderPosition.xPosition
                finalYPosition = spiderPosition.yPosition
                finalDirection = spiderPosition.direction
            }
        }
        
        // Assert
        
        XCTAssertNotEqual(finalXPosition, 3)
        XCTAssertNotEqual(finalYPosition, 1)
        XCTAssertNotEqual(finalDirection, .right)
    }
}
