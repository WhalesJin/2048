//
//  GameLogic.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 2023/10/06.
//

import Foundation

final class Line {
    var list: [BlockView?] = [nil, nil, nil, nil, nil, nil, nil]
    
    func insert(_ block: BlockView,at index: Int) {
        list.insert(block, at: index)
    }
    
    func hasNext(_ index: Int) -> Bool {
        return list[index + 1] != nil
    }
    
    func next(_ index: Int) -> BlockView {
        return list[index + 1]!
    }
}

final class GameLogic {
    var line1: Line = Line()
    var line2: Line = Line()
    var line3: Line = Line()
    var line4: Line = Line()
    var line5: Line = Line()
    
    func decideLine(tappedX: CGFloat) -> (Line, [CGPoint]) {
        if tappedX >= 27, tappedX < 95 {
            return (line1, pointArray1)
        } else if tappedX >= 95, tappedX < 163 {
            return (line2, pointArray2)
        } else if tappedX >= 163, tappedX < 231 {
            return (line3, pointArray3)
        } else if tappedX >= 231, tappedX < 299 {
            return (line4, pointArray4)
        } else {
            return (line5, pointArray5)
        }
    }
    
    func validatePosition(tappedX: CGFloat, block: BlockView) -> CGPoint {
        let (line, pointArray) = decideLine(tappedX: tappedX)
        var index = 0
        
        for i in 0..<line.list.count-1 {
            if line.hasNext(i) {
                let nextBlockView = line.next(i)
                
                if compareBlockView(block, nextBlockView) {
                    block.updateState()
                    line.insert(block, at: i+1)
                    nextBlockView.removeFromSuperview()
                    index = i+1
                    break
                }
                
                line.insert(block, at: i)
                index = i
                break
            } else if i == line.list.count-2 {
                line.insert(block, at: i+1)
                index = i+1
                break
            }
        }
        compareAroundBlockView(block: block)
        
        return pointArray[index]
    }
    //line1일 때는 아래, 오른쪽(line2)
    func compareAroundBlockView(block: BlockView) {
        let x = block.frame.origin.x
        let y = block.frame.origin.y
        let lines: [Line] = [line1, line2, line3, line4, line5]
        let lineIndex: Int
        let index: Int
        
        switch x {
        case 27:
            lineIndex = 0
        case 95:
            lineIndex = 1
        case 163:
            lineIndex = 2
        case 231:
            lineIndex = 3
        default:
            lineIndex = 4
        }
        
        switch y {
        case 250:
            index = 0
        case 320:
            index = 1
        case 390:
            index = 2
        case 460:
            index = 3
        case 530:
            index = 4
        case 600:
            index = 5
        default:
            index = 6
        }
        
        if index == 6 {
            if let leftBlock = lines[safe: lineIndex - 1]?.list[index], compareBlockView(block, leftBlock) {
                if let rightBlock = lines[safe: lineIndex + 1]?.list[index], compareBlockView(block, rightBlock) {
                    block.updateState()
                    block.updateState()
                } else {
                    block.updateState()
                }
            } else if let rightBlock = lines[safe: lineIndex + 1]?.list[index], compareBlockView(block, rightBlock) {
                block.updateState()
            }
            return
        }
        
        if let leftBlock = lines[safe: lineIndex - 1]?.list[index], compareBlockView(block, leftBlock) {
            if let rightBlock = lines[safe: lineIndex + 1]?.list[index], compareBlockView(block, rightBlock) {
                if let underBlock = lines[lineIndex].list[index + 1], compareBlockView(block, underBlock) { // 아 == 나
                    block.updateState()
                    block.updateState()
                    block.updateState()
                } else { // 왼,오 == 나
                    block.updateState()
                    block.updateState()
                }
            } else if let underBlock = lines[lineIndex].list[index + 1], compareBlockView(block, underBlock) { // 왼,아 == 나
                block.updateState()
                block.updateState()
            } else { // 왼 == 나
                block.updateState()
            }
        } else if let rightBlock = lines[safe: lineIndex + 1]?.list[index], compareBlockView(block, rightBlock) {
            if let underBlock = lines[lineIndex].list[index + 1], compareBlockView(block, underBlock) { // 오, 아 == 나
                block.updateState()
                block.updateState()
            } else { // 오 == 나
                block.updateState()
            }
        } else if let underBlock = lines[lineIndex].list[index + 1], compareBlockView(block, underBlock) { // 아 == 나
            block.updateState()
        }
    }
    
    func compareBlockView(_ lhs: BlockView, _ rhs: BlockView) -> Bool {
        return lhs.blockState == rhs.blockState
    }
}
