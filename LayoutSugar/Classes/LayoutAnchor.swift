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
public struct LayoutAnchor {
    public private(set) weak var constraintable: Constraintable?

    public let attributes: [LayoutAttribute]

    public init(constraintable: Constraintable?, attributes: [LayoutAttribute] = []) {
        self.constraintable = constraintable
        self.attributes = attributes
    }
}

// MARK: Layout anchorable
public protocol LayoutAnchorable {
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
    func anchor(_ attribute: LayoutAttribute) -> LayoutAnchor {
        return anchor([attribute])
    }

    func anchor(_ attributes: [LayoutAttribute]) -> LayoutAnchor {
        return LayoutAnchor(constraintable: constraintable, attributes: attributes)
    }
}

// MARK: Layout anchorable functions
public extension LayoutAnchorable {
    var top: LayoutAnchor {
        return anchor(.top)
    }

    var bottom: LayoutAnchor {
        return anchor(.bottom)
    }

    var left: LayoutAnchor {
        return anchor(.left)
    }

    var right: LayoutAnchor {
        return anchor(.right)
    }

    var leading: LayoutAnchor {
        return anchor(.leading)
    }

    var trailing: LayoutAnchor {
        return anchor(.trailing)
    }

    var width: LayoutAnchor {
        return anchor(.width)
    }

    var height: LayoutAnchor {
        return anchor(.height)
    }

    var centerX: LayoutAnchor {
        return anchor(.centerX)
    }

    var centerY: LayoutAnchor {
        return anchor(.centerY)
    }

    var center: LayoutAnchor {
        return anchor(.center)
    }

    var edges: LayoutAnchor {
        return anchor(.edges)
    }

    var constantHeight: LayoutAnchor {
        return anchor(.constantHeight)
    }

    var constantWidth: LayoutAnchor {
        return anchor(.constantWidth)
    }
}
