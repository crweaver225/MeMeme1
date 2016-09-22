//
//  MemeCollection.swift
//  MemeMe
//
//  Created by Christopher Weaver on 7/20/16.
//  Copyright © 2016 Christopher Weaver. All rights reserved.
//

import Foundation
import UIKit
import CoreData




class TableMemeCollector: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var memeTableView: UITableView!
    
    var memes = [SavedMeme]()
    
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        memes.removeAll()
        
        let fr = NSFetchRequest(entityName: "SavedMeme")
        fr.sortDescriptors = [NSSortDescriptor(key: "image", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: (delegate.stack?.context)!, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("error fecthing records")
        }
        
        for images in fetchedResultsController.fetchedObjects! {
            
            let imageMemes = images as! SavedMeme
            
            memes.append(imageMemes)
        }
        
        self.navigationController?.navigationBarHidden = false
        self.memeTableView?.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell")!
        
        let row = memes[indexPath.row]
        
        cell.textLabel?.text = "\(row.topText!) , \(row.bottomText!)"
        cell.imageView?.image = UIImage(data: row.image!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetail") as! MemeDetail
        
        let row = memes[indexPath.row]
        
        detailController.memes = row
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}