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
        
        return imageView
    }()
    
    private let bestScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Best Score :"
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 40)
        
        return label
    }()
    
    private var blockView: BlockView?
    private var gameBoardView = GameBoardView(UIScreen.main.bounds)
    private var gameLogic = GameLogic(UIScreen.main.bounds.width, UIScreen.main.bounds.midX, UIScreen.main.bounds.midY)
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var eventBlocks = [Block]()
    
    init(_ eventBlocks: [Block]) {
        self.eventBlocks = eventBlocks
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private func makeBlockView() {
        let blocks: [Block] = [.block2, .block4, .block8, .block16, .block32, .block64]
        
        blockView = BlockView(block: (blocks + blocks + eventBlocks).randomElement()!)
        
        view.addSubview(blockView!)
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
            let tappedPointY = tapGestureRecognizer.location(in: view).y
            
            guard gameBoardView.frame.minX...gameBoardView.frame.maxX ~= tappedPointX,
                  gameBoardView.frame.minY...gameBoardView.frame.maxY ~= tappedPointY
            else {
                return
            }
            
            let (point, changedState) = gameLogic.validatePosition(tappedX: tappedPointX, block: blockView!)
            
            if blockView?.blockState == .deleteBlock {
                blockView?.removeFromSuperview()
            }
            
            if blockView?.blockState == .downBlock || blockView?.blockState == .upBlock {
                blockView?.blockState = changedState
            }
            
            if point == CGPoint(x: 0, y: 0) {
                blockView?.removeFromSuperview()
            } else {
                blockView?.frame.origin = point
            }
            
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
        let alert = UIAlertController(title: "아쉽네요..", message: "게임에서 졌습니다.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "게임보드 보기", style: .default)
        let changeModeAction = UIAlertAction(title: "블록 옵션 바꾸기", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
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
        alert.addAction(changeModeAction)
        alert.addAction(restartAction)
        
        present(alert, animated: true)
    }

    private func gameClear() {
        let alert = UIAlertController(title: "야호!", message: "2048을 만들었습니다.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "게임보드 보기", style: .default)
        let changeModeAction = UIAlertAction(title: "블록 옵션 바꾸기", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
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
        alert.addAction(changeModeAction)
        alert.addAction(restartAction)
        
        present(alert, animated: true)
    }
}

extension ViewController {
    private func setUpView() {
        view.backgroundColor = .customGreen1
        
        if view.bounds.width >= 380 {
            puzzleImage.frame = CGRect(x: view.bounds.midX - 166,
                                       y: view.bounds.midY - 316,
                                       width: 60,
                                       height: 60)
            bestScoreLabel.frame = CGRect(x: view.bounds.midX - 96,
                                          y: view.bounds.midY - 316,
                                          width: 140,
                                          height: 60)
            scoreLabel.frame = CGRect(x: view.bounds.midX + 54,
                                      y: view.bounds.midY - 316,
                                      width: 110,
                                      height: 60)
        } else {
            let a = view.bounds.width / 38
            
            puzzleImage.frame = CGRect(x: view.bounds.midX - 16.6 * a,
                                       y: view.bounds.midY - 29.6 * a,
                                       width: 6 * a,
                                       height: 6 * a)
            bestScoreLabel.frame = CGRect(x: view.bounds.midX - 9.6 * a,
                                          y: view.bounds.midY - 29.6 * a,
                                          width: 14 * a,
                                          height: 6 * a)
            scoreLabel.frame = CGRect(x: view.bounds.midX + 5.4 * a,
                                      y: view.bounds.midY - 29.6 * a,
                                      width: 11 * a,
                                      height: 6 * a)
        }
    }
}
