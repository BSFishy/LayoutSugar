//
//  LayoutRelationer.swift
//  LayoutSugar_Example
//
//  Created by Matt Provost on 10/28/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public typealias LayoutRelationer = (LayoutRelationerStruct, LayoutRelationerStruct) -> LayoutRelation

public struct LayoutRelationerStruct {
    static let `nil` = LayoutRelationerStruct()

    public static func equal(left: LayoutRelationerStruct, right: LayoutRelationerStruct) -> LayoutRelation {
        return .equal
    }
}

public func ==(left: LayoutRelationerStruct, right: LayoutRelationerStruct) -> LayoutRelation {
    return .equal
}

public func >=(left: LayoutRelationerStruct, right: LayoutRelationerStruct) -> LayoutRelation {
    return .greaterThanOrEqual
}

public func <=(left: LayoutRelationerStruct, right: LayoutRelationerStruct) -> LayoutRelation {
    return .lessThanOrEqual
}
