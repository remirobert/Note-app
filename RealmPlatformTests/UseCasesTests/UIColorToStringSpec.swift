//
//  UIcolorToStringSpec.swift
//  RealmPlatformTests
//
//  Created by Remi Robert on 20/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import RealmPlatform

class UIColorToStringSpec: QuickSpec {
    override func spec() {
        super.spec()

        describe("UIColor+String tests") {
            it("should convert a UIColor to string, and convert it back") {
                let color = UIColor.red
                let colorString = color.toHexString()

                expect(UIColor(hexString: colorString)) == color
            }
        }
    }
}
