//
//  GameBoardView.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 10/6/23.
//

import UIKit

class GameBoardView: UIView {
    var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let emptyView1 = UIView()
    let emptyView2 = UIView()
    let emptyView3 = UIView()
    let emptyView4 = UIView()
    let emptyView5 = UIView()
    
    init() {
        super.init(frame: CGRect(x: 23, y: 250, width: 340, height: 480))
        
        self.addSubview(horizontalStackView)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        horizontalStackView.addArrangedSubview(emptyView1)
        horizontalStackView.addArrangedSubview(emptyView2)
        horizontalStackView.addArrangedSubview(emptyView3)
        horizontalStackView.addArrangedSubview(emptyView4)
        horizontalStackView.addArrangedSubview(emptyView5)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        coloredView()
    }
    
    func coloredView() {
        emptyView1.backgroundColor = .lightGray
        emptyView2.backgroundColor = .gray
        emptyView3.backgroundColor = .lightGray
        emptyView4.backgroundColor = .gray
        emptyView5.backgroundColor = .lightGray
    }
}
