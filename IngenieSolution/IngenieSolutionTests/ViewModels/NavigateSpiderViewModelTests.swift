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
        
        do {
            let spiderPosition = try viewModel.navigateSpider(with: instructionSet)
            finalXPosition = spiderPosition.xPosition
            finalYPosition = spiderPosition.yPosition
            finalDirection = spiderPosition.direction
        } catch {
            XCTFail("Spider navigation failed: \(error.localizedDescription)")
        }
        
        // Assert
        
        XCTAssertEqual(finalXPosition, 3)
        XCTAssertEqual(finalYPosition, 1)
        XCTAssertEqual(finalDirection, .right)
    }
    
    func testNavigateSpiderFailure() {
        
        // Setup
        
        let instructionSet = "31231"
        
        // Test

        // Assert
        
        XCTAssertThrowsError(try viewModel.navigateSpider(with: instructionSet))
    }
}
