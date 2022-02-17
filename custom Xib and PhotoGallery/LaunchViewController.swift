//
//  LaunchViewController.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 17.02.2022.
//

import UIKit

class LaunchViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let confettiImageView = UIImageView.fromGif(frame: view.frame, resourceName: "gif") else { return }
         view.addSubview(confettiImageView)
         confettiImageView.startAnimating()
    }
    


}
