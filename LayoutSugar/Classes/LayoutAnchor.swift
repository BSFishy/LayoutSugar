//
//  LayoutAnchor.swift
//  LayoutSugar_Example
//
//  Created by Matt Provost on 10/28/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

// MARK: Layout anchor struct

/// A layout anchor.
///
/// This is an anchor that a layout can constrain to.
public struct LayoutAnchor {
    /// The constrainable that this anchor constrains to
    public private(set) weak var constraintable: Constraintable?

    /// The attributes that apply to this anchor
    public let attributes: [LayoutAttribute]

    public init(constraintable: Constraintable?, attributes: [LayoutAttribute] = []) {
        self.constraintable = constraintable
        self.attributes = attributes
    }
}

// MARK: Layout anchorable

/// An object that can be anchored to
public protocol LayoutAnchorable {
    /// The constraintable object that this constrains to
    var constraintable: Constraintable? { get }
}

extension UIView: LayoutAnchorable {
    public var constraintable: Constraintable? {
        self
    }
}

extension Layout: LayoutAnchorable { }
extension LayoutAnchor: LayoutAnchorable { }

// MARK: Layout anchorable anchor functions
public extension LayoutAnchorable {
    /// Create an anchor given the attribute.
    ///
    /// This will create an anchor from this object's `constraintable` object using the given attribute.
    /// - Parameter attribute: The attribute to create the anchor for
    func anchor(_ attribute: LayoutAttribute) -> LayoutAnchor {
        return anchor([attribute])
    }

    /// Create an anchor given the attributes.
    ///
    /// This will create an anchor from this object's `constraintable` object using the given attributes.
    /// - Parameter attributes: The attributes to create the anchor for
    func anchor(_ attributes: [LayoutAttribute]) -> LayoutAnchor {
        return LayoutAnchor(constraintable: constraintable, attributes: attributes)
    }
}

// MARK: Layout anchorable functions
public extension LayoutAnchorable {
    /// Create an anchor to the top of this object
    var top: LayoutAnchor {
        return anchor(.top)
    }

    /// Create an anchor to the bottom of this object
    var bottom: LayoutAnchor {
        return anchor(.bottom)
    }

    /// Create an anchor to the left side of this object
    var left: LayoutAnchor {
        return anchor(.left)
    }

    /// Create an anchor to the right side of this object
    var right: LayoutAnchor {
        return anchor(.right)
    }

    /// Create an anchor to the leading side of this object
    var leading: LayoutAnchor {
        return anchor(.leading)
    }

    /// Create an anchor to the trailing side of this object
    var trailing: LayoutAnchor {
        return anchor(.trailing)
    }

    /// Create an anchor to the width of this object
    var width: LayoutAnchor {
        return anchor(.width)
    }

    /// Create an anchor to the height of this object
    var height: LayoutAnchor {
        return anchor(.height)
    }

    /// Create an anchor to the center of the x-axis of this object
    var centerX: LayoutAnchor {
        return anchor(.centerX)
    }

    /// Create an anchor to the center of the y-axis of this object
    var centerY: LayoutAnchor {
        return anchor(.centerY)
    }

    /// Create an anchor to the center of this object
    var center: LayoutAnchor {
        return anchor(.center)
    }

    /// Create an anchor to the edges of this object
    var edges: LayoutAnchor {
        return anchor(.edges)
    }

    /// Create an anchor for a constant height of this object
    var constantHeight: LayoutAnchor {
        return anchor(.constantHeight)
    }

    /// Create an anchor for a constant width of this object
    var constantWidth: LayoutAnchor {
        return anchor(.constantWidth)
    }
}
