//
//  FileHandler.swift
//  SnowFlake
//
//  Created by Romain Pouclet on 2016-07-05.
//  Copyright © 2016 Perfectly-Cooked. All rights reserved.
//

import Foundation
import ReactiveCocoa
import CryptoSwift

enum FileHandlerError: ErrorType {
    case NoSuchFile
    case InternalError
}

class FileHandler {
    private let manager = NSFileManager.defaultManager()

    func openFile(path: String) -> SignalProducer<File, FileHandlerError> {
        var isDirectory: ObjCBool = false
        guard manager.fileExistsAtPath(path, isDirectory: &isDirectory) && !isDirectory else {
            return SignalProducer(error: FileHandlerError.NoSuchFile)
        }

        return SignalProducer { sink, disposable in
            // Open file
            do {
                let content = try NSData(contentsOfFile: path, options: .DataReadingUncached)
                let hash = content.arrayOfBytes().crc32().toHexString()

                sink.sendNext(File(path: path, hash: hash))
                sink.sendCompleted()
            } catch {
                sink.sendFailed(.InternalError)
            }
        }
    }
}