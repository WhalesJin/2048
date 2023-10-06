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
        imageView.frame = CGRect(x: 23, y: 90, width: 60, height: 60)
        
        return imageView
    }()
    
    let bestScoreLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 93, y: 90, width: 130, height: 60)
        label.text = "Best Score :"
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 233, y: 90, width: 120, height: 60)
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 40)
        
        return label
    }()
    
    var blockView: BlockView?
    let gameLogic = GameLogic()
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    let gameBoardView = GameBoardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(puzzleImage)
        view.addSubview(bestScoreLabel)
        view.addSubview(scoreLabel)
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
//        let tappedPointX = tapGestureRecognizer.location(in: view).x
//        let point = gameLogic.validatePosition(tappedX: tappedPointX, block: blockView)
//
//        blockView.frame.origin = point
//
//        makeBlockView()
//
//        var bestScore: String {
//            String(gameLogic.findBestScore())
//        }
//
//        scoreLabel.text = bestScore
        
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
            
            var bestScore: String {
                String(gameLogic.findBestScore())
            }
            
            scoreLabel.text = bestScore
            
            return
        } else {
            let tappedPointX = tapGestureRecognizer.location(in: view).x
            let point = gameLogic.validatePosition(tappedX: tappedPointX, block: blockView!)
            
            blockView?.frame.origin = point
            
            makeBlockView()
            
            var bestScore: String {
                String(gameLogic.findBestScore())
            }
            
            scoreLabel.text = bestScore
        }
        
        if scoreLabel.text == "128" {
            gameClear()
        }
        
    }
    
    func gameClear() {
        let alert = UIAlertController(title: "성공", message: "128을 만들었습니다.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "야호!", style: .cancel)
        alert.addAction(alertAction)
        
        present(alert, animated: true)
        
        makeBlockView()
    
    }
    
    func makeBlockView() {
        let blocks: [Block] = [.block2, .block4, .block8, .block16, .block32, .block64]
        
        blockView = BlockView(block: blocks.randomElement()!)
        
        view.addSubview(blockView!)
    }
}

extension ViewController {
    func setUpView() {
        view.backgroundColor = .customGreen1
    }
}
