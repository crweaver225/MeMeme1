//
//  ViewController.swift
//  MemeMe
//
//  Created by Christopher Weaver on 7/12/16.
//  Copyright © 2016 Christopher Weaver. All rights reserved.
//

import UIKit

struct Meme {
    var text1: String
    var text2: String
    var image1: UIImage
    var finalImage: UIImage
}

class CreateMeme: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var photoButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var finalImage: UIImageView!
    @IBOutlet weak var toolbar1: UIToolbar!
    @IBOutlet weak var toolbar2: UIToolbar!
    @IBOutlet weak var blueColorButton: UIButton!
    @IBOutlet weak var greenColorButton: UIButton!
    @IBOutlet weak var pinkColorButton: UIButton!
    @IBOutlet weak var redColorButton: UIButton!
    @IBOutlet weak var whiteColorButton: UIButton!
    
    @IBAction func blueColorPicked(sender: AnyObject) {
        changeTextColor(UIColor.blueColor())
        toolbar1.hidden = false
    }
    
    @IBAction func pinkColorPicked(sender: AnyObject) {
        changeTextColor(UIColor.magentaColor())
        toolbar1.hidden = false
    }
    
    @IBAction func greenColorPicked(sender: AnyObject) {
        changeTextColor(UIColor.greenColor())
        toolbar1.hidden = false
    }
    
    @IBAction func redColorPicked(sender: AnyObject) {
        changeTextColor(UIColor.redColor())
        toolbar1.hidden = false
    }
    
    @IBAction func whiteColorPicked(sender: AnyObject) {
        changeTextColor(UIColor.whiteColor())
        toolbar1.hidden = false
    }
    
    @IBAction func fontColor(sender: AnyObject) {
        toolbar1.hidden = true
        
        colorButtonVisible(false)
        
        textFieldDel.textAttributes = [NSStrokeColorAttributeName : UIColor.blackColor(), NSForegroundColorAttributeName : UIColor.blueColor(), NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!, NSStrokeWidthAttributeName : -2.0]
    }
    
    @IBAction func photoButton(sender: AnyObject) {
        picker(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    @IBAction func cameraButton(sender: AnyObject) {
        picker(UIImagePickerControllerSourceType.Camera)
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareButton(sender: AnyObject) {
        let finalMeme = generatememedImage()
        
        let finalMemeFormat = [finalMeme]
        
        let AV = UIActivityViewController(activityItems: finalMemeFormat, applicationActivities: nil)
        self.presentViewController(AV, animated: true, completion: nil)
        AV.completionWithItemsHandler = { activity, completed, items, error in
            if completed {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    let textFieldDel = TextFields()
    
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareButton.enabled = false
        
        self.textField1.delegate = textFieldDel
        self.textField2.delegate = textFieldDel
    }
    
    override func viewWillAppear(animated: Bool) {
        subscribeToKeyboardNotifications()
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        self.tabBarController?.tabBar.hidden = true
        
        colorButtonVisible(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotification()
    }

    
    func changeTextColor(color: UIColor) {
        textFieldDel.textAttributes = [NSStrokeColorAttributeName : UIColor.blackColor(), NSForegroundColorAttributeName : color, NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!, NSStrokeWidthAttributeName : -2.0]
        colorButtonVisible(true)
        textFieldDel.textFieldShouldBeginEditing(textField1)
        textFieldDel.textFieldShouldBeginEditing(textField2)
    }
    
    
    func picker(pickerVar: UIImagePickerControllerSourceType) {
        let finalPicker = UIImagePickerController()
        finalPicker.delegate = self
        finalPicker.sourceType = pickerVar
        
        self.presentViewController(finalPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            finalImage.image = image
            shareButton.enabled = true
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if textField2.isFirstResponder() && view.frame.origin.y == 0  {
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillDisappear(notification: NSNotification) {
        if textField2.isFirstResponder() {
        view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.CGRectValue().height
    }
    
    func generatememedImage() -> UIImage {
        self.navigationController?.setToolbarHidden(navigationController?.navigationBarHidden == true, animated: true)
        
        toolbar1.hidden = true
        toolbar2.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        toolbar1.hidden = false
        toolbar2.hidden = false
        
        return memedImage
    }
    
    func save() {
        
        let imageData: NSData = UIImagePNGRepresentation(generatememedImage())!
        
        let savedMeme = SavedMeme(image: imageData, topText: self.textField1.text!, bottomText: textField2.text!, context: (self.delegate.stack?.context)!)
        
        self.delegate.stack?.save()
    }
    
    func colorButtonVisible (answer:Bool) {
        blueColorButton.hidden = answer
        redColorButton.hidden = answer
        greenColorButton.hidden = answer
        pinkColorButton.hidden = answer
        whiteColorButton.hidden = answer
    }
    
}

