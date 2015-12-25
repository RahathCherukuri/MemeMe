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
    @IBOutlet weak var imageViewTopText: UILabel!
    @IBOutlet weak var imageViewBottomText: UILabel!
    
    var meme : Meme!
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "EDIT", style: UIBarButtonItemStyle.Done, target: self, action: "startOver")
    }
    
    func startOver() {
        if let navigationController = self.navigationController {
            let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
            navigationController.pushViewController(detailController, animated: true)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        imageView!.image = meme.originalImage
        imageViewTopText.text = meme.topText
        imageViewBottomText.text = meme.bottomText
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
}
