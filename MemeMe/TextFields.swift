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
    
   var textAttributes = [NSStrokeColorAttributeName : UIColor.black, NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!, NSStrokeWidthAttributeName : -2.0] as [String : Any]
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.defaultTextAttributes = textAttributes
        textField.textAlignment = NSTextAlignment.center
        return true
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return textfield called")
        textField.resignFirstResponder()
        return true
    }
}
