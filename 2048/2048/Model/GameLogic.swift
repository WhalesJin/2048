//
//  GameLogic.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 2023/10/06.
//

import Foundation

final class Line {
    var list: [BlockView?] = [nil, nil, nil, nil, nil, nil, nil]
    
    func insert(_ block: BlockView?,at index: Int) {
        list[index] = block
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
    
    func findBestScore() -> Int {
        var bestScore: Int
        var blocks: [Block] = []
        
        line1.list.forEach { element in
            if let element {
                blocks.append(element.blockState)
            }
        }
        
        line2.list.forEach { element in
            if let element {
                blocks.append(element.blockState)
            }
        }
        
        line3.list.forEach { element in
            if let element {
                blocks.append(element.blockState)
            }
        }
        
        line4.list.forEach { element in
            if let element {
                blocks.append(element.blockState)
            }
        }
        
        line5.list.forEach { element in
            if let element {
                blocks.append(element.blockState)
            }
        }
        
        if blocks.contains(.block2048) {
            bestScore = 2048
        } else if blocks.contains(.block1024) {
            bestScore = 1024
        } else if blocks.contains(.block512) {
            bestScore = 512
        } else if blocks.contains(.block256) {
            bestScore = 256
        } else if blocks.contains(.block128) {
            bestScore = 128
        } else if blocks.contains(.block64) {
            bestScore = 64
        } else if blocks.contains(.block32) {
            bestScore = 32
        } else if blocks.contains(.block16) {
            bestScore = 16
        } else if blocks.contains(.block8) {
            bestScore = 8
        } else if blocks.contains(.block4) {
            bestScore = 4
        } else {
            bestScore = 2
        }
        
        return bestScore
    }
    
    func isLineFull(line: Line) -> Bool {
        return line.list.filter { $0 == nil }.count == 0
    }
    
    func isFull() -> Bool {
        return isLineFull(line: line1)
        || isLineFull(line: line2)
        || isLineFull(line: line3)
        || isLineFull(line: line4)
        || isLineFull(line: line5)
    }
    
    func clear() {
        line1 = Line()
        line2 = Line()
        line3 = Line()
        line4 = Line()
        line5 = Line()
    }
    
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
        
        for i in 0..<line.list.count-1 {
            if line.hasNext(i) {
                let nextBlockView = line.next(i)
                
                if compareBlockView(block, nextBlockView) {
                    block.updateState()
                    line.insert(block, at: i+1)
                    nextBlockView.removeFromSuperview()
                    return pointArray[i+1]
                }
                
                line.insert(block, at: i)
                return pointArray[i]
            } else if i == line.list.count-2 {
                line.insert(block, at: i+1)
                return pointArray[i+1]
            }
        }
        
        return validatePosition(tappedX: tappedX, block: block)
    }
    
    func compareBlockView(_ lhs: BlockView, _ rhs: BlockView) -> Bool {
        return lhs.blockState == rhs.blockState
    }
}
