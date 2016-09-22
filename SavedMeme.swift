//
//  SavedMeme.swift
//  MemeMe
//
//  Created by Christopher Weaver on 9/22/16.
//  Copyright © 2016 Christopher Weaver. All rights reserved.
//

import Foundation
import CoreData


class SavedMeme: NSManagedObject {

    convenience init(image: NSData, topText: String, bottomText: String, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entityForName("SavedMeme", inManagedObjectContext: context){
            self.init(entity: ent, insertIntoManagedObjectContext: context)
            self.image = image
            self.topText = topText
            self.bottomText = bottomText
        } else {
            fatalError("Unable to find Entity Name!")
        }
    }


}
