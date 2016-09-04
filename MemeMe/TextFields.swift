//
//  textFields.swift
//  MemeMe
//
//  Created by Christopher Weaver on 7/12/16.
//  Copyright © 2016 Christopher Weaver. All rights reserved.
//

import Foundation
import UIKit


class TextFields: NSObject, UITextFieldDelegate {
    
   var textAttributes = [NSStrokeColorAttributeName : UIColor.blackColor(), NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!, NSStrokeWidthAttributeName : -2.0]
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        textField.defaultTextAttributes = textAttributes
        textField.textAlignment = NSTextAlignment.Center
        return true
    }
        
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("return textfield called")
        textField.resignFirstResponder()
        return true
    }
}