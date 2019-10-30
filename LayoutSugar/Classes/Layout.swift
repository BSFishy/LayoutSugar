//
//  ViewController+Layout.swift
//  LayoutSugar_Example
//
//  Created by Matt Provost on 10/28/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

/// A protocol that can be constrained in some way
public protocol Constraintable: class {}

@available(iOS 9.0, *)
extension UILayoutGuide: Constraintable { }
extension UIView: Constraintable { }

// MARK: UIView extension
public extension UIView {
    /// Layout a view as a subview.
    ///
    /// This will add the provided view as a subview to this view then return
    /// its layout object to provide easy access. If the provided view is already a subview, adding it
    /// is skipped and its layout object is returned.
    ///
    /// **Example:**
    /// ```
    /// view.layout(subview)
    ///     .top(20)
    ///     .leading(10)
    ///     .trailing(10)
    ///     .bottom(5)
    /// ```
    /// - Parameter child: The child view to layout
    /// - Note: This always sets the child's `translatesAutoresizingMaskIntoConstraints` to false
    func layout(_ child: UIView) -> Layout {
        if self != child.superview {
            addSubview(child)
        }

        child.translatesAutoresizingMaskIntoConstraints = false
        return child.layout
    }

    /// The layout object for this view.
    ///
    /// The layout object can be used to add layout constraints to a view. Nothing will happen if
    /// this view has not already been added as a subview somewhere else.
    var layout: Layout {
        Layout(constraintable: self)
    }

    /// A `LayoutAnchor` that represents the safe area on iOS 11+.
    ///
    /// This will return a layout anchor whose constraintable is `safeAreaLayoutGuide` on iOS 11+. On
    /// versions prior to iOS 11, the constraintable is simply set to this view.
    var safeArea: LayoutAnchor {
        if #available(iOS 11.0, *) {
            return LayoutAnchor(constraintable: safeAreaLayoutGuide)
        } else {
            return LayoutAnchor(constraintable: self)
        }
    }
}

// MARK: Layout struct

/// An object that allows setting layout constraints.
///
/// This provides a set of easy to use functions to create layout constraints.
///
/// **Example:**
/// ```
/// view.layout(subview)
///     .top(20)
///     .leading(10)
///     .trailing(10)
///     .bottom(5)
/// ```
public struct Layout {
    /// The constraintable object that constraints will be made on.
    ///
    /// A constraintable object is used here to allow constraints to be set on layout guides
    /// rather than plain views so you can put constraints on the safe area.
    public private(set) weak var constraintable: Constraintable?

    /// The constraintable as a view.
    ///
    /// If the constraintable is a layout guide, this will return its owning view. Otherwise, the
    /// constraintable is attempted to be cast as a `UIView`.
    public var view: UIView? {
        if #available(iOS 9.0, *), let layoutGuide = constraintable as? UILayoutGuide {
            return layoutGuide.owningView
        }

        return constraintable as? UIView
    }

    /// The parent of the view.
    ///
    /// This will simply return `view`'s super view.
    public var parent: UIView? {
        return view?.superview
    }

    init(constraintable: Constraintable) {
        self.constraintable = constraintable
    }
}

