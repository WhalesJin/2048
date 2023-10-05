//
//  ViewController.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 10/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gridView: UIView!
    
    let block = BlockView(imageName: .block2)
    var tapGestureRecognizer: UITapGestureRecognizer!
    var gameBoard = [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    let gameBoard = GameBoardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(gameBoard)
        
//        view.addSubview(block)
//        block.moveDown()
    }
}

        view.addSubview(block)
//        setUPGestureRecognizer()
//        block.moveDown()
    }
    
    private func setUPGestureRecognizer() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTappedGridView))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func didTappedGridView() {
        let tappedPointX = tapGestureRecognizer.location(in: view).x
        
        if tappedPointX >= 23, tappedPointX < 93 {
            block.x = 23
        } else if tappedPointX >= 93, tappedPointX < 163 {
            block.x = 93
        } else if tappedPointX >= 163, tappedPointX < 233 {
            block.x = 163
        } else if tappedPointX >= 233, tappedPointX < 303 {
            block.x = 233
        } else {
            block.x = 303
        }
    }
    
    
}
