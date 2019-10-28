//
//  LayoutConstraint.swift
//  LayoutSugar_Example
//
//  Created by Matt Provost on 10/28/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public typealias LayoutRelation = NSLayoutConstraint.Relation

internal struct LayoutConstraint {
    private let fromAnchor: LayoutAnchor

    private let toAnchor: LayoutAnchor

    private let constants: [CGFloat]

    private let relation: LayoutRelation

    init(fromAnchor: LayoutAnchor, toAnchor: LayoutAnchor, relation: LayoutRelation, constants: [CGFloat]) {
        self.fromAnchor = fromAnchor
        self.toAnchor = toAnchor
        self.relation = relation
        self.constants = constants
    }
}

internal extension LayoutConstraint {
    var constraints: [NSLayoutConstraint] {
        guard fromAnchor.attributes.count == toAnchor.attributes.count else {
            fatalError("[Material Error: The number of attributes of anchors does not match.]")
        }

        guard fromAnchor.attributes.count == constants.count else {
            fatalError("[Material Error: The number of constants does not match the number of constraints.]")
        }

        var v: [NSLayoutConstraint] = []

        zip(zip(fromAnchor.attributes, toAnchor.attributes), constants).forEach {
            v.append(NSLayoutConstraint(item: fromAnchor.constraintable as Any,
                                        attribute: $0.0,
                                        relatedBy: relation,
                                        toItem: toAnchor.constraintable,
                                        attribute: $0.1,
                                        multiplier: 1,
                                        constant: $1))
        }


        return v
    }
}

internal extension NSLayoutConstraint {
    /**
     Checks if the constraint is equal to given constraint.
     - Parameter _ other: An NSLayoutConstraint.
     - Returns: A Bool indicating whether constraints are equal.
     */
    func equalTo(_ other: NSLayoutConstraint) -> Bool {
        return firstItem === other.firstItem
            && secondItem === other.secondItem
            && firstAttribute == other.firstAttribute
            && secondAttribute == other.secondAttribute
            && relation == other.relation
    }
}
