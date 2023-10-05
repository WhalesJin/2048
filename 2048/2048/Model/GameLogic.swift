//
//  GameLogic.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 2023/10/06.
//

import Foundation

final class GameLogic {
    var line1: [Block?] = [nil, nil, nil, nil, nil, nil, nil]
    var line2: [Block?] = [nil, nil, nil, nil, nil, nil, nil]
    var line3: [Block?] = [nil, nil, nil, nil, nil, nil, nil]
    var line4: [Block?] = [nil, nil, nil, nil, nil, nil, nil]
    var line5: [Block?] = [nil, nil, nil, nil, nil, nil, nil]
    
    func validatePosition(tappedX: CGFloat, block: Block) -> CGPoint {
        if tappedX >= 23, tappedX < 93 {
            for i in 0...line1.count {
                if line1[safe: i+1] != nil {
                    continue
                } else {
                    line1[i] = block
                }
            }
        } else if tappedX >= 93, tappedX < 163 {
            for i in 0...line2.count {
                if line2[safe: i+1] != nil {
                    continue
                } else {
                    line2[i] = block
                }
            }
        } else if tappedX >= 163, tappedX < 233 {
            for i in 0...line3.count {
                if line3[safe: i+1] != nil {
                    continue
                } else {
                    line3[i] = block
                }
            }
        } else if tappedX >= 233, tappedX < 303 {
            for i in 0...line4.count {
                if line4[safe: i+1] != nil {
                    continue
                } else {
                    line4[i] = block
                }
            }
        } else {
            for i in 0...line5.count {
                if line5[safe: i+1] != nil {
                    continue
                } else {
                    line5[i] = block
                }
            }
        }
        
        return .zero
    }
}
