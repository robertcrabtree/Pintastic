//
//  Pin.swift
//  Pintastic
//
//  Created by Rob on 11/4/21.
//

import Foundation
import UIKit

/// A simple wrapper around autolayout
///
/// A pin can have two types of relationships:
/// - `.discrete`: The item will not be pinned to another iteam (such as for width and height configurations)
/// - `.relational`: The item will be pinned to another item (such as for alignment configurations)
///
/// In this example a view's dimensions are constrained to a width and height of 100.0
///
/// ```
/// let pin = Pin(item: view, relationship: .discrete)
///     .width(constant: 100.0)
///     .height(constant: 100.0)
///     .activate()
/// ```
/// Another way of accomplishing the same thing:
///
/// ```
/// view
///     .pin()
///     .width(constant: 100.0)
///     .height(constant: 100.0)
///     .activate()
/// ```
///
/// In this example the primary item's edges are constrained to the edges of the other, or secondary, `Pinnable` item.
///
/// ```
/// let pin = Pin(item: childView, relationship: .relational(containerView)
///     .leadingEdges()
///     .trailingEdges()
///     .topEdges()
///     .bottomEdges()
///     .activate()
/// ```
///
/// Another way of accomplishing the same thing:
///
/// ```
/// childView
///     .pin(to: containerView)
///     .leadingEdges()
///     .trailingEdges()
///     .topEdges()
///     .bottomEdges()
///     .activate()
/// ```
///
public class Pin {

    // MARK: API

    /// Add a custom constraint
    ///
    /// To help identify the constraint it's wise to set the `identifier` property on the constraint
    ///
    /// To retrieve the constraint, call `constraint(identifier:handler:)` or  `constraint(identifier:)`
    ///
    /// Constraint will be activated when you call `activate()`
    ///
    /// - Parameters:
    ///   - identifier: An identifier for the constraint
    ///   - constraint: The constraint you wish to add
    /// - Returns: A reference to the `Pin`
    public func using(constraintIdentifier identifier: String, constraint: NSLayoutConstraint) -> Self {
        addConstraint(identifier, constraint: constraint)
    }

    /// Add a custom constraint
    ///
    /// To help identify the constraint it's wise to set the `identifier` property on the constraint
    ///
    /// To retrieve the constraint, call `constraint(withIdentifier:handler:)` or  `constraint(withIdentifier:)`
    ///
    /// Constraint will be activated when you call `activate()`
    ///
    /// - Parameters:
    ///   - identifier: An identifier for the constraint
    ///   - builder: A closure that makes and returns a custom constraint
    /// - Returns: A reference to the `Pin`
    public func using(constraintIdentifier identifier: String, constraint: () -> NSLayoutConstraint) -> Self {
        using(constraintIdentifier: identifier, constraint: constraint())
    }

    /// Request a constraint of the specified type
    ///
    /// This is useful if you need to customize the constraint
    ///
    /// - Parameters:
    ///   - type: The type of constraint
    ///   - handler: A closure that passes the constraint to the caller
    /// - Returns: A reference to the `Pin`
    public func constraint(
        ofType type: Constraint,
        handler: (NSLayoutConstraint?) -> Void
    ) -> Self {
        constraint(withIdentifier: type.rawValue, handler: handler)
    }

    /// Request a constraint of the specified type
    ///
    /// This is useful if you need to modify or customize the constraint at a later time.
    ///
    /// - Parameters:
    ///   - type: The type of constraint
    /// - Returns: The requested constraint
    public func constraint(ofType type: Constraint) -> NSLayoutConstraint? {
        constraint(withIdentifier: type.rawValue)
    }

    /// Request a constraint with the specified `identifier` added via the `using(constraintIdentifier:constraint:)` method
    ///
    /// - Parameters:
    ///   - identifier: The constraint identifier
    ///   - handler: A closure that passes the constraint to the caller
    /// - Returns: A reference to the `Pin`
    public func constraint(
        withIdentifier identifier: String,
        handler: (NSLayoutConstraint?) -> Void
    ) -> Self {
        handler(constraint(withIdentifier: identifier))
        return self
    }

