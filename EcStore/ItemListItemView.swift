//
//  ItemListItemView.swift
//  EcStore
//
//  Created by takayama minoru on 2015/05/09.
//  Copyright (c) 2015年 minoru takayama. All rights reserved.
//

import UIKit

class ItemListItemView: UICollectionViewCell {


    @IBOutlet weak var photoImageView: UIImageView!
    var photoInfo : Dictionary<String, String>?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }
}
