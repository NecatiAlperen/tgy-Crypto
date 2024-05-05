//
//  ViewController.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 5.05.2024.
//

import UIKit
import Lottie

final class LaunchScreenVC: UIViewController {

    
    var animationView : LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setAnimation()
    }

    private func setAnimation() {
        animationView = .init(name: "anmt")
        animationView?.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        animationView?.center = view.center
        animationView?.loopMode = .loop
        animationView?.play()
        view.addSubview(animationView!)
        
    }
}

