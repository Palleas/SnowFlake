//
//  DropzoneViewModel.swift
//  SnowFlake
//
//  Created by Romain Pouclet on 2016-07-07.
//  Copyright © 2016 Perfectly-Cooked. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

struct DropzoneViewModel {
    let files: MutableProperty<[String]>
    let browse: Action<Void, [String], NoError>

    init() {
        let filesProperty = MutableProperty<[String]>([])

        browse = Action { _ in
            return SignalProducer { sink, disposable in
                let panel = NSOpenPanel()
                panel.canChooseDirectories = false
                panel.allowsMultipleSelection = true
                panel.beginWithCompletionHandler { result in
                    let paths = panel.URLs.filter { $0.path != nil }.map { $0.path! }
                    filesProperty.value = paths
                }

            }
        }

        self.files = filesProperty
    }
}
