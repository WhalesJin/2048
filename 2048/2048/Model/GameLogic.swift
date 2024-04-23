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
        if index - 1 >= 0 {
            list[index - 1] = nil
        }
        
        list[index] = block
    }
    
    func hasNext(_ index: Int) -> Bool {
        return list[index + 1] != nil
    }
    
    func next(_ index: Int) -> BlockView {
        return list[index + 1]!
    }
    
    func delete(_ index: Int) {
        list[index] = nil
    }
}

final class GameLogic {
    private var line1: Line = Line()
    private var line2: Line = Line()
    private var line3: Line = Line()
    private var line4: Line = Line()
    private var line5: Line = Line()
    private let pointArray: PointArray
    
    init(_ width: Double, _ centerX: Double, _ centerY: Double) {
        pointArray = PointArray(width, centerX, centerY)
    }
    
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
        } else if blocks.contains(.block2) {
            bestScore = 2
        } else {
            bestScore = 0
        }
        
        return bestScore
    }
    
    func isFull() -> Bool {
        return isLineFull(line: line1)
        || isLineFull(line: line2)
        || isLineFull(line: line3)
        || isLineFull(line: line4)
        || isLineFull(line: line5)
    }
    
    private func isLineFull(line: Line) -> Bool {
        return line.list.filter { $0 == nil }.count == 0
    }
    
    func clear() {
        line1 = Line()
        line2 = Line()
        line3 = Line()
        line4 = Line()
        line5 = Line()
    }
    
    private func decideLine(tappedX: CGFloat) -> (Line, [CGPoint]) {
        let pointArray1 = pointArray.pointArray1
        let pointArray2 = pointArray.pointArray2
        let pointArray3 = pointArray.pointArray3
        let pointArray4 = pointArray.pointArray4
        let pointArray5 = pointArray.pointArray5
        
        let a = pointArray2[0].x
        let b = pointArray3[0].x
        let c = pointArray4[0].x
        let d = pointArray5[0].x
        
        if tappedX < a {
            return (line1, pointArray1)
        } else if tappedX >= a, tappedX < b {
            return (line2, pointArray2)
        } else if tappedX >= b, tappedX < c {
            return (line3, pointArray3)
        } else if tappedX >= c, tappedX < d {
            return (line4, pointArray4)
        } else {
            return (line5, pointArray5)
        }
    }
    
    func validatePosition(tappedX: CGFloat, block: BlockView) -> (CGPoint, Block) {
        let (line, pointArray) = decideLine(tappedX: tappedX)
        var point: CGPoint = CGPoint(x: 0, y: 0)
        var block = block
        var blockState = block.blockState
        let lastIndex = line.list.count-1
        
        if line.list[lastIndex] == nil,
            blockState != .deleteBlock,
            blockState != .downBlock
        {
            line.insert(block, at: lastIndex)
            point = pointArray[lastIndex]
            return (point, blockState)
        }
        
        for i in 0..<lastIndex {
            if line.hasNext(i) {
                var nextBlockView = line.next(i)
                
                if block.blockState == .deleteBlock {
                    nextBlockView.removeFromSuperview()
                    line.delete(i+1)
                    point = pointArray[i+1]
                    break
                }
                
                if block.blockState == .downBlock {
                    if nextBlockView.blockState == .block2 {
                        nextBlockView.removeFromSuperview()
                        line.delete(i+1)
                        break
                    } else {
                        block.blockState = nextBlockView.blockState
                        block.downState()
                        blockState = block.blockState
                        line.insert(block, at: i+1)
                        point = pointArray[i+1]
                        nextBlockView.removeFromSuperview()
                        continue
                    }
                }
                
                if compareBlockView(block, nextBlockView) == false {
                    line.insert(block, at: i)
                    point = pointArray[i]
                    break
                }
                
                block.updateState()
                blockState = block.blockState
                nextBlockView.removeFromSuperview()
                line.insert(block, at: i+1)
                point = pointArray[i+1]
            }
        }
        
        return (point, blockState)
    }
    
    private func compareBlockView(_ lhs: BlockView, _ rhs: BlockView) -> Bool {
        return lhs.blockState == rhs.blockState
    }
}
