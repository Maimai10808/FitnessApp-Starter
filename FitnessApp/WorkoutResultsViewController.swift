//
//  WorkoutResultsViewController.swift
//  FitnessApp
//
//  Created by mac on 7/15/25.
//

import UIKit
import Lottie



class WorkoutResultsViewController: UIViewController {

    @IBOutlet weak var resultsView        : UIView!
    @IBOutlet weak var congratulationLabel: UILabel!
    @IBOutlet weak var trophyContainerView: UIView!
    @IBOutlet weak var submitButton       : ShadowButton!
    
    weak var workoutDelegate: WorkoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congratulationLabel.font = UIFont.style(.secondaryText)
        
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.setTitle     ("Submit", for: .normal)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        resultsView.layer.cornerRadius = 6
        
    }
    
    func startAnimation() {
        // 初始化动画视图，动画名称需对应项目中存在的 .json 文件（如 trophy.json）
        let animationView = LottieAnimationView(name: "trophy")
        
        // 设置动画的大小和位置，放在 trophyContainerView 的中间
        animationView.frame  = trophyContainerView.bounds
        animationView.center = CGPoint(x: trophyContainerView.bounds.midX,
                                       y: trophyContainerView.bounds.midY)
        
        // 配置动画属性
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode    = .playOnce
        animationView.animationSpeed = 1.0
        
        // 添加动画视图到trophyContainerView中
        trophyContainerView.addSubview(animationView)
        
        // ✅ 这句非常关键！
            animationView.play { finished in
                print("🏆 trophy animation finished: \(finished)")
            }
        
    }
    
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        dismiss(animated: true) {
            self.workoutDelegate?.dismissWorkout()
        }
    }
    

}
