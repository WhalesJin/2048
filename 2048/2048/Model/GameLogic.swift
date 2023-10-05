//
//  GameLogic.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 2023/10/06.
//

import Foundation

final class Line {
    var list: [Block?] = [nil, nil, nil, nil, nil, nil, nil]
    
    func insert(_ block: Block,at index: Int) {
        list.insert(block, at: index)
    }
    
    func hasNext(_ index: Int) -> Bool {
        return list[index + 1] != nil
    }
    
    func next(_ index: Int) -> Block {
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
        if tappedX >= 23, tappedX < 93 {
            return (line1, pointArray1)
        } else if tappedX >= 93, tappedX < 163 {
            return (line2, pointArray2)
        } else if tappedX >= 163, tappedX < 233 {
            return (line3, pointArray3)
        } else if tappedX >= 233, tappedX < 303 {
            return (line4, pointArray4)
        } else {
            return (line5, pointArray5)
        }
    }
    
    func validatePosition(tappedX: CGFloat, block: Block) -> CGPoint {
        let (line, pointArray) = decideLine(tappedX: tappedX)
        var index = 0
        
        for i in 0..<line.list.count-1 {
            if line.hasNext(i) {
                line.insert(block, at: i)
                index = i
                break
            } else if i == line.list.count-2 {
                line.insert(block, at: i+1)
                index = i+1
                break
            }
        }
        
        return pointArray[index]
    }
}
