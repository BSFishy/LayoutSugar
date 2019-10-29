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

/// A struct representing a layout relation
///
/// This is simlply an empty struct to allow us to provide empty operators representing the layout relationships.
/// For example, you can use `>=` or `==` in a function using `LayouRelationer`.
///
/// Example:
/// ```
/// view.layout(subview)
///     .top(20, >=)
/// ```
public struct LayoutRelationerStruct {
    /// An empty struct.
    ///
    /// This can be used as the default value of a function.
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
