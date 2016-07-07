//
//  AppDelegate.swift
//  SnowFlake
//
//  Created by Romain Pouclet on 2016-07-05.
//  Copyright © 2016 Perfectly-Cooked. All rights reserved.
//

import Cocoa
import CryptoSwift
import ReactiveCocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
//    private let dropzoneViewController = DropzoneViewController()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
//        window.contentView = dropzoneViewController.view

        let desktop = NSSearchPathForDirectoriesInDomains(.DesktopDirectory, .UserDomainMask, true).first!

        let handler = FileHandler()

        let files = NSFileManager.defaultManager().enumeratorAtURL(NSURL(fileURLWithPath: desktop), includingPropertiesForKeys: nil, options: .SkipsHiddenFiles, errorHandler: nil)!
            .filter({ $0.pathExtension == "jpg" })
            .map({ ($0 as! NSURL).path! })

        let _ = SignalProducer<String, FileHandlerError>(values: files)
            .flatMap(.Latest) { path -> SignalProducer<File, FileHandlerError> in
                print("Path = \(path)")
                return handler.openFile(path)
            }
            .on(failed: { print("Got error: \($0)")})
            .startWithNext { file in
                print("File \(file.path) (\(file.hash!))")
            }

    }

}

