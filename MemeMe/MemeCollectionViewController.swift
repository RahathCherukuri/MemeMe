//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Rahath cherukuri on 12/12/15.
//  Copyright © 2015 Rahath cherukuri. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var memeCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        potraitOrientation();
    }
    
    func potraitOrientation() {
        let lineSpacing: CGFloat = 1.0
        let interItemSpacing: CGFloat = 1.0
        let navBarHeight = navigationController?.navigationBar.frame.size.height
        let width = (view.frame.size.width - (2 * interItemSpacing)) / 3.0
        let height = (view.frame.size.height - (2 * lineSpacing) - (interItemSpacing) - (navBarHeight)!) / 4.0

        flowLayout.minimumInteritemSpacing = interItemSpacing
        flowLayout.minimumLineSpacing = lineSpacing
        flowLayout.itemSize = CGSizeMake(width, height)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeCollectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Meme.memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = Meme.memes[indexPath.row]
        cell.memeImageView?.image = meme.originalImage
        cell.topText.text = meme.topText
        cell.bottomText.text = meme.bottomText
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.selectedIndex = indexPath.row
        navigationController!.pushViewController(detailController, animated: true)
    }

}
