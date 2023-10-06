//
//  ViewController.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 10/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gridView: UIView!
    
    let puzzleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "puzzleIcon")
        imageView.frame = CGRect(x: 23, y: 110, width: 60, height: 60)
        
        return imageView
    }()
    
    let bestScoreLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 93, y: 110, width: 130, height: 60)
        label.text = "Best Score :"
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 233, y: 110, width: 120, height: 60)
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 40)
        
        return label
    }()
    
    var blockView = BlockView(block: .block2)
    let gameLogic = GameLogic()
    var tapGestureRecognizer: UITapGestureRecognizer!

    let gameBoardView = GameBoardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(puzzleImage)
        view.addSubview(bestScoreLabel)
        view.addSubview(scoreLabel)
        view.addSubview(gameBoardView)
        view.addSubview(blockView)
        
        
        setUpView()
        setUpGestureRecognizer()
    }
    
    private func setUpGestureRecognizer() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTappedGridView))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func didTappedGridView() {
        let tappedPointX = tapGestureRecognizer.location(in: view).x
        let point = gameLogic.validatePosition(tappedX: tappedPointX, block: blockView)
        
        blockView.frame.origin = point
        
        makeBlockView()
        
        var bestScore: String {
            String(gameLogic.findBestScore())
        }
        
        scoreLabel.text = bestScore
    }
    
    func makeBlockView() {
        let blocks: [Block] = [.block2, .block4, .block8, .block16, .block32]
        
        blockView = BlockView(block: blocks.randomElement()!)
        
        view.addSubview(blockView)
    }
}

extension ViewController {
    func setUpView() {
        view.backgroundColor = .customGreen1
    }
}
