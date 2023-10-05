//
//  BlockView.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 10/5/23.
//

import UIKit

class BlockView: UIImageView {
    
    var x = 160
    
    init(imageName: Block) {
        super.init(frame: CGRect(x: 160, y: 160, width: 55, height: 55))
        
        configureUI(name: imageName.rawValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(name: String) {
        image = UIImage(named: name)
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
