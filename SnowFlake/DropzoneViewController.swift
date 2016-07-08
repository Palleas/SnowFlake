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


final class PhotoView: NSCollectionViewItem {


}

final class DropzoneView: NSView {
    private let dashedBorder = CAShapeLayer()
    @IBOutlet var browseButton: NSButton!

    @IBOutlet var selectionCount: NSTextField!

    @IBOutlet var gridView: NSCollectionView! {
        didSet {
            gridView.registerNib(NSNib(nibNamed: "PhotoCollectionViewItem", bundle: NSBundle.mainBundle()), forItemWithIdentifier: "Photo")
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

        self.browseAction = CocoaAction(viewModel.browse) { _ in () }
        dropzone.browseButton.target = browseAction
        dropzone.browseButton.action = CocoaAction.selector

        viewModel.files.producer.map({ $0.count }).observeOn(UIScheduler()).startWithNext { count in
            dropzone.selectionCount.stringValue = "\(count) files ready to be processed"
            dropzone.gridView.reloadData()
        }

//        viewModel.files.producer.flatMap(.Latest) { paths -> SignalProducer<String, NoError> in
//            return SignalProducer(values: paths)
//        }
//        .promoteErrors(FileHandlerError)
//        .flatMap(.Latest) { path -> SignalProducer<File, FileHandlerError> in
//            return self.handler.openFile(path)
//        }
//        .startWithNext { file in
//            print("\(file.path) (Hash: \(file.hash!))")
//        }
    }

}

extension DropzoneViewController: NSCollectionViewDataSource {

    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Count = \(viewModel.files.value.count)")
        return viewModel.files.value.count
    }

    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItemWithIdentifier("Photo", forIndexPath: indexPath) as! PhotoCollectionViewItem

        item.update(with: viewModel.files.value[indexPath.item])

        return item
    }
}
