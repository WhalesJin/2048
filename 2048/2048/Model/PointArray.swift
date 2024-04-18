//
//  PointArray.swift
//  2048
//
//  Created by Erick, EtialMoon, Whales on 10/6/23.
//

import Foundation

struct PointArray {
    let pointArray1: [CGPoint]
    let pointArray2: [CGPoint]
    let pointArray3: [CGPoint]
    let pointArray4: [CGPoint]
    let pointArray5: [CGPoint]
    
    init(_ width: Double, _ x: Double, _ y: Double) {
        if width >= 380 {
            pointArray1 = [
                CGPoint(x: x - 166, y: y - 156),
                CGPoint(x: x - 166, y: y - 88),
                CGPoint(x: x - 166, y: y - 20),
                CGPoint(x: x - 166, y: y + 48),
                CGPoint(x: x - 166, y: y + 116),
                CGPoint(x: x - 166, y: y + 184),
                CGPoint(x: x - 166, y: y + 252),
            ]
            pointArray2 = [
                CGPoint(x: x - 98, y: y - 156),
                CGPoint(x: x - 98, y: y - 88),
                CGPoint(x: x - 98, y: y - 20),
                CGPoint(x: x - 98, y: y + 48),
                CGPoint(x: x - 98, y: y + 116),
                CGPoint(x: x - 98, y: y + 184),
                CGPoint(x: x - 98, y: y + 252),
            ]
            pointArray3 = [
                CGPoint(x: x - 30, y: y - 156),
                CGPoint(x: x - 30, y: y - 88),
                CGPoint(x: x - 30, y: y - 20),
                CGPoint(x: x - 30, y: y + 48),
                CGPoint(x: x - 30, y: y + 116),
                CGPoint(x: x - 30, y: y + 184),
                CGPoint(x: x - 30, y: y + 252),
            ]
            pointArray4 = [
                CGPoint(x: x + 38, y: y - 156),
                CGPoint(x: x + 38, y: y - 88),
                CGPoint(x: x + 38, y: y - 20),
                CGPoint(x: x + 38, y: y + 48),
                CGPoint(x: x + 38, y: y + 116),
                CGPoint(x: x + 38, y: y + 184),
                CGPoint(x: x + 38, y: y + 252),
            ]
            pointArray5 = [
                CGPoint(x: x + 106, y: y - 156),
                CGPoint(x: x + 106, y: y - 88),
                CGPoint(x: x + 106, y: y - 20),
                CGPoint(x: x + 106, y: y + 48),
                CGPoint(x: x + 106, y: y + 116),
                CGPoint(x: x + 106, y: y + 184),
                CGPoint(x: x + 106, y: y + 252),
            ]
        } else {
            let a = width / 38
            
            pointArray1 = [
                CGPoint(x: x - 16.6 * a, y: y - 15.6 * a),
                CGPoint(x: x - 16.6 * a, y: y - 8.8 * a),
                CGPoint(x: x - 16.6 * a, y: y - 2.0 * a),
                CGPoint(x: x - 16.6 * a, y: y + 4.8 * a),
                CGPoint(x: x - 16.6 * a, y: y + 11.6 * a),
                CGPoint(x: x - 16.6 * a, y: y + 18.4 * a),
                CGPoint(x: x - 16.6 * a, y: y + 25.2 * a),
            ]
            pointArray2 = [
                CGPoint(x: x - 9.8 * a, y: y - 15.6 * a),
                CGPoint(x: x - 9.8 * a, y: y - 8.8 * a),
                CGPoint(x: x - 9.8 * a, y: y - 2.0 * a),
                CGPoint(x: x - 9.8 * a, y: y + 4.8 * a),
                CGPoint(x: x - 9.8 * a, y: y + 11.6 * a),
                CGPoint(x: x - 9.8 * a, y: y + 18.4 * a),
                CGPoint(x: x - 9.8 * a, y: y + 25.2 * a),
            ]
            pointArray3 = [
                CGPoint(x: x - 3 * a, y: y - 15.6 * a),
                CGPoint(x: x - 3 * a, y: y - 8.8 * a),
                CGPoint(x: x - 3 * a, y: y - 2.0 * a),
                CGPoint(x: x - 3 * a, y: y + 4.8 * a),
                CGPoint(x: x - 3 * a, y: y + 11.6 * a),
                CGPoint(x: x - 3 * a, y: y + 18.4 * a),
                CGPoint(x: x - 3 * a, y: y + 25.2 * a),
            ]
            pointArray4 = [
                CGPoint(x: x + 3.8 * a, y: y - 15.6 * a),
                CGPoint(x: x + 3.8 * a, y: y - 8.8 * a),
                CGPoint(x: x + 3.8 * a, y: y - 2.0 * a),
                CGPoint(x: x + 3.8 * a, y: y + 4.8 * a),
                CGPoint(x: x + 3.8 * a, y: y + 11.6 * a),
                CGPoint(x: x + 3.8 * a, y: y + 18.4 * a),
                CGPoint(x: x + 3.8 * a, y: y + 25.2 * a),
            ]
            pointArray5 = [
                CGPoint(x: x + 10.6 * a, y: y - 15.6 * a),
                CGPoint(x: x + 10.6 * a, y: y - 8.8 * a),
                CGPoint(x: x + 10.6 * a, y: y - 2.0 * a),
                CGPoint(x: x + 10.6 * a, y: y + 4.8 * a),
                CGPoint(x: x + 10.6 * a, y: y + 11.6 * a),
                CGPoint(x: x + 10.6 * a, y: y + 18.4 * a),
                CGPoint(x: x + 10.6 * a, y: y + 25.2 * a),
            ]
        }
    }
}