// MARK: Layout functions
public extension Layout {
    /// Add a constraint to the top.
    ///
    /// This will constrain the top of this view to the top of its super view. The default offset is zero
    /// and the default relationship is equal to.
    /// - Parameter offset: The offset from the top of the superview
    /// - Parameter relationer: The relationship between the tops
    @discardableResult
    func top(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.top, relationer: relationer, constant: offset)
    }

    /// Add a constraint to the leading side.
    ///
    /// This will constrain the leading side of this view to the leading side of its super view.
    /// The default offset is zero and the default relationship is equal to.
    /// - Parameter offset: The offset from the leading side of the superview
    /// - Parameter relationer: The relationship between the leading sides
    @discardableResult
    func leading(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.leading, relationer: relationer, constant: offset)
    }

    /// Add a constraint to the left side.
    ///
    /// This will constrain the left side of this view to the left side of its super view.
    /// The default offset is zero and the default relationship is equal to.
    /// - Parameter offset: The offset from the left side of the superview
    /// - Parameter relationer: The relationship between the left sides
    @discardableResult
    func left(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.left, relationer: relationer, constant: offset)
    }

    /// Add a constraint to the trailing side.
    ///
    /// This will constrain the trailing side of this view to the trailing side of its super view.
    /// The default offset is zero and the default relationship is equal to.
    /// - Parameter offset: The offset from the trailing side of the superview
    /// - Parameter relationer: The relationship between the trailing sides
    @discardableResult
    func trailing(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.trailing, relationer: relationer, constant: -offset)
    }

    /// Add a constraint to the right side.
    ///
    /// This will constrain the right side of this view to the right side of its super view.
    /// The default offset is zero and the default relationship is equal to.
    /// - Parameter offset: The offset from the right side of the superview
    /// - Parameter relationer: The relationship between the right sides
    @discardableResult
    func right(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.right, relationer: relationer, constant: -offset)
    }

    /// Add a constraint to the bottom.
    ///
    /// This will constrain the bottom of this view to the bottom of its super view. The default offset is zero
    /// and the default relationship is equal to.
    /// - Parameter offset: The offset from the bottom of the superview
    /// - Parameter relationer: The relationship between the bottoms
    @discardableResult
    func bottom(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.bottom, relationer: relationer, constant: -offset)
    }

    /// Add a constraint to the width.
    ///
    /// This will constrain the width of this view to a constant value. The default relationship is equal to.
    /// - Parameter width: The constant value for the view
    /// - Parameter relationer: The relationship of the width
    @discardableResult
    func width(_ width: CGFloat, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.constantWidth, relationer: relationer, constants: width)
    }

    /// Add a constraint to the height.
    ///
    /// This will constrain the height of this view to a constant value. The default relationship is equal to.
    /// - Parameter height: The constant value for the view
    /// - Parameter relationer: The relationship of the height
    @discardableResult
    func height(_ height: CGFloat, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.constantHeight, relationer: relationer, constants: height)
    }

    /// Add a constraint to the size.
    ///
    /// This will make the view a constant box with the given width and height.
    /// - Parameter size: The size to make the view
    @discardableResult
    func size(_ size: CGSize) -> Layout {
        return width(size.width).height(size.height)
    }

    /// Add a constraint to the edges.
    ///
    /// This will constrain the edges of this view to the edges of the superview. By default, this will
    /// inset this view on the superview, but you can make it extend outside the view using negative
    /// values.
    /// - Parameter top: The offset from the top
    /// - Parameter left: The offset from the left
    /// - Parameter bottom: The offset from the bottom
    /// - Parameter right: The offset from the right
    @discardableResult
    func edges(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Layout {
        return constraint(.edges, constants: top, left, -bottom, -right)
    }

    /// Add a constraint to center the view.
    ///
    /// This will make the view in the center of both the x and y of the superview.
    /// - Parameter offsetX: The offset from the center x
    /// - Parameter offsetY: The offset from the center y
    @discardableResult
    func center(offsetX: CGFloat = 0, offsetY: CGFloat = 0) -> Layout {
        return constraint(.center, constants: offsetX, offsetY)
    }

    /// Add a constraint to center the view on the x axis.
    ///
    /// This will make the view horizontally centered in the superview.
    /// - Parameter offset: The offset from the center
    /// - Parameter relationer: The relationship of the offset
    @discardableResult
    func centerX(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.centerX, relationer: relationer, constant: offset)
    }

    /// Add a constraint to center the view on the y axis.
    ///
    /// This will make the view vertically centered in the superview.
    /// - Parameter offset: The offset from the center
    /// - Parameter relationer: The relationship of the offset
    @discardableResult
    func centerY(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.centerY, relationer: relationer, constant: offset)
    }
}

