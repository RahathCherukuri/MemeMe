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
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "EDIT", style: UIBarButtonItemStyle.Done, target: self, action: "showEditorView")
    }
    
    func showEditorView() {
        if let navigationController = self.navigationController {
            let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
            detailController.selectedIndex = selectedIndex
            navigationController.pushViewController(detailController, animated: true)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hidden = true
        meme = Meme.memes[selectedIndex]
        imageView!.image = meme.memedImage
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.hidden = false
    }
}
