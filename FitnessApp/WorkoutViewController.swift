//
//  WorkoutViewController.swift
//  FitnessApp
//
//  Created by mac on 7/15/25.
//

import UIKit
import Lottie

class WorkoutViewController: UIViewController {
    
    @IBOutlet weak var ringView: RingView!
    
    var animationView: LottieAnimationView!
    
    var program: Program!
    var currentExerciseIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ringView.delegate = self
        
        ringView.progress = 0.0
        
        
    }
    
    func loadExercise() {
        
        ringView.progress = 0.0
        
        let exercise = program.excercises[currentExerciseIndex]
        
        ringView.startAnimation(time: exercise.duration)
        
        animationView             = LottieAnimationView(name: exercise.animation)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode    = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        
        view.addSubview(animationView)
        
        // ➤ 添加居中与固定大小约束
       NSLayoutConstraint.activate([
           animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
           animationView.widthAnchor  .constraint(equalToConstant: 150),
           animationView.heightAnchor .constraint(equalToConstant: 150)
            ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadExercise()
    }
    
}


extension WorkoutViewController: RingViewDelegate {
    func animationDidEnd() {
        
        if program.excercises.count - 1 == currentExerciseIndex {
            animationView.stop()
            return
        } else {
            currentExerciseIndex += 1
            loadExercise()
        }
        
    }
}
