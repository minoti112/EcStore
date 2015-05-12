//
//  CollectionIitemListViewController.swift
//  EcStore
//
//  Created by takayama minoru on 2015/05/12.
//  Copyright (c) 2015年 minoru takayama. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

let reuseIdentifier = "Cell"

class CollectionIitemListViewController: UICollectionViewController {

    var items: JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        createCollectionView()
    }

    private func createCollectionView() {
        SVProgressHUD.show()
        Alamofire.request(Router.Items)
            .validate(statusCode: 200..<400)
            .responseJSON {(request, response, responseData, error) in
                
                if let data: AnyObject = responseData {
                    SVProgressHUD.dismiss()
                    self.items = SwiftyJSON.JSON(data)
                    self.collectionView!.reloadData()
                }
                if let resError = error {
                    SVProgressHUD.dismiss()
                    println("Connection failed3.\(resError.localizedDescription)")
                    return
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 10
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 10
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
    
        println(indexPath)
        println(items)
//        var photoUrl = items["111"].string!
        // UIImageView+AFNetworkingの画像を非同期で読んでくれるメソッドを実行
//        cell.photoImageView.sd_setImageWithURL(NSURL(string: photoUrl))
        // Configure the cell
    
        return cell
    }

    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        var itemSize = CGSizeMake(320, 150)
        return itemSize
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