    /// Request a constraint with the specified `identifier` added via the `using(constraintIdentifier:constraint:)` method
    ///
    /// This is useful if you need to modify or customize the constraint at a later time.
    ///
    /// - Parameters:
    ///   - identifier: The constraint identifier
    /// - Returns: The requested constraint
    public func constraint(withIdentifier identifier: String) -> NSLayoutConstraint? {
        constraints[identifier]
    }

    /// Activates all of the previously specified constraints
    ///
    /// This must be the last method called in the call chain.
    ///
    /// ```
    /// view
    ///     .pin(to: containerView)
    ///     .edges()
    ///     .activate()
    /// ```
    ///
    /// - Returns: A reference to the `Pin`
    @discardableResult
    public func activate() -> Self {
        NSLayoutConstraint.activate(constraints.values.map { $0 })
        return self
    }

    /// Activate the specified constraint
    ///
    /// - Parameters:
    ///   - type: The constraint type
    public func activateConstraint(ofType type: Constraint) {
        self.constraint(ofType: type)?.isActive = true
    }

    /// Activate the specified constraint
    ///
    /// - Parameters:
    ///   - identifier: The constraint identifier
    public func activateConstraint(withIdentifier identifier: String) {
        constraint(withIdentifier: identifier)?.isActive = true
    }

    /// Deactivate all constraints
    ///
    public func deactivate() {
        NSLayoutConstraint.deactivate(constraints.values.map { $0 })
    }

    /// Deactivate the specified constraint
    ///
    /// This call does not remove the constraint. To remove the constraint call `removeConstraint(constraint:)`
    ///
    /// - Parameters:
    ///   - type: The constraint type
    public func deactivateConstraint(ofType type: Constraint) {
        constraint(ofType: type)?.isActive = false
    }

    /// Deactivate the specified constraint
    ///
    /// This call does not remove the constraint. To remove the constraint call `removeConstraint(identifier:)`
    ///
    /// - Parameters:
    ///   - identifier: The constraint identifier
    public func deactivateConstraint(withIdentifier identifier: String) {
        constraint(withIdentifier: identifier)?.isActive = false
    }

    /// Remove the specified constraint
    ///
    /// This method does not deactivate the constraint. It only frees it from `Pin` management
    ///
    /// - Parameters:
    ///   - type: The constraint type
    /// - Returns: The requested constraint
    @discardableResult
    public func removeConstraint(ofType type: Constraint) -> NSLayoutConstraint? {
        removeConstraint(withIdentifier: type.rawValue)
    }

    /// Remove the specified constraint
    ///
    /// This method does not deactivate the constraint. It only frees it from `Pin` management
    ///
    /// - Parameters:
    ///   - identifier: The constraint identifier
    /// - Returns: The requested constraint
    @discardableResult
    public func removeConstraint(withIdentifier identifier: String) -> NSLayoutConstraint? {
        constraints.removeValue(forKey: identifier)
    }

    // MARK: Private vars and constants

    fileprivate var constraints: [String: NSLayoutConstraint] = [:]

    // MARK: Private methods

    fileprivate func addConstraint(_ type: Constraint, constraint: NSLayoutConstraint) -> Self {
        addConstraint(type.rawValue, constraint: constraint)
    }

    fileprivate func addConstraint(_ identifier: String, constraint: NSLayoutConstraint) -> Self {
        assert(constraints[identifier] == nil, "A constraint identifier \(identifier) already exists")

        constraint.identifier = identifier
        constraints[identifier] = constraint
        return self
    }
}


public class SinglePin: Pin {

    /// Initialize a `Pin` with the item(s) to apply constraints to
    /// - Parameter item: The `Pinnable` item you wish to apply constraints to
    public init(item: Pinnable) {
        self.primaryItem = item
    }

