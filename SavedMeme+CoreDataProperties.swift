//
//  SavedMeme+CoreDataProperties.swift
//  MemeMe
//
//  Created by Christopher Weaver on 9/22/16.
//  Copyright © 2016 Christopher Weaver. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SavedMeme {

    @NSManaged var image: NSData?
    @NSManaged var topText: String?
    @NSManaged var bottomText: String?

}
