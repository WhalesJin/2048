//
//  BlockView.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 10/5/23.
//

import UIKit

class BlockView: UIImageView {
    
    var x: CGFloat = 163 {
        didSet {
            self.frame.origin.x = x
        }
    }
    var y: CGFloat = 180 {
        didSet {
            self.frame.origin.y = y
        }
    }
    var blockState: Block {
        didSet {
            image = UIImage(named: blockState.rawValue)
        }
    }
    var timer: Timer?
    
    init(block: Block) {
        self.blockState = block
        super.init(frame: CGRect(x: 163, y: 180, width: 60, height: 60))
        
        configureUI(name: block.rawValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(name: String) {
        image = UIImage(named: name)
    }
    
    func moveDown( ) {
        guard y < 670 else {
            stopTimer()
            return
        }
        
        timer = Timer.scheduledTimer (withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            guard self.y < 670 else {
                stopTimer()
                return
            }
            
            self.y += 35
            self.frame = CGRect(x: self.x, y: self.y, width: 60, height: 60)
        }
    }
    
    func updateState() {
        blockState = blockState.levelUp
    }
    
    func stopTimer () {
        timer?.invalidate ()
        timer = nil
    }
}

enum Block: String {
    case block2 = "2Block"
    case block4 = "4Block"
    case block8 = "8Block"
    case block16 = "16Block"
    case block32 = "32Block"
    case block64 = "64Block"
    case block128 = "128Block"
    case block256 = "256Block"
    case block512 = "512Block"
    case block1024 = "1024Block"
    case block2048 = "2048Block"
    
    var levelUp: Block {
        switch self {
        case .block2:
            return .block4
        case .block4:
            return .block8
        case .block8:
            return .block16
        case .block16:
            return .block32
        case .block32:
            return .block64
        case .block64:
            return .block128
        case .block128:
            return .block256
        case .block256:
            return .block512
        case .block512:
            return .block1024
        case .block1024:
            return .block2048
        case .block2048:
            return .block2048
        }
    }
}