    /// Constrain the width of the primary item to the the specified constant
    /// - Parameter constant: The desired width
    /// - Returns: A reference to the `Pin`
    public func width(constant: CGFloat) -> SinglePin {
        addConstraint(
            .width,
            constraint: primaryItem.widthAnchor.constraint(equalToConstant: constant)
        )
    }

    /// Constrain the height of the primary item to the the specified constant
    /// - Parameter constant: The desired height
    /// - Returns: A reference to the `Pin`
    public func height(constant: CGFloat) -> SinglePin {
        addConstraint(
            .height,
            constraint: primaryItem.heightAnchor.constraint(equalToConstant: constant)
        )
    }

    /// Constrain the primary item width to the primary item height
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `Pin`
    public func widthToHeight(multiplier: CGFloat = 1.0) -> SinglePin {
        addConstraint(
            .widthToHeight,
            constraint: primaryItem.widthAnchor.constraint(
                equalTo: primaryItem.heightAnchor,
                multiplier: multiplier
            )
        )
    }

    /// Constrain the primary item width to the primary item height
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `Pin`
    public func heightToWidth(multiplier: CGFloat = 1.0) -> SinglePin {
        addConstraint(
            .heightToWidth,
            constraint: primaryItem.heightAnchor.constraint(
                equalTo: primaryItem.widthAnchor,
                multiplier: multiplier
            )
        )
    }

    fileprivate let primaryItem: Pinnable
}

public class DoublePin: Pin {

    /// Initialize a `Pin` with the item(s) to apply constraints to
    /// - Parameter item: The `Pinnable` item you wish to apply constraints to
    public init(primaryItem: Pinnable, secondaryItem: Pinnable) {
        self.primaryItem = primaryItem
        self.secondaryItem = secondaryItem
    }

    /// Pin the edges of the primary item to the secondary item
    /// - Returns: A reference to the `Pin`
    public func edges() -> DoublePin {
        leadingEdges().trailingEdges().topEdges().bottomEdges()
    }

