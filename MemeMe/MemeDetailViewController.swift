//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Rahath cherukuri on 12/17/15.
//  Copyright © 2015 Rahath cherukuri. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var meme : Meme!
    
//    override func viewDidLoad() {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "EDIT", style: UIBarButtonItemStyle., target: self, action: "startOver")
//    }
    
//    func startOver() {
//        if let navigationController = self.navigationController {
//            navigationController.popToRootViewControllerAnimated(true)
//        }
//    }
//    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        
        self.imageView!.image = meme.memedImage
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }

}
