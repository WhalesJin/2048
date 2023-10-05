//
//  BlockView.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 10/5/23.
//

import UIKit

class BlockView: UIView {
    var numberImage: UIImageView {
        var imageView = UIImageView()
        imageView.frame.size = CGSize(width: 55, height: 55)
        
        return imageView
    }
    
    var imageName: Block
    
    init(imageName: Block) {
        self.imageName = imageName
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        numberImage.image = UIImage(named: imageName.rawValue)
        
        self.addSubview(numberImage)
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
