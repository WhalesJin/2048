//
//  ViewController.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 10/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gridView: UIView!
    
    private let puzzleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "puzzleIcon")
        imageView.frame = CGRect(x: 23, y: 90, width: 60, height: 60)
        
        return imageView
    }()
    
    private let bestScoreLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 93, y: 90, width: 130, height: 60)
        label.text = "Best Score :"
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 233, y: 90, width: 120, height: 60)
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 40)
        
        return label
    }()
    
    private var blockView: BlockView?
    private let gameLogic = GameLogic()
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    private let gameBoardView = GameBoardView()
    
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
        guard scoreLabel.text != "2048" else {
            gameClear()
            return
        }
        
        if gameLogic.isFull() {
            gameFail()
        } else {
            let tappedPointX = tapGestureRecognizer.location(in: view).x
            let point = gameLogic.validatePosition(tappedX: tappedPointX, block: blockView!)
            
            blockView?.frame.origin = point
            
            makeBlockView()
        }
        
        var bestScore: String {
            String(gameLogic.findBestScore())
        }
        
        scoreLabel.text = bestScore
        
        if scoreLabel.text == "2048" {
            gameClear()
        }
    }

    private func gameFail() {
        let alert = UIAlertController(title: "실패", message: "게임에서 졌습니다.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "아쉽네요", style: .default)
        let restartAction = UIAlertAction(title: "재도전", style: .default) { _ in
            self.gameLogic.clear()
            self.view.subviews.forEach {
                if $0 is BlockView {
                    $0.removeFromSuperview()
                }
            }
            self.scoreLabel.text = "0"
            self.makeBlockView()
        }
        
        alert.addAction(alertAction)
        alert.addAction(restartAction)
        
        present(alert, animated: true)
    }

    private func gameClear() {
        let alert = UIAlertController(title: "성공", message: "2048을 만들었습니다.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "야호!", style: .default)
        let restartAction = UIAlertAction(title: "재도전", style: .default) { _ in
            self.gameLogic.clear()
            self.view.subviews.forEach {
                if $0 is BlockView {
                    $0.removeFromSuperview()
                }
            }
            self.scoreLabel.text = "0"
            self.makeBlockView()
        }
        
        alert.addAction(alertAction)
        alert.addAction(restartAction)
        
        present(alert, animated: true)
    }

    private func makeBlockView() {
        let blocks: [Block] = [.block2, .block4, .block8, .block16, .block32, .block64]
        
        blockView = BlockView(block: blocks.randomElement()!)
        
        view.addSubview(blockView!)
    }
}

extension ViewController {
    private func setUpView() {
        view.backgroundColor = .customGreen1
    }
}
