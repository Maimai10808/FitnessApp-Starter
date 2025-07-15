//
//  WorkoutViewController.swift
//  FitnessApp
//
//  Created by mac on 7/15/25.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    @IBOutlet weak var ringView: RingView!
    
    var program: Program!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ringView.delegate = self
        
        ringView.progress = 0.0
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ringView.progress = 0.0
        ringView.startAnimation(time: 10)
    }
    
}


extension WorkoutViewController: RingViewDelegate {
    func animationDidEnd() {
        print("animation ended. workoutvc is informed")
    }
}
