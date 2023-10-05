//
//  Array+.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 2023/10/06.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
