//
//  File.swift
//  
//
//  Created by Rob on 12/11/21.
//

import Foundation
import UIKit

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
