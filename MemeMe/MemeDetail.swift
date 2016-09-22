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
    
    override func viewWillAppear(animated: Bool) {
        self.memeDetailimage?.image = UIImage(data: memes.image!)
    }
}