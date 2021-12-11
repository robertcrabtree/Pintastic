//
//  Pinnable.swift
//  Pintastic
//
//  Created by Rob on 11/19/21.
//

import Foundation
import UIKit

// MARK: - Type definition

/// Types that conform to `Pinnable` can be constrained using the `Pin` class
///
/// Types that conform to `Pinnable` include:
/// - `UIView`
/// - `UILayoutGuide`
public protocol Pinnable {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }

    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }

    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
}

// MARK: - Convenient extensions

public extension Pinnable {

    /// Use the `pin()` method to apply constraints that aren't in relationship with another item.
    ///
    /// ```
    /// view
    ///     .pin()
    ///     .width(constant: 100)
    ///     .height(constant: 100)
    ///     .activate()
    /// ```
    func pin() -> SinglePin {
        SinglePin(item: self)
    }

    /// Use the `pin(to:)` method to apply constraints in relation to another item.
    ///
    /// The following example pins the edges of the root item to the other item
    /// ```
    /// view
    ///     .pin(to: containerView)
    ///     .pinEdges()
    ///     .activate()
    /// ```
    ///
    /// - Parameter other: The other `Pinnable` item to create a relationship with
    /// - Returns: A reference to the `Pin`
    func pin(to other: Pinnable) -> DoublePin {
        DoublePin(primaryItem: self, secondaryItem: other)
    }
}

// MARK: - Conforming types - you're welcome

extension UIView: Pinnable {}

extension UILayoutGuide: Pinnable {}
