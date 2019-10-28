//
//  LayoutAttribute.swift
//  LayoutSugar_Example
//
//  Created by Matt Provost on 10/28/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public typealias LayoutAttribute = NSLayoutConstraint.Attribute

public extension Array where Element == LayoutAttribute {
    static var center: [LayoutAttribute] {
        return [.centerX, .centerY]
    }

    static var edges: [LayoutAttribute] {
        return [.top, .left, .bottom, .right]
    }

    static var constantHeight: [LayoutAttribute] {
        return [.height, .notAnAttribute]
    }

    static var constantWidth: [LayoutAttribute] {
        return [.width, .notAnAttribute]
    }
}
