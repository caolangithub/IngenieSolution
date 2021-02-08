//
//  NavigateSpiderViewModel.swift
//  IngenieSolution
//
//  Created by Caolan Owens on 08/02/2021.
//

import Foundation

/*
 NavigateSpiderViewModel
 */

internal final class NavigateSpiderViewModel {
    
    // MARK: Injected Properties
    
    private var rectangleWall: RectangleWall
    private var spider: Spider
    
    // MARK: Nested Types
    
    typealias SpiderPosition = (xPosition: Int, yPosition: Int, direction: Direction)
    
    // MARK: Initialiser
    
    init(rectangleWall: RectangleWall, spider: Spider) {
        self.rectangleWall = rectangleWall
        self.spider = spider
    }
}

// MARK: Public Functions

extension NavigateSpiderViewModel {
    
    func navigateSpider(with instructionSet: String) throws -> SpiderPosition {
        for character in instructionSet {
            let uppercaseCharacter = character.uppercased()
            guard let command = Command.init(rawValue: uppercaseCharacter) else {
                throw NavigationError.incorrectCommand
            }
            moveSpider(with: command)
        }
        return SpiderPosition(spider.xPosition, spider.yPosition, spider.direction)
    }
}

// MARK: Private Functions

private extension NavigateSpiderViewModel {

    func moveSpider(with command: Command) {
        switch command {
        case .left: turnSpiderLeft()
        case .right: turnSpiderRight()
        case .forward: moveSpiderForward()
        }
    }

    func turnSpiderLeft() {
        switch spider.direction {
        case .up:
            spider.direction = .left
        case .left:
            spider.direction = .down
        case .down:
            spider.direction = .right
        case .right:
            spider.direction = .up
        }
    }
    
    func turnSpiderRight() {
        switch spider.direction {
        case .up:
            spider.direction = .right
        case .left:
            spider.direction = .up
        case .down:
            spider.direction = .left
        case .right:
            spider.direction = .down
        }
    }
    
    func moveSpiderForward() {
        switch spider.direction {
        case .up:
            if spider.yPosition + 1 <= rectangleWall.height {
                spider.yPosition = spider.yPosition + 1
            }
        case .left:
            if spider.xPosition - 1 >= 0 {
                spider.xPosition = spider.xPosition - 1
            }
        case .right:
            if spider.xPosition + 1 <= rectangleWall.width {
                spider.xPosition = spider.xPosition + 1
            }
        case .down:
            if spider.yPosition - 1 >= 0 {
                spider.yPosition = spider.yPosition - 1
            }
        }
    }
}
