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
