//
//  Pinning.swift
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
///
public protocol Pinning: AnyObject {

    associatedtype Constraint: RawRepresentable where Constraint.RawValue == String

    var constraints: [String: NSLayoutConstraint] { get set }


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
    func addConstraint(withIdentifier identifier: String, constraint: NSLayoutConstraint) -> Self

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
    func addConstraint(withIdentifier identifier: String, constraint: () -> NSLayoutConstraint) -> Self

    /// Request a constraint of the specified type
    ///
    /// This is useful if you need to customize the constraint
    ///
    /// - Parameters:
    ///   - type: The type of constraint
    ///   - handler: A closure that passes the constraint to the caller
    /// - Returns: A reference to the `Pin`
    func constraint(
        ofType type: Constraint,
        handler: (NSLayoutConstraint?) -> Void
    ) -> Self

    /// Request a constraint of the specified type
    ///
    /// This is useful if you need to modify or customize the constraint at a later time.
    ///
    /// - Parameters:
    ///   - type: The type of constraint
    /// - Returns: The requested constraint
    func constraint(ofType type: Constraint) -> NSLayoutConstraint?

    /// Request a constraint with the specified `identifier` added via the `addConstraint(withIdentifier:constraint:)` method
    ///
    /// - Parameters:
    ///   - identifier: The constraint identifier
    ///   - handler: A closure that passes the constraint to the caller
    /// - Returns: A reference to the `Pin`
    func constraint(
        withIdentifier identifier: String,
        handler: (NSLayoutConstraint?) -> Void
    ) -> Self

    /// Request a constraint with the specified `identifier` added via the `addConstraint(withIdentifier:constraint:)` method
    ///
    /// This is useful if you need to modify or customize the constraint at a later time.
    ///
    /// - Parameters:
    ///   - identifier: The constraint identifier
    /// - Returns: The requested constraint
    func constraint(withIdentifier identifier: String) -> NSLayoutConstraint?

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
    func activate() -> Self

    /// Activate the specified constraint
    ///
    /// - Parameters:
    ///   - type: The constraint type
    func activateConstraint(ofType type: Constraint)

    /// Activate the specified constraint
    ///
    /// - Parameters:
    ///   - identifier: The constraint identifier
    func activateConstraint(withIdentifier identifier: String)

    /// Deactivate all constraints
    ///
    func deactivate()

    /// Deactivate the specified constraint
    ///
    /// This call does not remove the constraint. To remove the constraint call `removeConstraint(constraint:)`
    ///
    /// - Parameters:
    ///   - type: The constraint type
    func deactivateConstraint(ofType type: Constraint)

    /// Deactivate the specified constraint
    ///
    /// This call does not remove the constraint. To remove the constraint call `removeConstraint(identifier:)`
    ///
    /// - Parameters:
    ///   - identifier: The constraint identifier
    func deactivateConstraint(withIdentifier identifier: String)

    /// Remove the specified constraint
    ///
    /// This method does not deactivate the constraint. It only frees it from `Pin` management
    ///
    /// - Parameters:
    ///   - type: The constraint type
    /// - Returns: The requested constraint
    @discardableResult
    func removeConstraint(ofType type: Constraint) -> NSLayoutConstraint?

    /// Remove the specified constraint
    ///
    /// This method does not deactivate the constraint. It only frees it from `Pin` management
    ///
    /// - Parameters:
    ///   - identifier: The constraint identifier
    /// - Returns: The requested constraint
    @discardableResult
    func removeConstraint(withIdentifier identifier: String) -> NSLayoutConstraint?

}

public extension Pinning {

    func addConstraint(withIdentifier identifier: String, constraint: NSLayoutConstraint) -> Self {
        assert(constraints[identifier] == nil, "A constraint identifier \(identifier) already exists")
        constraint.identifier = identifier
        constraints[identifier] = constraint
        return self
    }

    func addConstraint(withIdentifier identifier: String, constraint: () -> NSLayoutConstraint) -> Self {
        addConstraint(withIdentifier: identifier, constraint: constraint())
    }

    func constraint(
        ofType type: Constraint,
        handler: (NSLayoutConstraint?) -> Void
    ) -> Self {
        constraint(withIdentifier: type.rawValue, handler: handler)
    }

    func constraint(ofType type: Constraint) -> NSLayoutConstraint? {
        constraint(withIdentifier: type.rawValue)
    }

    func constraint(
        withIdentifier identifier: String,
        handler: (NSLayoutConstraint?) -> Void
    ) -> Self {
        handler(constraint(withIdentifier: identifier))
        return self
    }

    func constraint(withIdentifier identifier: String) -> NSLayoutConstraint? {
        constraints[identifier]
    }

    @discardableResult
    func activate() -> Self {
        NSLayoutConstraint.activate(constraints.values.map { $0 })
        return self
    }

    func activateConstraint(ofType type: Constraint) {
        self.constraint(ofType: type)?.isActive = true
    }

    func activateConstraint(withIdentifier identifier: String) {
        constraint(withIdentifier: identifier)?.isActive = true
    }

    func deactivate() {
        NSLayoutConstraint.deactivate(constraints.values.map { $0 })
    }

    func deactivateConstraint(ofType type: Constraint) {
        constraint(ofType: type)?.isActive = false
    }

    func deactivateConstraint(withIdentifier identifier: String) {
        constraint(withIdentifier: identifier)?.isActive = false
    }

    @discardableResult
    func removeConstraint(ofType type: Constraint) -> NSLayoutConstraint? {
        removeConstraint(withIdentifier: type.rawValue)
    }

    @discardableResult
    func removeConstraint(withIdentifier identifier: String) -> NSLayoutConstraint? {
        constraints.removeValue(forKey: identifier)
    }
}
