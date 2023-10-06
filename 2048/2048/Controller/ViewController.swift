//
//  ViewController.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 10/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gridView: UIView!
    
    var blockView: BlockView?
    let gameLogic = GameLogic()
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    let gameBoardView = GameBoardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(gameBoardView)
        
        makeBlockView()
        setUpView()
        setUpGestureRecognizer()
    }
    
    private func setUpGestureRecognizer() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTappedGridView))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func didTappedGridView() {
        if gameLogic.isFull() {
            gameLogic.clear()
            view.subviews.forEach {
                if $0 is BlockView {
                    $0.removeFromSuperview()
                }
            }
            
            let alert = UIAlertController(title: "실패", message: "게임에서 졌습니다.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "아쉽네요", style: .cancel)
            alert.addAction(alertAction)
            
            present(alert, animated: true)
            makeBlockView()
            return
        } else {
            let tappedPointX = tapGestureRecognizer.location(in: view).x
            let point = gameLogic.validatePosition(tappedX: tappedPointX, block: blockView!)
            
            blockView?.frame.origin = point
            
            makeBlockView()
        }
    }
    
    func makeBlockView() {
        let blocks: [Block] = [.block2, .block4, .block8, .block16, .block32]
        
        blockView = BlockView(block: blocks.randomElement()!)
        
        view.addSubview(blockView!)
    }
}

extension ViewController {
    func setUpView() {
        view.backgroundColor = .customGreen1
    }
}
