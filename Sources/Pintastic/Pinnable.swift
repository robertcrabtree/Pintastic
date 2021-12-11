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

// MARK: - Type definition

/// Types that conform to `Pinnable` can be constrained using the `SingleItemPin` or `MultiItemPin` classes.
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

    /// Use the `makePin()` method to apply trivial constraints to an item such as width and height constraints.
    ///
    /// ```
    /// view
    ///     .makePin()
    ///     .pinWidth(constant: 100)
    ///     .pinHeight(constant: 100)
    ///     .activate()
    /// ```
    ///
    /// - Returns: A reference to the `SingleItemPin`
    func makePin() -> SingleItemPin {
        SingleItemPin(item: self)
    }

    /// Use the `makePin(to:)` method to apply constraints in relation to another item.
    ///
    /// The following example pins the edges of the receiver to another item
    /// ```
    /// view
    ///     .makePin(to: containerView)
    ///     .pinEdges()
    ///     .activate()
    /// ```
    ///
    /// - Parameter other: The other `Pinnable` item to create a relationship with
    /// - Returns: A reference to the `MultiItemPin`
    func makePin(to other: Pinnable) -> MultiItemPin {
        MultiItemPin(primaryItem: self, secondaryItem: other)
    }
}

// MARK: - Conforming types - you're welcome

extension UIView: Pinnable {}

extension UILayoutGuide: Pinnable {}
