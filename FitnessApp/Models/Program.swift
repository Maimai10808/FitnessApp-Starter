//
//  Program.swift
//  FitnessApp
//
//  Created by mac on 7/15/25.
//

import Foundation

struct Program {
    
    let title   : String
    let image   : String
    let calories: Int
    let duration: Int
    
    let excercises: [Excercise]
}

extension Program {
    static let beginnerMockProgram     = Program(title: "Beginner",
                                             image: "man-lunge",
                                             calories: 100,
                                             duration: 1,
                                             excercises: [Excercise.mockJumpingJackExcercise,
                                                          Excercise.mockPushUpsExcercise])
    // 1 mins
    static let intermediateMockProgram = Program(title: "intermediate",
                                             image: "lady-stretch",
                                             calories: 200,
                                             duration: 2,
                                             excercises: [Excercise.mockJumpingJackExcercise,
                                                          Excercise.mockPushUpsExcercise,
                                                          Excercise.mockJumpingJackExcercise,
                                                          Excercise.mockPushUpsExcercise])
    static let advancedMockProgram     = Program(title: "Advanced",
                                             image: "lady-jump",
                                             calories: 300,
                                             duration: 3,
                                             excercises: [Excercise.mockJumpingJackExcercise,
                                                          Excercise.mockPushUpsExcercise,
                                                          Excercise.mockJumpingJackExcercise,
                                                          Excercise.mockPushUpsExcercise,
                                                          Excercise.mockJumpingJackExcercise,
                                                          Excercise.mockPushUpsExcercise])
}
