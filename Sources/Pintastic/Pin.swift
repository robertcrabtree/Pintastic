//
//  Pin.swift
//  Pintastic
//
//  Created by Rob on 11/4/21.
//

import Foundation
import UIKit

/// A wrapper around autolayout
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
///     .pin
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

    /// The current `Pin` state
    private(set) var state = State.inactive

    /// Initialize a `Pin` with the item(s) to apply constraints to
    /// - Parameter item: The `Pinnable` item you wish to apply constraints to
    /// - Parameter type: `.discreet` if the item will not be pinned to another item. `.relational` if the item will be pinned to another
    public init(item: Pinnable, relationship: Relationship) {
        self.primaryItem = item
        self.relationship = relationship
    }

    /// Pin the edges of the primary item to the secondary item
    /// - Returns: A reference to the `Pin`
    public func edges() -> Pin {
        leadingEdges().trailingEdges().topEdges().bottomEdges()
    }

    /// Pin the leading edges of the primary item to the secondary item
    /// - Parameter constant: A positive value will inset the leading edge by this value.
    /// - Returns: A reference to the `Pin`
    public func leadingEdges(constant: CGFloat = 0.0) -> Pin {
        addRelationalConstraint(.leadingEdges) { other in
            primaryItem.leadingAnchor.constraint(equalTo: other.leadingAnchor, constant: constant)
        }
    }

    /// Pin the trailing edges of the primary item to the secondary item
    /// - Parameter constant: A negative value will inset the trailing edge by this value.
    /// - Returns: A reference to the `Pin`
    public func trailingEdges(constant: CGFloat = 0.0) -> Pin {
        addRelationalConstraint(.trailingEdges) { other in
            primaryItem.trailingAnchor.constraint(equalTo: other.trailingAnchor, constant: constant)
        }
    }

    /// Pin the top edge of the primary item to the top edge of the secondary item.
    /// - Parameter constant: A positive value will inset the top edge by this value.
    /// - Returns: A reference to the `Pin`
    public func topEdges(constant: CGFloat = 0.0) -> Pin {
        addRelationalConstraint(.topEdges) { other in
            primaryItem.topAnchor.constraint(equalTo: other.topAnchor, constant: constant)
        }
    }

    /// Pin the bottom edge of the primary item to the bottom edge of the secondary item.
    /// - Parameter constant: A negative value will inset the bottom edge by this value.
    /// - Returns: A reference to the `Pin`
    public func bottomEdges(constant: CGFloat = 0.0) -> Pin {
        addRelationalConstraint(.bottomEdges) { other in
            primaryItem.bottomAnchor.constraint(equalTo: other.bottomAnchor, constant: constant)
        }
    }

    /// Pin the bottom of the primary item to the top of the secondary item
    /// - Parameter constant: A negative value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func bottomToTopEdge(constant: CGFloat = 0.0) -> Pin {
        addRelationalConstraint(.bottomToTopEdge) { other in
            primaryItem.bottomAnchor.constraint(equalTo: other.topAnchor, constant: constant)
        }
    }

    /// Pin the top of the primary item to the bottom of the secondary item
    /// - Parameter constant: A positive value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func topToBottomEdge(constant: CGFloat = 0.0) -> Pin {
        addRelationalConstraint(.topToBottomEdge) { other in
            primaryItem.topAnchor.constraint(equalTo: other.bottomAnchor, constant: constant)
        }
    }

    /// Pin the leading edge of the primary item to the trailing edge of the secondary item
    /// - Parameter constant: A positive value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func leadingToTrailingEdge(constant: CGFloat = 0.0) -> Pin {
        addRelationalConstraint(.leadingToTrailingEdge) { other in
            primaryItem.leadingAnchor.constraint(equalTo: other.trailingAnchor, constant: constant)
        }
    }

    /// Pin the trailing edge of the primary item to the leading edge of the secondary item
    /// - Parameter constant: A negative value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func trailingToLeadingEdge(constant: CGFloat = 0.0) -> Pin {
        addRelationalConstraint(.trailingToLeadingEdge) { other in
            primaryItem.trailingAnchor.constraint(equalTo: other.leadingAnchor, constant: constant)
        }
    }

    /// Pin the horizontal centers of the primary item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func horizontalCenters() -> Pin {
        addRelationalConstraint(.horizontalCenters) { other in
            primaryItem.centerXAnchor.constraint(equalTo: other.centerXAnchor)
        }
    }

    /// Pin the vertical centers of the primary item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func verticalCenters() -> Pin {
        addRelationalConstraint(.verticalCenters) { other in
            primaryItem.centerYAnchor.constraint(equalTo: other.centerYAnchor)
        }
    }

    /// Constrain the width of the primary item to the the specified constant
    /// - Parameter constant: The desired width
    /// - Returns: A reference to the `Pin`
    public func width(to constant: CGFloat) -> Pin {
        addConstraint(
            .width,
            constraint: primaryItem.widthAnchor.constraint(equalToConstant: constant)
        )
    }

    /// Constrain the height of the primary item to the the specified constant
    /// - Parameter constant: The desired height
    /// - Returns: A reference to the `Pin`
    public func height(to constant: CGFloat) -> Pin {
        addConstraint(
            .height,
            constraint: primaryItem.heightAnchor.constraint(equalToConstant: constant)
        )
    }

    /// Constrain the primary item width to the width of the secondary item
    /// - Parameter multiplier: The width multiplier
    /// - Returns: A reference to the `Pin`
    public func equalWidths(multiplier: CGFloat = 1.0) -> Pin {
        addRelationalConstraint(.equalWidths) { other in
            primaryItem.widthAnchor.constraint(equalTo: other.widthAnchor, multiplier: multiplier)
        }
    }

    /// Constrain the primary item height to the width of the secondary item
    /// - Parameter multiplier: The height multiplier
    /// - Returns: A reference to the `Pin`
    public func equalHeights(multiplier: CGFloat = 1.0) -> Pin {
        addRelationalConstraint(.equalHeights) { other in
            primaryItem.heightAnchor.constraint(equalTo: other.heightAnchor, multiplier: multiplier)
        }
    }

    /// Pin the leading edge of the primary item to the center of the secondary item
    /// - Parameter constant: A positive value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func leadingEdgeToCenter(constant: CGFloat = 0.0) -> Pin {
        addRelationalConstraint(.leadingEdgeToCenter) { other in
            primaryItem.leadingAnchor.constraint(equalTo: other.centerXAnchor, constant: constant)
        }
    }

    /// Pin the trailing edge of the primary item to the center of the secondary item
    /// - Parameter constant: A negative value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func trailingEdgeToCenter(constant: CGFloat = 0.0) -> Pin {
        addRelationalConstraint(.trailingEdgeToCenter) { other in
            primaryItem.trailingAnchor.constraint(equalTo: other.centerXAnchor, constant: constant)
        }
    }

    /// Pin the top of the primary item to the center of the secondary item
    /// - Parameter constant: A positive value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func topEdgeToCenter(constant: CGFloat = 0.0) -> Pin {
        addRelationalConstraint(.topEdgeToCenter) { other in
            primaryItem.topAnchor.constraint(equalTo: other.centerYAnchor, constant: constant)
        }
    }

    /// Pin the bottom of the primary item to the center of the secondary item
    /// - Parameter constant: A negative value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func bottomEdgeToCenter(constant: CGFloat = 0.0) -> Pin {
        addRelationalConstraint(.bottomEdgeToCenter) { other in
            primaryItem.bottomAnchor.constraint(equalTo: other.centerYAnchor, constant: constant)
        }
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
    ) -> Pin {
        handler(self.constraint(ofType: type))
        return self
    }

    /// Request a constraint of the specified type
    ///
    /// This is useful if you need to modify or customize the constraint at a later time.
    ///
    /// - Parameters:
    ///   - type: The type of constraint
    /// - Returns: The requested constraint
    public func constraint(ofType type: Constraint) -> NSLayoutConstraint? {
        constraints[type]
    }

    /// Add a custom constraint
    ///
    /// To help identify the constraint it's wise to set the `identifier` property on the constraint
    ///
    /// To retrieve the constraint, call `customConstraint(identifier:handler:)` or  `customConstraint(identifier:)`
    ///
    /// Constraint will be activated when you call `activate()`
    ///
    /// - Parameters:
    ///   - identifier: An identifier for the constraint
    ///   - constraint: The constraint you wish to add
    /// - Returns: A reference to the `Pin`
    public func custom(identifier: String, constraint: NSLayoutConstraint) -> Pin {
        assert(state == .inactive, "The pin has already been activated")
        assert(
            customConstraint(withIdentifier: identifier) == nil,
            "A constraint with identifier \(identifier) already exists"
        )

        constraint.identifier = identifier
        customConstraints.append(constraint)
        return self
    }

    /// Add a custom constraint
    ///
    /// To help identify the constraint it's wise to set the `identifier` property on the constraint
    ///
    /// To retrieve the constraint, call `customConstraint(withIdentifier:handler:)` or  `customConstraint(withIdentifier:)`
    ///
    /// Constraint will be activated when you call `activate()`
    ///
    /// - Parameters:
    ///   - identifier: An identifier for the constraint
    ///   - builder: A closure that makes and returns a custom constraint
    /// - Returns: A reference to the `Pin`
    public func custom(identifier: String, builder: () -> NSLayoutConstraint) -> Pin {
        custom(identifier: identifier, constraint: builder())
    }

    /// Request a constraint with the specified `identifier` added via the `custom(identifier:constraint:)` method
    ///
    /// - Parameters:
    ///   - identifier: The constraint identifier
    ///   - handler: A closure that passes the constraint to the caller
    /// - Returns: A reference to the `Pin`
    public func customConstraint(
        withIdentifier identifier: String,
        handler: (NSLayoutConstraint?) -> Void
    ) -> Pin {
        handler(customConstraint(withIdentifier: identifier))
        return self
    }

    /// Request a constraint with the specified `identifier` added via the `custom(identifier:constraint:)` method
    ///
    /// This is useful if you need to modify or customize the constraint at a later time.
    ///
    /// - Parameters:
    ///   - identifier: The constraint identifier
    /// - Returns: The requested constraint
    public func customConstraint(withIdentifier identifier: String) -> NSLayoutConstraint? {
        customConstraints.first(where: { $0.identifier == identifier })
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
    /// - Returns: A reference to the `Pin`
    @discardableResult
    public func activate() -> Pin {
        assert(state == .inactive, "The pin has already been activated")

        NSLayoutConstraint.activate(constraints.values.map { $0 } + customConstraints)
        state = .active
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
    public func activateCustomConstraint(withIdentifier identifier: String) {
        customConstraint(withIdentifier: identifier)?.isActive = true
    }

    /// Deactivate all of the previously specified constraints
    ///
    public func deactivate() {
        assert(state == .active, "The pin has already been activated")

        NSLayoutConstraint.deactivate(constraints.values.map { $0 } + customConstraints)
        state = .inactive
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
    public func deactivateCustomConstraint(withIdentifier identifier: String) {
        customConstraint(withIdentifier: identifier)?.isActive = false
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
        constraints.removeValue(forKey: type)
    }

    /// Remove the specified constraint
    ///
    /// This method does not deactivate the constraint. It only frees it from `Pin` management
    ///
    /// - Parameters:
    ///   - identifier: The constraint identifier
    /// - Returns: The requested constraint
    @discardableResult
    public func removeCustomConstraint(withIdentifier identifier: String) -> NSLayoutConstraint? {
        guard let constraint = customConstraint(withIdentifier: identifier) else {
            return nil
        }
        customConstraints.removeAll(where: { $0 === constraint })
        return constraint
    }

    // MARK: Private vars and constants

    private let primaryItem: Pinnable
    private var relationship: Relationship

    private var constraints: [Constraint: NSLayoutConstraint] = [:]
    private var customConstraints: [NSLayoutConstraint] = []

    // MARK: Private methods

    private func addConstraint(_ key: Constraint, constraint: NSLayoutConstraint) -> Pin {
        assert(state == .inactive, "The pin has already been activated")
        assert(constraints[key] == nil, "A constraint of type \(key) already exists")

        constraints[key] = constraint
        return self
    }

    private func addRelationalConstraint(
        _ key: Constraint,
        block: (Pinnable) -> NSLayoutConstraint
    ) -> Pin {
        switch relationship {
        case .discrete:
            assert(false, "The relionship should be .attached for relational constraints")
        case .relational(let secondaryItem):
            return addConstraint(key, constraint: block(secondaryItem))
        }
    }
}
