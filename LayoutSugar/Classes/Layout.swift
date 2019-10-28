//
//  ViewController+Layout.swift
//  LayoutSugar_Example
//
//  Created by Matt Provost on 10/28/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public protocol Constraintable: class {}

@available(iOS 9.0, *)
extension UILayoutGuide: Constraintable { }
extension UIView: Constraintable { }

// MARK: UIView extension
public extension UIView {
    func layout(_ child: UIView) -> Layout {
        if self != child.superview {
            addSubview(child)
        }

        child.translatesAutoresizingMaskIntoConstraints = false
        return child.layout
    }

    var layout: Layout {
        Layout(constraintable: self)
    }

    var safeArea: LayoutAnchor {
        if #available(iOS 11.0, *) {
            return LayoutAnchor(constraintable: safeAreaLayoutGuide)
        } else {
            return LayoutAnchor(constraintable: self)
        }
    }
}

// MARK: Layout struct
public struct Layout {
    public private(set) weak var constraintable: Constraintable?

    public var view: UIView? {
        if #available(iOS 9.0, *), !(constraintable is UIView) {
            return (constraintable as? UILayoutGuide)?.owningView
        }

        return constraintable as? UIView
    }

    public var parent: UIView? {
        return view?.superview
    }

    init(constraintable: Constraintable) {
        self.constraintable = constraintable
    }
}

// MARK: Layout functions
public extension Layout {
    @discardableResult
    func top(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.top, relationer: relationer, constant: offset)
    }

    @discardableResult
    func leading(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.leading, relationer: relationer, constant: offset)
    }

    @discardableResult
    func left(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.left, relationer: relationer, constant: offset)
    }

    @discardableResult
    func trailing(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.trailing, relationer: relationer, constant: offset)
    }

    @discardableResult
    func right(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.right, relationer: relationer, constant: offset)
    }

    @discardableResult
    func bottom(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.bottom, relationer: relationer, constant: offset)
    }

    @discardableResult
    func width(_ width: CGFloat, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.constantWidth, relationer: relationer, constants: width)
    }

    @discardableResult
    func height(_ height: CGFloat, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.constantHeight, relationer: relationer, constants: height)
    }

    @discardableResult
    func size(_ size: CGSize) -> Layout {
        return width(size.width).height(size.height)
    }

    @discardableResult
    func edges(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Layout {
        return constraint(.edges, constants: top, left, -bottom, -right)
    }

    @discardableResult
    func center(offsetX: CGFloat = 0, offsetY: CGFloat = 0) -> Layout {
        return constraint(.center, constants: offsetX, offsetY)
    }

    @discardableResult
    func centerX(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.centerX, relationer: relationer, constant: offset)
    }

    @discardableResult
    func centerY(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.centerY, relationer: relationer, constant: offset)
    }
}

public extension Layout {
    @discardableResult
    func topSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.top, relationer: relationer, constant: offset, useSafeArea: true)
    }

    @discardableResult
    func leadingSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.leading, relationer: relationer, constant: offset, useSafeArea: true)
    }

    @discardableResult
    func leftSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.left, relationer: relationer, constant: offset, useSafeArea: true)
    }

    @discardableResult
    func trailingSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.trailing, relationer: relationer, constant: offset, useSafeArea: true)
    }

    @discardableResult
    func rightSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.right, relationer: relationer, constant: offset, useSafeArea: true)
    }

    @discardableResult
    func bottomSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.bottom, relationer: relationer, constant: offset, useSafeArea: true)
    }

    @discardableResult
    func widthSafe(_ width: CGFloat, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.constantWidth, relationer: relationer, constants: width, useSafeArea: true)
    }

    @discardableResult
    func heightSafe(_ height: CGFloat, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.constantHeight, relationer: relationer, constants: height, useSafeArea: true)
    }

    @discardableResult
    func sizeSafe(_ size: CGSize) -> Layout {
        return widthSafe(size.width).heightSafe(size.height)
    }

    @discardableResult
    func edgesSafe(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Layout {
        return constraint(.edges, constants: top, left, -bottom, -right, useSafeArea: true)
    }

    @discardableResult
    func centerSafe(offsetX: CGFloat = 0, offsetY: CGFloat = 0) -> Layout {
        return constraint(.center, constants: offsetX, offsetY, useSafeArea: true)
    }

    @discardableResult
    func centerXSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.centerX, relationer: relationer, constant: offset, useSafeArea: true)
    }

    @discardableResult
    func centerYSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.centerY, relationer: relationer, constant: offset, useSafeArea: true)
    }
}

public extension Layout {
    @discardableResult
    func top(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.top, to: anchor, relationer: relationer, constant: offset)
    }

    @discardableResult
    func left(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.left, to: anchor, relationer: relationer, constant: offset)
    }

    @discardableResult
    func right(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.right, to: anchor, relationer: relationer, constant: -offset)
    }

    @discardableResult
    func leading(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.leading, to: anchor, relationer: relationer, constant: offset)
    }

    @discardableResult
    func trailing(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.trailing, to: anchor, relationer: relationer, constant: -offset)
    }

    @discardableResult
    func bottom(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.bottom, to: anchor, relationer: relationer, constant: -offset)
    }

    @discardableResult
    func center(_ anchor: LayoutAnchorable, offsetX: CGFloat = 0, offsetY: CGFloat = 0) -> Layout {
        return constraint(.center, to: anchor, constants: offsetX, offsetY)
    }

    @discardableResult
    func centerX(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.centerX, to: anchor, relationer: relationer, constant: offset)
    }

    @discardableResult
    func centerY(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.centerY, to: anchor, relationer: relationer, constant: offset)
    }

    @discardableResult
    func width(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.width, to: anchor, relationer: relationer, constant: offset)
    }

    @discardableResult
    func height(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.height, to: anchor, relationer: relationer, constant: offset)
    }

    @discardableResult
    func edges(_ anchor: LayoutAnchorable, top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Layout {
        return constraint(.edges, to: anchor, constants: top, left, -bottom, -right)
    }
}

