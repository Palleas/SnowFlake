//
//  AppDelegate.swift
//  SnowFlake
//
//  Created by Romain Pouclet on 2016-07-05.
//  Copyright © 2016 Perfectly-Cooked. All rights reserved.
//

import Cocoa
import CryptoSwift

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let desktop = NSSearchPathForDirectoriesInDomains(.DesktopDirectory, .UserDomainMask, true).first!

        let enumerator = NSFileManager.defaultManager().enumeratorAtPath(desktop)?
            .filter({ $0.pathExtension == "jpg" })
            .map({ $0 as! String })
        for file in enumerator! {
            let fullpath = desktop + "/" + file
            do {
                let data = try NSData(contentsOfFile: fullpath, options: .DataReadingUncached)
                let hash = data.arrayOfBytes().crc32().toHexString()
                print("\(file): \(hash)")
            } catch {
                print("Error = \(error)")
            }

        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

