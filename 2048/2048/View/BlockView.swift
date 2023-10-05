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
    var blockState: Block
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
}
