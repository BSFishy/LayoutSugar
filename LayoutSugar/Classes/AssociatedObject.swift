//
//  AssociatedObject.swift
//  LayoutSugar_Example
//
//  Created by Matt Provost on 10/28/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import ObjectiveC

public struct AssociatedObject {
    public static func get<T: Any>(base: Any, key: UnsafePointer<UInt8>, initializer: () -> T) -> T {
        if let v = objc_getAssociatedObject(base, key) as? T {
            return v
        }

        let v = initializer()
        objc_setAssociatedObject(base, key, v, .OBJC_ASSOCIATION_RETAIN)
        return v
    }

    public static func set<T: Any>(base: Any, key: UnsafePointer<UInt8>, value: T) {
        objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_RETAIN)
    }
}