public extension Layout {
    @discardableResult
    func below(_ view: UIView, _ offset: CGFloat = 0) -> Layout {
        return top(view.bottom, offset)
    }

    @discardableResult
    func above(_ view: UIView, _ offset: CGFloat = 0) -> Layout {
        return bottom(view.top, offset)
    }

    @discardableResult
    func before(_ view: UIView, _ offset: CGFloat = 0) -> Layout {
        return right(view.left, offset)
    }

    @discardableResult
    func after(_ view: UIView, _ offset: CGFloat = 0) -> Layout {
        return left(view.right, offset)
    }

    @discardableResult
    func aspect(_ ratio: CGFloat = 1) -> Layout {
        return height(view!.width).multiply(ratio)
    }
}

public extension Layout {
    @discardableResult
    func multiply(_ multiplier: CGFloat) -> Layout {
        return resetLastConstraint(multiplier: multiplier)
    }

    @discardableResult
    func priority(_ value: Float) -> Layout {
        return priority(.init(rawValue: value))
    }

    @discardableResult
    func priority(_ priority: UILayoutPriority) -> Layout {
        return resetLastConstraint(priority: priority)
    }

    private func resetLastConstraint(multiplier: CGFloat? = nil, priority: UILayoutPriority? = nil) -> Layout {
        guard let v = view?.lastConstraint, v.isActive else {
            return self
        }
        v.isActive = false
        let newV = NSLayoutConstraint(item: v.firstItem as Any,
                                      attribute: v.firstAttribute,
                                      relatedBy: v.relation,
                                      toItem: v.secondItem,
                                      attribute: v.secondAttribute,
                                      multiplier: multiplier ?? v.multiplier,
                                      constant: v.constant)
        newV.priority = priority ?? v.priority
        newV.isActive = true
        view?.lastConstraint = newV
        return self
    }
}

// MARK: Constraint functions
private var LastConstraintKey: UInt8 = 0

private extension UIView {
    var lastConstraint: NSLayoutConstraint? {
        get {
            return AssociatedObject.get(base: self, key: &LastConstraintKey) {
                nil
            }
        }
        set(value) {
            AssociatedObject.set(base: self, key: &LastConstraintKey, value: value)
        }
    }
}

public extension Layout {
    func constraint(_ attribute: LayoutAttribute, relationer: LayoutRelationer = LayoutRelationerStruct.equal, constant: CGFloat, useSafeArea: Bool = false) -> Layout {
        return constraint([attribute], relationer: relationer, constants: constant, useSafeArea: useSafeArea)
    }

    func constraint(_ attributes: [LayoutAttribute], relationer: LayoutRelationer = LayoutRelationerStruct.equal, constants: CGFloat..., useSafeArea: Bool = false) -> Layout {
        var attributes = attributes
        var anchor: LayoutAnchor!

        if attributes.last == .notAnAttribute {
            attributes.removeLast()
            anchor = LayoutAnchor(constraintable: nil, attributes: [.notAnAttribute])
        } else {
            guard parent != nil else {
                fatalError("[LayoutSugar] Constraint requires view to have a parent")
            }

            anchor = LayoutAnchor(constraintable: useSafeArea ? parent?.safeArea.constraintable : parent, attributes: attributes)
        }

        return constraint(attributes, to: anchor, relationer: relationer, constants: constants)
    }

    func constraint(_ attribute: LayoutAttribute, to anchor: LayoutAnchorable, relationer: LayoutRelationer = LayoutRelationerStruct.equal, constant: CGFloat) -> Layout {
        return constraint([attribute], to: anchor, relationer: relationer, constants: constant)
    }

    func constraint(_ attributes: [LayoutAttribute], to anchor: LayoutAnchorable, relationer: LayoutRelationer = LayoutRelationerStruct.equal, constants: CGFloat...) -> Layout {
        return constraint(attributes, to: anchor, relationer: relationer, constants: constants)
    }

    func constraint(_ attributes: [LayoutAttribute], to anchor: LayoutAnchorable, relationer: LayoutRelationer, constants: [CGFloat]) -> Layout {
        let from = LayoutAnchor(constraintable: constraintable, attributes: attributes)
        var to = anchor as? LayoutAnchor
        if to?.attributes.isEmpty ?? true {
            let v = (anchor as? UIView) ?? anchor.constraintable
            to = LayoutAnchor(constraintable: v, attributes: attributes)
        }

        let constraint = LayoutConstraint(fromAnchor: from, toAnchor: to!, relation: relationer(.nil, .nil), constants: constants)
        let constraints = (view?.constraints ?? []) + (view?.superview?.constraints ?? [])
        for constraint in constraint.constraints {
            guard let activeConstraint = constraints.first(where: { $0.equalTo(constraint) }) else {
                constraint.isActive = true
                view?.lastConstraint = constraint
                continue
            }

            activeConstraint.constant = constraint.constant
        }

        return self
    }
}
