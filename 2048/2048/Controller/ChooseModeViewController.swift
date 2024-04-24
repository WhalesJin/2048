//
//  ChooseModeViewController.swift
//  2048
//
//  Created by Whales on 4/24/24.
//

import UIKit

class ChooseModeViewController: UIViewController {
    
    @IBOutlet weak var deleteBlockSwitch: UISwitch!
    @IBOutlet weak var upBlockSwitch: UISwitch!
    @IBOutlet weak var downBlockSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tappedGameStartButton(_ sender: UIButton) {
        var eventBlocks = [Block]()
        
        if deleteBlockSwitch.isOn {
            eventBlocks.append(.deleteBlock)
        }
        
        if upBlockSwitch.isOn {
            eventBlocks.append(.upBlock)
        }
        
        if downBlockSwitch.isOn {
            eventBlocks.append(.downBlock)
        }
        
        let gameViewController = ViewController(eventBlocks)
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
}