public extension Layout {
    /// Add a constraint to the top safe area.
    ///
    /// This will constrain the top of this view to the top of its safe area.
    /// If this is iOS less than 11, this will just be the superview, but if it's iOS 11+, it will
    /// use the safe area layout guide.
    /// The default offset is zero and the default relationship is equal to.
    /// - Parameter offset: The offset from the top of the safe area
    /// - Parameter relationer: The relationship between the tops
    @discardableResult
    func topSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.top, relationer: relationer, constant: offset, useSafeArea: true)
    }

    /// Add a constraint to the leading safe area.
    ///
    /// This will constrain the leading side of this view to the leading side of its safe area.
    /// If this is iOS less than 11, this will just be the superview, but if it's iOS 11+, it will
    /// use the safe area layout guide.
    /// The default offset is zero and the default relationship is equal to.
    /// - Parameter offset: The offset from the leading side of the safe area
    /// - Parameter relationer: The relationship between the leading sides
    @discardableResult
    func leadingSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.leading, relationer: relationer, constant: offset, useSafeArea: true)
    }

    /// Add a constraint to the left side safe area.
    ///
    /// This will constrain the left side of this view to the left side of its safe area.
    /// If this is iOS less than 11, this will just be the superview, but if it's iOS 11+, it will
    /// use the safe area layout guide.
    /// The default offset is zero and the default relationship is equal to.
    /// - Parameter offset: The offset from the left side of the safe area
    /// - Parameter relationer: The relationship between the left sides
    @discardableResult
    func leftSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.left, relationer: relationer, constant: offset, useSafeArea: true)
    }

    /// Add a constraint to the trailing side safe area.
    ///
    /// This will constrain the trailing side of this view to the trailing side of its safe area.
    /// If this is iOS less than 11, this will just be the superview, but if it's iOS 11+, it will
    /// use the safe area layout guide.
    /// The default offset is zero and the default relationship is equal to.
    /// - Parameter offset: The offset from the trailing side of the safe area
    /// - Parameter relationer: The relationship between the trailing sides
    @discardableResult
    func trailingSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.trailing, relationer: relationer, constant: -offset, useSafeArea: true)
    }

    /// Add a constraint to the right side safe area.
    ///
    /// This will constrain the right side of this view to the right side of its safe area.
    /// If this is iOS less than 11, this will just be the superview, but if it's iOS 11+, it will
    /// use the safe area layout guide.
    /// The default offset is zero and the default relationship is equal to.
    /// - Parameter offset: The offset from the right side of the safe area
    /// - Parameter relationer: The relationship between the right sides
    @discardableResult
    func rightSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.right, relationer: relationer, constant: -offset, useSafeArea: true)
    }

    /// Add a constraint to the bottom safe area.
    ///
    /// This will constrain the bottom of this view to the bottom of its safe area.
    /// If this is iOS less than 11, this will just be the superview, but if it's iOS 11+, it will
    /// use the safe area layout guide.
    /// The default offset is zero and the default relationship is equal to.
    /// - Parameter offset: The offset from the bottom of the safe area
    /// - Parameter relationer: The relationship between the bottoms
    @discardableResult
    func bottomSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.bottom, relationer: relationer, constant: -offset, useSafeArea: true)
    }

    /// Add a constraint to the width.
    ///
    /// This will constrain the width of this view to a constant value. The default relationship is equal to.
    /// - Parameter width: The constant value for the view
    /// - Parameter relationer: The relationship of the width
    @discardableResult
    func widthSafe(_ width: CGFloat, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.constantWidth, relationer: relationer, constants: width, useSafeArea: true)
    }

    /// Add a constraint to the height.
    ///
    /// This will constrain the height of this view to a constant value. The default relationship is equal to.
    /// - Parameter height: The constant value for the view
    /// - Parameter relationer: The relationship of the height
    @discardableResult
    func heightSafe(_ height: CGFloat, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.constantHeight, relationer: relationer, constants: height, useSafeArea: true)
    }

    /// Add a constraint to the size.
    ///
    /// This will make the view a constant box with the given width and height.
    /// - Parameter size: The size to make the view
    @discardableResult
    func sizeSafe(_ size: CGSize) -> Layout {
        return widthSafe(size.width).heightSafe(size.height)
    }

    /// Add a constraint to the edges.
    ///
    /// This will constrain the edges of this view to the edges of the safe area. By default, this will
    /// inset this view on the safe area, but you can make it extend outside the view using negative
    /// values.
    /// If this is iOS less than 11, this will just be the superview, but if it's iOS 11+, it will
    /// use the safe area layout guide.
    /// - Parameter top: The offset from the top
    /// - Parameter left: The offset from the left
    /// - Parameter bottom: The offset from the bottom
    /// - Parameter right: The offset from the right
    @discardableResult
    func edgesSafe(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Layout {
        return constraint(.edges, constants: top, left, -bottom, -right, useSafeArea: true)
    }

    /// Add a constraint to center the view.
    ///
    /// This will make the view in the center of both the x and y of the safe area.
    /// If this is iOS less than 11, this will just be the superview, but if it's iOS 11+, it will
    /// use the safe area layout guide.
    /// - Parameter offsetX: The offset from the center x
    /// - Parameter offsetY: The offset from the center y
    @discardableResult
    func centerSafe(offsetX: CGFloat = 0, offsetY: CGFloat = 0) -> Layout {
        return constraint(.center, constants: offsetX, offsetY, useSafeArea: true)
    }

    /// Add a constraint to center the view on the x axis.
    ///
    /// This will make the view horizontally centered in the safe area.
    /// If this is iOS less than 11, this will just be the superview, but if it's iOS 11+, it will
    /// use the safe area layout guide.
    /// - Parameter offset: The offset from the center
    /// - Parameter relationer: The relationship of the offset
    @discardableResult
    func centerXSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.centerX, relationer: relationer, constant: offset, useSafeArea: true)
    }

    /// Add a constraint to center the view on the y axis.
    ///
    /// This will make the view vertically centered in the safe area.
    /// If this is iOS less than 11, this will just be the superview, but if it's iOS 11+, it will
    /// use the safe area layout guide.
    /// - Parameter offset: The offset from the center
    /// - Parameter relationer: The relationship of the offset
    @discardableResult
    func centerYSafe(_ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.centerY, relationer: relationer, constant: offset, useSafeArea: true)
    }
}

