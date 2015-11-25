//
//  memeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Rahath cherukuri on 11/22/15.
//  Copyright © 2015 Rahath cherukuri. All rights reserved.
//

import UIKit

class memeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField (textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        textField.text? = textField.text!.uppercaseString
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let text = textField.text
        if (text == "TOP" || text == "BOTTOM") {
            textField.text = ""
        }
    }
}
