//
//  SinglePin+Constraint.swift
//  Pintastic
//
//  Created by Rob on 12/11/21.
//

import Foundation

public extension SinglePin {

    /// Represents a constraint that can be applied to one or more `Pinnable` items
    enum Constraint: String {

        /// Discrete constraint with a specified width
        case width = "pin.discrete.width"

        /// Discrete constraint with a specified height
        case height = "pin.discrete.height"

        /// Discrete constraint with equal width and height
        case widthEqualToHeight = "pin.discrete.width.height"

        /// Discrete constraint with equal height and width
        case heightEqualToWidth = "pin.discrete.height.width"
    }
}
