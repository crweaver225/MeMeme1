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
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        
        memes.removeAll()
        
        let fr = NSFetchRequest<SavedMeme>(entityName: "SavedMeme")
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
        
        self.navigationController?.isNavigationBarHidden = false
        self.memeTableView?.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell")!
        
        let row = memes[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = "\(row.topText!) , \(row.bottomText!)"
        cell.imageView?.image = UIImage(data: row.image! as Data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetail") as! MemeDetail
        
        let row = memes[(indexPath as NSIndexPath).row]
        
        detailController.memes = row
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
