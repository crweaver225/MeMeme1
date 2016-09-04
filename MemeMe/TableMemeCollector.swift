//
//  MemeCollection.swift
//  MemeMe
//
//  Created by Christopher Weaver on 7/20/16.
//  Copyright © 2016 Christopher Weaver. All rights reserved.
//

import Foundation
import UIKit





class TableMemeCollector: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memes: [Meme]!
    
    @IBOutlet weak var memeTableView: UITableView!

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if let memes = memes {
        return memes.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell")!
        
        let row = memes[indexPath.row]
        
        cell.textLabel?.text = "\(row.text1) , \(row.text2) "
        cell.imageView?.image = row.finalImage
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetail") as! MemeDetail
        
        let row = memes[indexPath.row]
        
        detailController.memes = row
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        self.navigationController?.navigationBarHidden = false
        self.memeTableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}