public extension Layout {
    /// Add a constraint to the top.
    ///
    /// This will constrain the top of this view to the provided layout anchor. The default offset is zero
    /// and the default relationship is equal to.
    /// - Parameter anchor: The anchor to layout based on
    /// - Parameter offset: The offset from the top of the superview
    /// - Parameter relationer: The relationship between the anchor and the top
    @discardableResult
    func top(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.top, to: anchor, relationer: relationer, constant: offset)
    }

    /// Add a constraint to the left side.
    ///
    /// This will constrain the left side of this view to the provided layout anchor. The default offset is zero
    /// and the default relationship is equal to.
    /// - Parameter anchor: The anchor to layout based on
    /// - Parameter offset: The offset from the left side of the superview
    /// - Parameter relationer: The relationship between the anchor and the left side
    @discardableResult
    func left(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.left, to: anchor, relationer: relationer, constant: offset)
    }

    /// Add a constraint to the right side.
    ///
    /// This will constrain the right side of this view to the provided layout anchor. The default offset is zero
    /// and the default relationship is equal to.
    /// - Parameter anchor: The anchor to layout based on
    /// - Parameter offset: The offset from the right side of the superview
    /// - Parameter relationer: The relationship between the anchor and the right side
    @discardableResult
    func right(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.right, to: anchor, relationer: relationer, constant: -offset)
    }

    /// Add a constraint to the leading side.
    ///
    /// This will constrain the leading side of this view to the provided layout anchor. The default offset is zero
    /// and the default relationship is equal to.
    /// - Parameter anchor: The anchor to layout based on
    /// - Parameter offset: The offset from the leading side of the superview
    /// - Parameter relationer: The relationship between the anchor and the leading side
    @discardableResult
    func leading(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.leading, to: anchor, relationer: relationer, constant: offset)
    }

    /// Add a constraint to the trailing side.
    ///
    /// This will constrain the trailing side of this view to the provided layout anchor. The default offset is zero
    /// and the default relationship is equal to.
    /// - Parameter anchor: The anchor to layout based on
    /// - Parameter offset: The offset from the trailing side of the superview
    /// - Parameter relationer: The relationship between the anchor and the trailing side
    @discardableResult
    func trailing(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.trailing, to: anchor, relationer: relationer, constant: -offset)
    }

    /// Add a constraint to the bottom side.
    ///
    /// This will constrain the bottom side of this view to the provided layout anchor. The default offset is zero
    /// and the default relationship is equal to.
    /// - Parameter anchor: The anchor to layout based on
    /// - Parameter offset: The offset from the bottom side of the superview
    /// - Parameter relationer: The relationship between the anchor and the bottom side
    @discardableResult
    func bottom(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.bottom, to: anchor, relationer: relationer, constant: -offset)
    }

    /// Add a constraint to center the view.
    ///
    /// This will make the view in the center of both the x and y of the layout anchor.
    /// - Parameter anchor: The anchor to layout based on
    /// - Parameter offsetX: The offset from the center x
    /// - Parameter offsetY: The offset from the center y
    @discardableResult
    func center(_ anchor: LayoutAnchorable, offsetX: CGFloat = 0, offsetY: CGFloat = 0) -> Layout {
        return constraint(.center, to: anchor, constants: offsetX, offsetY)
    }

    /// Add a constraint to center the view on the x axis.
    ///
    /// This will make the view horizontally centered in the layout anchor.
    /// - Parameter anchor: The anchor to layout based on
    /// - Parameter offset: The offset from the center
    /// - Parameter relationer: The relationship of the offset
    @discardableResult
    func centerX(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.centerX, to: anchor, relationer: relationer, constant: offset)
    }

    /// Add a constraint to center the view on the y axis.
    ///
    /// This will make the view vertically centered in the layout anchor.
    /// - Parameter anchor: The anchor to layout based on
    /// - Parameter offset: The offset from the center
    /// - Parameter relationer: The relationship of the offset
    @discardableResult
    func centerY(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.centerY, to: anchor, relationer: relationer, constant: offset)
    }

    /// Add a constraint to the width.
    ///
    /// This will constrain the width of this view to a constant value. The default relationship is equal to.
    /// - Parameter anchor: The anchor to layout based on
    /// - Parameter offset: The constant value for the view
    /// - Parameter relationer: The relationship of the width
    @discardableResult
    func width(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.width, to: anchor, relationer: relationer, constant: offset)
    }

    /// Add a constraint to the height.
    ///
    /// This will constrain the height of this view to a constant value. The default relationship is equal to.
    /// - Parameter anchor: The anchor to layout based on
    /// - Parameter offset: The constant value for the view
    /// - Parameter relationer: The relationship of the height
    @discardableResult
    func height(_ anchor: LayoutAnchorable, _ offset: CGFloat = 0, _ relationer: LayoutRelationer = LayoutRelationerStruct.equal) -> Layout {
        return constraint(.height, to: anchor, relationer: relationer, constant: offset)
    }

    /// Add a constraint to the edges.
    ///
    /// This will constrain the edges of this view to the edges of the layout anchor. By default, this will
    /// inset this view on the layout anchor, but you can make it extend outside the view using negative
    /// values.
    /// - Parameter anchor: The anchor to layout based on
    /// - Parameter top: The offset from the top
    /// - Parameter left: The offset from the left
    /// - Parameter bottom: The offset from the bottom
    /// - Parameter right: The offset from the right
    @discardableResult
    func edges(_ anchor: LayoutAnchorable, top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Layout {
        return constraint(.edges, to: anchor, constants: top, left, -bottom, -right)
    }
}

