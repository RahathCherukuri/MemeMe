//
//  meme.swift
//  MemeMe
//
//  Created by Rahath cherukuri on 11/22/15.
//  Copyright © 2015 Rahath cherukuri. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    static var memes: [Meme] = []
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
    
    init(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
        Meme.memes.append(self)
    }
}