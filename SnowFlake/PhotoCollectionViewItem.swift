//
//  PhotoCollectionViewItem.swift
//  SnowFlake
//
//  Created by Romain Pouclet on 2016-07-07.
//  Copyright © 2016 Perfectly-Cooked. All rights reserved.
//

import Cocoa

class PhotoCollectionViewItem: NSCollectionViewItem {

    @IBOutlet weak var pictureView: NSImageView!

    func update(with file: String) {
        pictureView.image = NSImage(contentsOfFile: file)
    }

}

//extension PhotoCollectionViewItem: NScollectionup
