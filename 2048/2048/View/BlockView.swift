//
//  BlockView.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 10/5/23.
//

import UIKit

class BlockView: UIImageView {
    private var x: CGFloat = 163 {
        didSet {
            self.frame.origin.x = x
        }
    }
    private var y: CGFloat = 180 {
        didSet {
            self.frame.origin.y = y
        }
    }
    var blockState: Block {
        didSet {
            image = UIImage(named: blockState.rawValue)
            runSpringAnimation()
        }
    }
    private var timer: Timer?
    
    init(block: Block) {
        self.blockState = block
        
        let width = UIScreen.main.bounds.width
        
        if width >= 380 {
            super.init(frame: CGRect(x: UIScreen.main.bounds.midX - 30, 
                                     y: UIScreen.main.bounds.midY - 226,
                                     width: 60,
                                     height: 60))
        } else {
            let a = width / 38
            
            super.init(frame: CGRect(x: UIScreen.main.bounds.midX - 3 * a, 
                                     y: UIScreen.main.bounds.midY - 22.6 * a,
                                     width: 6 * a,
                                     height: 6 * a))
        }
        
        configureUI(name: block.rawValue)
        runSpringAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(name: String) {
        image = UIImage(named: name)
    }
    
    private func moveDown( ) {
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
    
    private func stopTimer () {
        timer?.invalidate ()
        timer = nil
    }
    
    private func runSpringAnimation() {
        let jump = CASpringAnimation(keyPath: "transform.scale")
        jump.damping = 15
        jump.mass = 1
        jump.initialVelocity = 10
        jump.stiffness = 100
        jump.fromValue = 0
        jump.toValue = 1
        jump.duration = jump.settlingDuration
        
        self.layer.add(jump, forKey: nil)
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
    case deleteBlock = "DeleteBlock"
    case evenEmpty = "EvenEmpty"
    case oddEmpty = "OddEmpty"
    
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
        default:
            return self
        }
    }
}
