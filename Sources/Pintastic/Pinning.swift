////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 Robert Crabtree
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import Foundation
import UIKit

/// A protocol that defines an interface for manipulating constraints such as add, remove, find, activate, and deactivate.
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
    /// - Returns: A reference to the `Pinning` instance
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
    /// - Returns: A reference to the `Pinning` instance
    func addConstraint(withIdentifier identifier: String, constraint: () -> NSLayoutConstraint) -> Self

    /// Request a constraint of the specified type
    ///
    /// This is useful if you need to customize the constraint
    ///
    /// - Parameters:
    ///   - type: The type of constraint
    ///   - handler: A closure that passes the constraint to the caller
    /// - Returns: A reference to the `Pinning` instance
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
    /// - Returns: A reference to the `Pinning` instance
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
    ///     .pinEdges()
    ///     .activate()
    /// ```
    ///
    /// - Returns: A reference to the `Pinning` instance
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
    /// This method does not deactivate the constraint. It only frees it from `Pinning` management
    ///
    /// - Parameters:
    ///   - type: The constraint type
    /// - Returns: The requested constraint
    @discardableResult
    func removeConstraint(ofType type: Constraint) -> NSLayoutConstraint?

    /// Remove the specified constraint
    ///
    /// This method does not deactivate the constraint. It only frees it from `Pinning` management
    ///
    /// - Parameters:
    ///   - identifier: The constraint identifier
    /// - Returns: The requested constraint
    @discardableResult
    func removeConstraint(withIdentifier identifier: String) -> NSLayoutConstraint?

}
