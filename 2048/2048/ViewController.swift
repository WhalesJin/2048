//
//  ViewController.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 10/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    let block = BlockView(imageName: .block2)
    let gameBoard = GameBoardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(gameBoard)
        
//        view.addSubview(block)
//        block.moveDown()
    }
}

