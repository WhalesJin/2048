//
//  GameBoardView.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 10/6/23.
//

import UIKit

class GameBoardView: UIView {
    private var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let emptyView1 = UIView()
    private let emptyView2 = UIView()
    private let emptyView3 = UIView()
    private let emptyView4 = UIView()
    private let emptyView5 = UIView()
    
    init(_ superView: CGRect) {
        let width = superView.width
        
        if width >= 380 {
            super.init(frame: CGRect(x: superView.midX - 170,
                                     y: superView.midY - 156,
                                     width: 340,
                                     height: 468))
        } else {
            let a = width / 38
            
            super.init(frame: CGRect(x: superView.midX - 17 * a,
                                     y: superView.midY - 15.6 * a,
                                     width: 34 * a,
                                     height: 46.8 * a))
        }
        
        self.addSubview(horizontalStackView)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
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
    
    private func coloredView() {
        emptyView1.backgroundColor = .customGreen3
        emptyView2.backgroundColor = .customGreen2
        emptyView3.backgroundColor = .customGreen3
        emptyView4.backgroundColor = .customGreen2
        emptyView5.backgroundColor = .customGreen3
    }
}
