//
//  Pin+Constraint.swift
//  Pintastic
//
//  Created by Rob on 11/20/21.
//

import Foundation

public extension Pin {

    /// Represents a constraint that can be applied to one or more `Pinnable` items
    enum Constraint: String {

        /// Relational constraint with leading edges pinned
        case leadingEdges = "pin.relational.leading.leading"

        /// Relational constraint with trailing edges pinned
        case trailingEdges = "pin.relational.trailing.trailing"

        /// Relational constraint with top edges pinned
        case topEdges = "pin.relational.top.top"

        /// Relational constraint with bottom edges pinned
        case bottomEdges = "pin.relational.bottom.bottom"

        /// Relational constraint with bottom edge of primary item pinned to top edge of second item
        case bottomToTopEdge = "pin.relational.bottom.top"

        /// Relational constraint with top edge of primary item pinned to bottom edge of second item
        case topToBottomEdge = "pin.relational.top.bottom"

        /// Relational constraint with leading edge of primary item pinned to trailing edge of second item
        case leadingToTrailingEdge = "pin.relational.leading.trailing"

        /// Relational constraint with trailing edge of primary item pinned to leading edge of second item
        case trailingToLeadingEdge = "pin.relational.trailing.leading"

        /// Relational constraint with horizontal centers pinned
        case horizontalCenters = "pin.relational.hcenter.hcenter"

        /// Relational constraint with vertical centers pinned
        case verticalCenters = "pin.relational.vcenter.vcenter"

        /// Discrete constraint with a specified width
        case width = "pin.discrete.width"

        /// Discrete constraint with a specified height
        case height = "pin.discrete.height"

        /// Discrete constraint with equal width and height
        case sameWidthAndHeight = "pin.discrete.width.height"

        /// Discrete constraint with equal height and width
        case sameHeightAndWidth = "pin.discrete.height.width"

        /// Relational constraint with equal widths
        case equalWidths = "pin.relational.width.width"

        /// Relational constraint with equal heights
        case equalHeights = "pin.relational.height.height"

        /// Relational constraint with leading edge of primary item constrained to horizontal center of second item
        case leadingEdgeToCenter = "pin.relational.leading.hcenter"

        /// Relational constraint with trailing edge of primary item constrained to horizontal center of second item
        case trailingEdgeToCenter = "pin.relational.trailing.hcenter"

        /// Relational constraint with top edge of primary item constrained to vertical center of second item
        case topEdgeToCenter = "pin.relational.top.vcenter"

        /// Relational constraint with bottom edge of primary item constrained to vertical center of second item
        case bottomEdgeToCenter = "pin.relational.bottom.vcenter"
    }
}
