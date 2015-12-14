//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Rahath cherukuri on 12/11/15.
//  Copyright © 2015 Rahath cherukuri. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var memeTableView: UITableView!
    
    var memes: [Meme]! {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MemeTableViewCell = tableView.dequeueReusableCellWithIdentifier("memeCell") as! MemeTableViewCell
        let meme = memes[indexPath.row]
        cell.topLabel.text = meme.topText
        cell.bottomLabel.text = meme.bottomText
        cell.memeImageView.image = meme.memedImage
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
