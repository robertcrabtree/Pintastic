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
        case leadingEdges = "pin.leading.leading"

        /// Relational constraint with trailing edges pinned
        case trailingEdges = "pin.trailing.trailing"

        /// Relational constraint with top edges pinned
        case topEdges = "pin.top.top"

        /// Relational constraint with bottom edges pinned
        case bottomEdges = "pin.bottom.bottom"

        /// Relational constraint with bottom edge of primary item pinned to top edge of second item
        case bottomToTopEdge = "pin.bottom.top"

        /// Relational constraint with top edge of primary item pinned to bottom edge of second item
        case topToBottomEdge = "pin.top.bottom"

        /// Relational constraint with leading edge of primary item pinned to trailing edge of second item
        case leadingToTrailingEdge = "pin.leading.trailing"

        /// Relational constraint with trailing edge of primary item pinned to leading edge of second item
        case trailingToLeadingEdge = "pin.trailing.leading"

        /// Relational constraint with horizontal centers pinned
        case horizontalCenters = "pin.hcenter.hcenter"

        /// Relational constraint with vertical centers pinned
        case verticalCenters = "pin.vcenter.vcenter"

        /// Discreet constraint with a specified width
        case width = "pin.width"

        /// Discreet constraint with a specified height
        case height = "pin.height"

        /// Relational constraint with equal widths
        case equalWidths = "pin.width.width"

        /// Relational constraint with equal heights
        case equalHeights = "pin.height.height"

        /// Relational constraint with leading edge of primary item constrained to horizontal center of second item
        case leadingEdgeToCenter = "pin.leading.hcenter"

        /// Relational constraint with trailing edge of primary item constrained to horizontal center of second item
        case trailingEdgeToCenter = "pin.trailing.hcenter"

        /// Relational constraint with top edge of primary item constrained to vertical center of second item
        case topEdgeToCenter = "pin.top.vcenter"

        /// Relational constraint with bottom edge of primary item constrained to vertical center of second item
        case bottomEdgeToCenter = "pin.bottom.vcenter"
    }
}
