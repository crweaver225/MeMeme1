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
    
    @IBAction func blueColorPicked(_ sender: AnyObject) {
        changeTextColor(UIColor.blue)
        toolbar1.isHidden = false
    }
    
    @IBAction func pinkColorPicked(_ sender: AnyObject) {
        changeTextColor(UIColor.magenta)
        toolbar1.isHidden = false
    }
    
    @IBAction func greenColorPicked(_ sender: AnyObject) {
        changeTextColor(UIColor.green)
        toolbar1.isHidden = false
    }
    
    @IBAction func redColorPicked(_ sender: AnyObject) {
        changeTextColor(UIColor.red)
        toolbar1.isHidden = false
    }
    
    @IBAction func whiteColorPicked(_ sender: AnyObject) {
        changeTextColor(UIColor.white)
        toolbar1.isHidden = false
    }
    
    @IBAction func fontColor(_ sender: AnyObject) {
        toolbar1.isHidden = true
        
        colorButtonVisible(false)
        
        textFieldDel.textAttributes = [NSStrokeColorAttributeName : UIColor.black, NSForegroundColorAttributeName : UIColor.blue, NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!, NSStrokeWidthAttributeName : -2.0]
    }
    
    @IBAction func photoButton(_ sender: AnyObject) {
        picker(UIImagePickerControllerSourceType.photoLibrary)
    }
    
    @IBAction func cameraButton(_ sender: AnyObject) {
        picker(UIImagePickerControllerSourceType.camera)
    }
    
    @IBAction func cancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButton(_ sender: AnyObject) {
        let finalMeme = generatememedImage()
        
        let finalMemeFormat = [finalMeme]
        
        let AV = UIActivityViewController(activityItems: finalMemeFormat, applicationActivities: nil)
        self.present(AV, animated: true, completion: nil)
        AV.completionWithItemsHandler = { (activity, completed, items, error) in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    let textFieldDel = TextFields()
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareButton.isEnabled = false
        
        self.textField1.delegate = textFieldDel
        self.textField2.delegate = textFieldDel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        
        self.tabBarController?.tabBar.isHidden = true
        
        colorButtonVisible(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotification()
    }

    
    func changeTextColor(_ color: UIColor) {
        textFieldDel.textAttributes = [NSStrokeColorAttributeName : UIColor.black, NSForegroundColorAttributeName : color, NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!, NSStrokeWidthAttributeName : -2.0]
        colorButtonVisible(true)
        textFieldDel.textFieldShouldBeginEditing(textField1)
        textFieldDel.textFieldShouldBeginEditing(textField2)
    }
    
    
    func picker(_ pickerVar: UIImagePickerControllerSourceType) {
        let finalPicker = UIImagePickerController()
        finalPicker.delegate = self
        finalPicker.sourceType = pickerVar
        
        self.present(finalPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            finalImage.image = image
            shareButton.isEnabled = true
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(CreateMeme.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateMeme.keyboardWillDisappear(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func unsubscribeFromKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if textField2.isFirstResponder && view.frame.origin.y == 0  {
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillDisappear(_ notification: Notification) {
        if textField2.isFirstResponder {
        view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo
        
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    func generatememedImage() -> UIImage {
        self.navigationController?.setToolbarHidden(navigationController?.isNavigationBarHidden == true, animated: true)
        
        toolbar1.isHidden = true
        toolbar2.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        toolbar1.isHidden = false
        toolbar2.isHidden = false
        
        return memedImage
    }
    
    func save() {
        
        let imageData: Data = UIImagePNGRepresentation(generatememedImage())!
        
        let savedMeme = SavedMeme(image: imageData, topText: self.textField1.text!, bottomText: textField2.text!, context: (self.delegate.stack?.context)!)
        
        self.delegate.stack?.save()
    }
    
    func colorButtonVisible (_ answer:Bool) {
        blueColorButton.isHidden = answer
        redColorButton.isHidden = answer
        greenColorButton.isHidden = answer
        pinkColorButton.isHidden = answer
        whiteColorButton.isHidden = answer
    }
    
}

