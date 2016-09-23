//
//  MemeDetail.swift
//  MemeMe
//
//  Created by Christopher Weaver on 7/21/16.
//  Copyright © 2016 Christopher Weaver. All rights reserved.
//

import Foundation
import UIKit

class MemeDetail: UIViewController {
    
    @IBOutlet weak var memeDetailimage: UIImageView!
    
    var memes: SavedMeme!
    
    @IBAction func shareMeme(sender: AnyObject) {
        let av = UIActivityViewController(activityItems: [memes.image!], applicationActivities: nil)
        self.presentViewController(av, animated: true, completion: nil)
        av.completionWithItemsHandler = { (activity, completed, items, error) in
            if completed {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.memeDetailimage?.image = UIImage(data: memes.image!)
    }
    
}