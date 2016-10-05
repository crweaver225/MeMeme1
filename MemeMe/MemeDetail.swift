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
    
    @IBAction func shareMeme(_ sender: AnyObject) {
        let av = UIActivityViewController(activityItems: [memes.image!], applicationActivities: nil)
        self.present(av, animated: true, completion: nil)
        av.completionWithItemsHandler = { (activity, completed, items, error) in
            if completed {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    var memes: SavedMeme!
    
    override func viewWillAppear(_ animated: Bool) {
        self.memeDetailimage?.image = UIImage(data: memes.image! as Data)
    }
    
}
