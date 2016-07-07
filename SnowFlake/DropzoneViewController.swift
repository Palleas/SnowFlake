//
//  DropzoneViewController.swift
//  SnowFlake
//
//  Created by Romain Pouclet on 2016-07-06.
//  Copyright © 2016 Perfectly-Cooked. All rights reserved.
//

import Cocoa
import ReactiveCocoa
import Result


final class DropzoneView: NSView {
    private let dashedBorder = CAShapeLayer()
    @IBOutlet var browseButton: NSButton!

    @IBOutlet var selectionCount: NSTextField!

    @IBOutlet var message: NSTextField! {
        didSet {
            message.font = .systemFontOfSize(96)
        }
    }
}

class DropzoneViewController: NSViewController {
    let viewModel = DropzoneViewModel()
    let handler = FileHandler()

    private var browseAction: CocoaAction?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let dropzone = view as! DropzoneView
        dropzone.message.stringValue = "❄️"

        self.browseAction = CocoaAction(viewModel.browse) { _ in () }
        dropzone.browseButton.target = browseAction
        dropzone.browseButton.action = CocoaAction.selector

        viewModel.files.producer.map { $0.count }.startWithNext { count in
            dropzone.selectionCount.stringValue = "(\(count) files selected)"
        }

        viewModel.files.producer.flatMap(.Latest) { paths -> SignalProducer<String, NoError> in
            return SignalProducer(values: paths)
        }
        .promoteErrors(FileHandlerError)
        .flatMap(.Latest) { path -> SignalProducer<File, FileHandlerError> in
            return self.handler.openFile(path)
        }
        .startWithNext { file in
            print("\(file.path) (Hash: \(file.hash!))")
        }
    }

//    func browse() {
//        let panel = NSOpenPanel()
//        panel.canChooseDirectories = false
//        panel.allowsMultipleSelection = true
//        panel.beginWithCompletionHandler { result in
//            self.viewModel.files.value.appendContentsOf(panel.URLs.map { $0.path! })
//        }
//    }
}
