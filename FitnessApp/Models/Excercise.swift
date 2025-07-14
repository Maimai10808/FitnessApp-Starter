//
//  Excercise.swift
//  FitnessApp
//
//  Created by mac on 7/15/25.
//

import Foundation

struct Excercise {
    
    let name     : String
    let animation: String
    let duration : Int
    
}

extension Excercise {
    static let mockJumpingJackExcercise = Excercise(name: "Jumping Jack", animation: "jumpingjack", duration: 10)
    static let mockPushUpsExcercise     = Excercise(name: "Push Ups"    , animation: "pushups"    , duration: 15)
    
    // 10s 15s
}
