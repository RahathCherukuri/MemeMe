//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Rahath cherukuri on 10/13/15.
//  Copyright © 2015 Rahath cherukuri. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var album: UIBarButtonItem!
    @IBOutlet weak var camera: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var fixedSpaceLeft: UIBarButtonItem!
    @IBOutlet weak var fixedSpaceMiddle: UIBarButtonItem!
    @IBOutlet weak var fixedSpaceRight: UIBarButtonItem!
    
    var meme: Meme!
    var selectedIndex: Int!
    
    var imagePicker: UIImagePickerController!
    let textFieldDelegate = MemeTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        topTextField.delegate = textFieldDelegate
        bottomTextField.delegate = textFieldDelegate
        setTextProperties(topTextField)
        setTextProperties(bottomTextField)
        setBarButtonsOnToolBar()
        if (navigationController != nil && selectedIndex != nil) {
            displayMeme()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        tabBarController?.tabBar.hidden = true
        if (!UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            camera.enabled = false
            shareButton.enabled = true
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        tabBarController?.tabBar.hidden = false
    }
    
    func displayMeme() {
        meme = Meme.memes[selectedIndex]
        if (meme != nil) {
            imageView.image = meme.originalImage
            topTextField.text = meme.topText
            bottomTextField.text = meme.bottomText
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Done, target: self, action: "saveTheMeme")
    }

    func saveTheMeme() {
        resignTextFieldsResponders()
        let memedImg = generateMemedImage()
        if ((topTextField.text != nil) && (bottomTextField.text != nil) && (imageView.image != nil)) {
            Meme.memes[selectedIndex].topText = topTextField.text!
            Meme.memes[selectedIndex].bottomText = bottomTextField.text!
            Meme.memes[selectedIndex].originalImage = imageView.image!
            Meme.memes[selectedIndex].memedImage = memedImg
            navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    func resignTextFieldsResponders() {
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
    }
    
    func setBarButtonsOnToolBar() {
        let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.size.width;
        
        fixedSpaceLeft.width = screenWidth/3
        fixedSpaceRight.width = screenWidth/3
        fixedSpaceMiddle.width = 25.0
    }
    
    func setTextProperties(textField: UITextField) {
        setDefaultTextValues(textField)
        let memeTextAttributes = [
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
            NSStrokeWidthAttributeName: -2.0
        ]
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.Center
    }
    
    func setDefaultTextValues(textField: UITextField) {
        if (textField == topTextField) {
            textField.text = "TOP"
        } else if (textField == bottomTextField) {
            textField.text = "BOTTOM"
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBAction func pickImageFromAlbum(sender: UIBarButtonItem) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func launchCamera(sender: UIBarButtonItem) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonAction(sender: UIBarButtonItem) {
        resignTextFieldsResponders()
        let memedImage: UIImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        if (shareButton.enabled) {
                presentViewController(controller, animated: true, completion: nil)
            }
        controller.completionWithItemsHandler = {
            (activity: String?, completed: Bool, items: [AnyObject]?, error: NSError?) -> Void in
            if completed {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
                self.setDefaultTextValues(self.topTextField)
                self.setDefaultTextValues(self.bottomTextField)
            }
        }
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = image
//            cropAnImage(image)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // Code for cropping the image will be used in part 2 of the project.
    func cropAnImage(let image: UIImage) {
        let croprect = CGRectMake(image.size.width/4, image.size.height/4, image.size.width/2, image.size.height/2)
        let imageRef = CGImageCreateWithImageInRect(image.CGImage, croprect)
        let croppedImage = UIImage.init(CGImage: imageRef!)
        imageView.image = croppedImage
    }
    
    func save() {
        let memedImg = generateMemedImage()
        if ((topTextField.text != nil) && (bottomTextField.text != nil) && (imageView.image != nil)) {
            let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImg)
            print("Memes array: ", meme)
        }
    }
    
    func generateMemedImage() -> UIImage
    {
        toolBar.hidden = true
        navigationBar.hidden = true
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolBar.hidden = false
        navigationBar.hidden = false
        
        return memedImage
    }

    // Methods to handle keyBoard events
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if(bottomTextField.isFirstResponder()) {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
            view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
}
