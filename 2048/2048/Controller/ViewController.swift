//
//  ViewController.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 10/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gridView: UIView!
    
    let blockView = BlockView(block: .block2)
    let gameLogic = GameLogic()
    var tapGestureRecognizer: UITapGestureRecognizer!

    let gameBoardView = GameBoardView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(gameBoardView)
        view.addSubview(blockView)
        
        setUpGestureRecognizer()
    }
    
    private func setUpGestureRecognizer() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTappedGridView))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func didTappedGridView() {
        let tappedPointX = tapGestureRecognizer.location(in: view).x
        let point = gameLogic.validatePosition(tappedX: tappedPointX, block: blockView.blockState)
        
        blockView.frame.origin = point
    }
    
    
}
