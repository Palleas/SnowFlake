//
//  DropzoneViewController.swift
//  SnowFlake
//
//  Created by Romain Pouclet on 2016-07-06.
//  Copyright © 2016 Perfectly-Cooked. All rights reserved.
//

import Cocoa


final class DropzoneView: NSView {
    private let dashedBorder = CAShapeLayer()

    @IBOutlet var message: NSTextField! {
        didSet {
            message.font = .systemFontOfSize(96)
        }
    }

}

class DropzoneViewController: NSViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        print("Lol wat?")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        (view as! DropzoneView).message.stringValue = "❄️"
    }
    
}
