//
//  FileTests.swift
//  SnowFlake
//
//  Created by Romain Pouclet on 2016-07-05.
//  Copyright © 2016 Perfectly-Cooked. All rights reserved.
//

import XCTest

class FileTests: XCTestCase {
    struct FakeFile: FileType {
        let path: String
        let hash: String?
    }

    func testFilesWithTheSameHashAreEquals() {
        let f1 = FakeFile(path: "some-pic.jpg", hash: "qwe456128")
        let f2 = FakeFile(path: "some-pic-copy.jpg", hash: "qwe456128")

        XCTAssertTrue(f1 == f2, "Files with the same hash should be equals")
    }
}