    /// Pin the leading edges of the primary item to the secondary item
    /// - Parameter constant: A positive value will inset the leading edge by this value.
    /// - Returns: A reference to the `Pin`
    public func leadingEdges(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.leadingEdges) { other in
            primaryItem.leadingAnchor.constraint(equalTo: other.leadingAnchor, constant: constant)
        }
    }

    /// Pin the trailing edges of the primary item to the secondary item
    /// - Parameter constant: A negative value will inset the trailing edge by this value.
    /// - Returns: A reference to the `Pin`
    public func trailingEdges(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.trailingEdges) { other in
            primaryItem.trailingAnchor.constraint(equalTo: other.trailingAnchor, constant: constant)
        }
    }

    /// Pin the top edge of the primary item to the top edge of the secondary item.
    /// - Parameter constant: A positive value will inset the top edge by this value.
    /// - Returns: A reference to the `Pin`
    public func topEdges(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.topEdges) { other in
            primaryItem.topAnchor.constraint(equalTo: other.topAnchor, constant: constant)
        }
    }

    /// Pin the bottom edge of the primary item to the bottom edge of the secondary item.
    /// - Parameter constant: A negative value will inset the bottom edge by this value.
    /// - Returns: A reference to the `Pin`
    public func bottomEdges(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.bottomEdges) { other in
            primaryItem.bottomAnchor.constraint(equalTo: other.bottomAnchor, constant: constant)
        }
    }

    /// Pin the bottom of the primary item to the top of the secondary item
    /// - Parameter constant: A negative value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func above(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.above) { other in
            primaryItem.bottomAnchor.constraint(equalTo: other.topAnchor, constant: constant)
        }
    }

    /// Pin the top of the primary item to the bottom of the secondary item
    /// - Parameter constant: A positive value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func below(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.below) { other in
            primaryItem.topAnchor.constraint(equalTo: other.bottomAnchor, constant: constant)
        }
    }

    /// Pin the trailing edge of the primary item to the leading edge of the secondary item
    /// - Parameter constant: A negative value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func before(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.before) { other in
            primaryItem.trailingAnchor.constraint(equalTo: other.leadingAnchor, constant: constant)
        }
    }

    /// Pin the leading edge of the primary item to the trailing edge of the secondary item
    /// - Parameter constant: A positive value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func after(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.after) { other in
            primaryItem.leadingAnchor.constraint(equalTo: other.trailingAnchor, constant: constant)
        }
    }

    /// Pin the horizontal and vertical centers of the primary to the secondary item
    /// - Returns: A reference to the `Pin`
    public func centers() -> DoublePin {
        horizontalCenters().verticalCenters()
    }

    /// Pin the horizontal centers of the primary item and the secondary item
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `Pin`
    public func horizontalCenters(multiplier: CGFloat = 1.0) -> DoublePin {
        addRelationalConstraint(.horizontalCenters) { other in
            NSLayoutConstraint(
                item: primaryItem,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: other,
                attribute: .centerX,
                multiplier: multiplier,
                constant: 0.0
            )
        }
    }

    /// Pin the vertical centers of the primary item and the secondary item
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `Pin`
    public func verticalCenters(multiplier: CGFloat = 1.0) -> DoublePin {
        addRelationalConstraint(.verticalCenters) { other in
            NSLayoutConstraint(
                item: primaryItem,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: other,
                attribute: .centerY,
                multiplier: multiplier,
                constant: 0.0
            )
        }
    }

    /// Constrain the primary item width to the width of the secondary item
    /// - Parameter multiplier: The width multiplier
    /// - Returns: A reference to the `Pin`
    public func widths(multiplier: CGFloat = 1.0) -> DoublePin {
        addRelationalConstraint(.widths) { other in
            primaryItem.widthAnchor.constraint(equalTo: other.widthAnchor, multiplier: multiplier)
        }
    }

    /// Constrain the primary item height to the width of the secondary item
    /// - Parameter multiplier: The height multiplier
    /// - Returns: A reference to the `Pin`
    public func heights(multiplier: CGFloat = 1.0) -> DoublePin {
        addRelationalConstraint(.heights) { other in
            primaryItem.heightAnchor.constraint(equalTo: other.heightAnchor, multiplier: multiplier)
        }
    }

    /// Pin the leading edge of the primary item to the center of the secondary item
    /// - Parameter constant: A positive value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func leadingEdgeToHorizontalCenter(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.leadingToHorizontalCenter) { other in
            primaryItem.leadingAnchor.constraint(equalTo: other.centerXAnchor, constant: constant)
        }
    }

    /// Pin the trailing edge of the primary item to the center of the secondary item
    /// - Parameter constant: A negative value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func trailingEdgeToHorizontalCenter(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.trailingToHorizontalCenter) { other in
            primaryItem.trailingAnchor.constraint(equalTo: other.centerXAnchor, constant: constant)
        }
    }

    /// Pin the top of the primary item to the center of the secondary item
    /// - Parameter constant: A positive value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func topEdgeToVerticalCenter(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.topToVerticalCenter) { other in
            primaryItem.topAnchor.constraint(equalTo: other.centerYAnchor, constant: constant)
        }
    }

    /// Pin the bottom of the primary item to the center of the secondary item
    /// - Parameter constant: A negative value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func bottomEdgeToVerticalCenter(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.bottomToVerticalCenter) { other in
            primaryItem.bottomAnchor.constraint(equalTo: other.centerYAnchor, constant: constant)
        }
    }

    fileprivate func addRelationalConstraint(
        _ key: Constraint,
        block: (Pinnable) -> NSLayoutConstraint
    ) -> DoublePin {
        addConstraint(key, constraint: block(secondaryItem))
    }

    fileprivate let primaryItem: Pinnable
    fileprivate let secondaryItem: Pinnable
}
