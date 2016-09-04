//
//  CollectionMemeCollector.swift
//  MemeMe
//
//  Created by Christopher Weaver on 7/21/16.
//  Copyright © 2016 Christopher Weaver. All rights reserved.
//

import Foundation
import UIKit


class CollectionMemeColector: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var ControlFlow: UICollectionViewFlowLayout!
    
    @IBOutlet weak var MemeCollectorView: UICollectionView!
    var memes: [Meme]!
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let memes = memes {
            return memes.count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionMeme", forIndexPath: indexPath) as! CollectionViewCell
        
        let row = self.memes[indexPath.row]
        
        cell.collectionImage?.image = row.finalImage
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
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
        
        self.MemeCollectorView?.reloadData()
        
        let dimension1 = ((self.view.frame.size.width) - 25) / 3
        let dimension2 = (self.view.frame.size.height) / 4
        
        ControlFlow.minimumInteritemSpacing = 1.0
        ControlFlow.minimumLineSpacing = 5.0
        ControlFlow.itemSize = CGSizeMake(dimension1, dimension2)
        ControlFlow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
    }
}