public extension Layout {
    /// Add a constraint to the top.
    ///
    /// This will constrain the top of this view to the bottom of the given view.
    /// - Parameter view: The view to constrain to
    /// - Parameter offset: The offset from the bottom of the given view
    @discardableResult
    func below(_ view: UIView, _ offset: CGFloat = 0) -> Layout {
        return top(view.bottom, offset)
    }

    /// Add a constraint to the bottom.
    ///
    /// This will constrain the bottom of this view to the top of the given view.
    /// - Parameter view: The view to constrain to
    /// - Parameter offset: The offset from the top of the given view
    @discardableResult
    func above(_ view: UIView, _ offset: CGFloat = 0) -> Layout {
        return bottom(view.top, offset)
    }

    /// Add a constraint to the right.
    ///
    /// This will constrain the right side of this view to the left side of the given view.
    /// - Parameter view: The view to constrain to
    /// - Parameter offset: The offset from the left side of the given view
    @discardableResult
    func before(_ view: UIView, _ offset: CGFloat = 0) -> Layout {
        return right(view.left, offset)
    }

    /// Add a constraint to the left.
    ///
    /// This will constrain the left side of this view to the right side of the given view.
    /// - Parameter view: The view to constrain to
    /// - Parameter offset: The offset from the right side of the given view
    @discardableResult
    func after(_ view: UIView, _ offset: CGFloat = 0) -> Layout {
        return left(view.right, offset)
    }

    /// Add a constraint to the aspect ratio.
    ///
    /// This will set the height to the width then multiply the height by the given ratio.
    /// - Parameter ratio: The aspect ratio to constrain by
    @discardableResult
    func aspect(_ ratio: CGFloat = 1) -> Layout {
        return height(view!.width).multiply(ratio)
    }
}

public extension Layout {
    /// Multiply the previous constraint by a value.
    ///
    /// This will take the previous constraint and multiply it by the given value. If no
    /// constraint was previously set, a fatal error will be throw.
    ///
    /// Proper usage:
    /// ```
    /// view.layout(subview)
    ///     .top(20).multiply(2)
    /// ```
    /// - Parameter multiplier: The multiplier to set for the previous constraint
    @discardableResult
    func multiply(_ multiplier: CGFloat) -> Layout {
        return resetLastConstraint(multiplier: multiplier)
    }

    /// Set the priority of the previous constraint.
    ///
    /// This will take the previous constraint and set its priority to the given value. If no
    /// constraint was previously set, a fatal error will be throw.
    ///
    /// Proper usage:
    /// ```
    /// view.layout(subview)
    ///     .top(20).priority(500)
    /// ```
    /// - Parameter value: The value to set the priority to
    @discardableResult
    func priority(_ value: Float) -> Layout {
        return priority(.init(rawValue: value))
    }

    /// Set the priority of the previous constraint.
    ///
    /// This will take the previous constraint and set its priority to the given value. If no
    /// constraint was previously set, a fatal error will be throw.
    ///
    /// Proper usage:
    /// ```
    /// view.layout(subview)
    ///     .top(20).priority(.defaultHigh)
    /// ```
    /// - Parameter value: The value to set the priority to
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

private extension Layout {
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
