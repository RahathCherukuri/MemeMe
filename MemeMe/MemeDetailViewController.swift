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
