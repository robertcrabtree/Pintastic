//
//  Test+Pin.swift
//  Pintastic
//
//  Created by Rob on 11/19/21.
//

import XCTest
import UIKit
@testable import Pintastic

class Test_Pin: XCTestCase {

    let parent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let sibling1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let sibling2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func setUpWithError() throws {
        parent.addSubview(sibling1)
        parent.addSubview(sibling2)
    }

    override func tearDownWithError() throws {
        sibling1.removeFromSuperview()
        sibling2.removeFromSuperview()
    }

    func testEdges() throws {
        let pin = sibling1
            .pin(to: parent)
            .edges()
            .activate()

        XCTAssertEqual(pin.constraint(ofType: .leadingEdges)?.firstAttribute, .leading)
        XCTAssertEqual(pin.constraint(ofType: .trailingEdges)?.firstAttribute, .trailing)
        XCTAssertEqual(pin.constraint(ofType: .topEdges)?.firstAttribute, .top)
        XCTAssertEqual(pin.constraint(ofType: .bottomEdges)?.firstAttribute, .bottom)
    }

    func testLeading() throws {
        let pin = sibling1
            .pin(to: parent)
            .leadingEdges(constant: 20)
            .activate()

        guard let constraint = pin.constraint(ofType: .leadingEdges) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.constant, 20)
    }

    func testTrailing() throws {
        let pin = sibling1
            .pin(to: parent)
            .trailingEdges(constant: -20)
            .activate()

        guard let constraint = pin.constraint(ofType: .trailingEdges) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.constant, -20)
    }

    func testTops() throws {
        let pin = sibling1
            .pin(to: parent)
            .topEdges(constant: 20)
            .activate()

        guard let constraint = pin.constraint(ofType: .topEdges) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.constant, 20)
    }

    func testBottoms() throws {
        let pin = sibling1
            .pin(to: parent)
            .bottomEdges(constant: -20)
            .activate()

        guard let constraint = pin.constraint(ofType: .bottomEdges) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.constant, -20)
    }

    func testBefore() throws {
        let pin = sibling1
            .pin(to: sibling2)
            .before(constant: 20)
            .activate()

        guard let constraint = pin.constraint(ofType: .before) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.firstAttribute, .trailing)
        XCTAssertEqual(constraint.secondAttribute, .leading)
        XCTAssertEqual(constraint.constant, 20)
    }

    func testAfter() throws {
        let pin = sibling1
            .pin(to: sibling2)
            .after(constant: -20)
            .activate()

        guard let constraint = pin.constraint(ofType: .after) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .trailing)
        XCTAssertEqual(constraint.constant, -20)
    }

    func testAbove() throws {
        let pin = sibling1
            .pin(to: sibling2)
            .above(constant: -20)
            .activate()

        guard let constraint = pin.constraint(ofType: .above) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.firstAttribute, .bottom)
        XCTAssertEqual(constraint.secondAttribute, .top)
        XCTAssertEqual(constraint.constant, -20)
    }

    func testBelow() throws {
        let pin = sibling1
            .pin(to: sibling2)
            .below(constant: 20)
            .activate()

        guard let constraint = pin.constraint(ofType: .below) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.firstAttribute, .top)
        XCTAssertEqual(constraint.secondAttribute, .bottom)
        XCTAssertEqual(constraint.constant, 20)
    }

    func testCenters() throws {
        let pin = sibling1
            .pin(to: parent)
            .centers()
            .activate()

        guard let horizontal = pin.constraint(ofType: .horizontalCenters) else {
            return XCTFail()
        }
        guard let vertical = pin.constraint(ofType: .verticalCenters) else {
            return XCTFail()
        }

        XCTAssertTrue(horizontal.isActive)
        XCTAssertTrue(vertical.isActive)
        XCTAssertEqual(horizontal.firstAttribute, .centerX)
        XCTAssertEqual(vertical.firstAttribute, .centerY)
    }

    func testCenterX() throws {
        let pin = sibling1
            .pin(to: parent)
            .horizontalCenters()
            .activate()

        guard let constraint = pin.constraint(ofType: .horizontalCenters) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.firstAttribute, .centerX)
    }

    func testCenterY() throws {
        let pin = sibling1
            .pin(to: parent)
            .verticalCenters()
            .activate()

        guard let constraint = pin.constraint(ofType: .verticalCenters) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.firstAttribute, .centerY)
    }

    func testWidth() throws {
        let pin = sibling1
            .pin()
            .width(constant: 100)
            .activate()

        guard let constraint = pin.constraint(ofType: .width) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.constant, 100)
    }

    func testHeight() throws {
        let pin = sibling1
            .pin()
            .height(constant: 100)
            .activate()

        guard let constraint = pin.constraint(ofType: .height) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.constant, 100)
    }

    func testSameWidthAndHeight() throws {
        let pin = sibling1
            .pin()
            .height(constant: 100)
            .widthEqualToHeight(multiplier: 0.5)
            .activate()

        guard let constraint = pin.constraint(ofType: .widthEqualToHeight) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .height)
        XCTAssertEqual(constraint.multiplier, 0.5)
    }

    func testSameHeightAndWidth() throws {
        let pin = sibling1
            .pin()
            .width(constant: 100)
            .heightEqualToWidth(multiplier: 0.5)
            .activate()

        guard let constraint = pin.constraint(ofType: .heightEqualToWidth) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .width)
        XCTAssertEqual(constraint.multiplier, 0.5)
    }

    func testWidths() throws {
        let pin = sibling1
            .pin(to: sibling2)
            .equalWidths(multiplier: 0.8)
            .activate()

        guard let constraint = pin.constraint(ofType: .equalWidths) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .width)
        XCTAssertGreaterThan(constraint.multiplier, CGFloat(0.79))
        XCTAssertLessThan(constraint.multiplier, CGFloat(0.81))
    }

    func testHeights() throws {
        let pin = sibling1
            .pin(to: sibling2)
            .equalHeights(multiplier: 0.8)
            .activate()

        guard let constraint = pin.constraint(ofType: .equalHeights) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.firstAttribute, .height)
        XCTAssertEqual(constraint.secondAttribute, .height)
        XCTAssertGreaterThan(constraint.multiplier, CGFloat(0.79))
        XCTAssertLessThan(constraint.multiplier, CGFloat(0.81))
    }

    func testLeadingToCenter() throws {
        let pin = sibling1
            .pin(to: parent)
            .leadingEdgeToHorizontalCenter(constant: 20)
            .activate()

        guard let constraint = pin.constraint(ofType: .leadingToHorizontalCenter) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.firstAttribute, .leading)
        XCTAssertEqual(constraint.secondAttribute, .centerX)
        XCTAssertEqual(constraint.constant, 20)
    }

    func testTrailingToCenter() throws {
        let pin = sibling1
            .pin(to: parent)
            .trailingEdgeToHorizontalCenter(constant: -20)
            .activate()

        guard let constraint = pin.constraint(ofType: .trailingToHorizontalCenter) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.firstAttribute, .trailing)
        XCTAssertEqual(constraint.secondAttribute, .centerX)
        XCTAssertEqual(constraint.constant, -20)
    }

    func testTopToCenter() throws {
        let pin = sibling1
            .pin(to: parent)
            .topEdgeToVerticalCenter(constant: 20)
            .activate()

        guard let constraint = pin.constraint(ofType: .topToVerticalCenter) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.firstAttribute, .top)
        XCTAssertEqual(constraint.secondAttribute, .centerY)
        XCTAssertEqual(constraint.constant, 20)
    }

    func testBottomToCenter() throws {
        let pin = sibling1
            .pin(to: parent)
            .bottomEdgeToVerticalCenter(constant: -20)
            .activate()

        guard let constraint = pin.constraint(ofType: .bottomToVerticalCenter) else {
            return XCTFail()
        }

        XCTAssertTrue(constraint.isActive)
        XCTAssertEqual(constraint.firstAttribute, .bottom)
        XCTAssertEqual(constraint.secondAttribute, .centerY)
        XCTAssertEqual(constraint.constant, -20)
    }

    func testConstraintCallback() throws {

        var leading: NSLayoutConstraint?
        var trailing: NSLayoutConstraint?
        var tops: NSLayoutConstraint?
        var bottoms: NSLayoutConstraint?

        sibling1
            .pin(to: parent)
            .edges()
            .constraint(ofType: .leadingEdges, handler: { constraint in
                leading = constraint
            })
            .constraint(ofType: .trailingEdges, handler: { constraint in
                trailing = constraint
            })
            .constraint(ofType: .topEdges, handler: { constraint in
                tops = constraint
            })
            .constraint(ofType: .bottomEdges, handler: { constraint in
                bottoms = constraint
            })
            .activate()

        XCTAssertEqual(leading?.firstAttribute, .leading)
        XCTAssertEqual(trailing?.firstAttribute, .trailing)
        XCTAssertEqual(tops?.firstAttribute, .top)
        XCTAssertEqual(bottoms?.firstAttribute, .bottom)

        XCTAssertTrue(leading?.isActive == true)
        XCTAssertTrue(trailing?.isActive == true)
        XCTAssertTrue(tops?.isActive == true)
        XCTAssertTrue(bottoms?.isActive == true)
    }

    func testSafeArea() throws {
        let pin = sibling1
            .pin(to: parent.safeAreaLayoutGuide)
            .edges()
            .activate()

        XCTAssertEqual(pin.constraint(ofType: .leadingEdges)?.firstAttribute, .leading)
        XCTAssertEqual(pin.constraint(ofType: .trailingEdges)?.firstAttribute, .trailing)
        XCTAssertEqual(pin.constraint(ofType: .topEdges)?.firstAttribute, .top)
        XCTAssertEqual(pin.constraint(ofType: .bottomEdges)?.firstAttribute, .bottom)
    }

    func testCustomConstraint() throws {
        let pin = sibling1
            .pin()
            .addConstraint(
                withIdentifier: "sibling1.width",
                constraint: .width(forPinnableItem: sibling1)
            )
            .addConstraint(
                withIdentifier: "sibling1.height",
                constraint: {
                    .height(forPinnableItem: sibling1)
                }
            )
            .activate()

        guard let width = pin.constraint(withIdentifier: "sibling1.width") else {
            return XCTFail()
        }

        guard let height = pin.constraint(withIdentifier: "sibling1.height") else {
            return XCTFail()
        }

        XCTAssertTrue(width.isActive)
        XCTAssertEqual(width.constant, 50.0)
        XCTAssertEqual(width.firstAttribute, .width)
        XCTAssertEqual(width.identifier, "sibling1.width")

        XCTAssertTrue(height.isActive)
        XCTAssertEqual(height.constant, 50.0)
        XCTAssertEqual(height.firstAttribute, .height)
        XCTAssertEqual(height.identifier, "sibling1.height")
    }

    func testActivate() throws {
        let pin = sibling1
            .pin(to: parent.safeAreaLayoutGuide)
            .leadingEdges()
            .addConstraint(withIdentifier: "sibling1.height", constraint: {
                .height(forPinnableItem: sibling1)
            })
            .activate()

        XCTAssertEqual(pin.constraint(ofType: .leadingEdges)?.isActive, true)
        XCTAssertEqual(pin.constraint(withIdentifier: "sibling1.height")?.isActive, true)
    }

    func testActivateConstraint() throws {
        let pin = sibling1
            .pin(to: parent.safeAreaLayoutGuide)
            .leadingEdges()
            .addConstraint(withIdentifier: "sibling1.height", constraint: {
                .height(forPinnableItem: sibling1)
            })
            .activate()

        pin.deactivateConstraint(ofType: .leadingEdges)
        pin.deactivateConstraint(withIdentifier: "sibling1.height")
        XCTAssertEqual(pin.constraint(ofType: .leadingEdges)?.isActive, false)
        XCTAssertEqual(pin.constraint(withIdentifier: "sibling1.height")?.isActive, false)

        pin.activateConstraint(ofType: .leadingEdges)
        pin.activateConstraint(withIdentifier: "sibling1.height")
        XCTAssertEqual(pin.constraint(ofType: .leadingEdges)?.isActive, true)
        XCTAssertEqual(pin.constraint(withIdentifier: "sibling1.height")?.isActive, true)
    }

    func testDeactivate() throws {
        let pin = sibling1
            .pin(to: parent.safeAreaLayoutGuide)
            .leadingEdges()
            .addConstraint(withIdentifier: "sibling1.height", constraint: {
                .height(forPinnableItem: sibling1)
            })
            .activate()

        pin.deactivate()
        XCTAssertEqual(pin.constraint(ofType: .leadingEdges)?.isActive, false)
        XCTAssertEqual(pin.constraint(withIdentifier: "sibling1.height")?.isActive, false)
    }

    func testDeactivateConstraint() throws {
        let pin = sibling1
            .pin(to: parent.safeAreaLayoutGuide)
            .leadingEdges()
            .addConstraint(withIdentifier: "sibling1.height", constraint: {
                .height(forPinnableItem: sibling1)
            })
            .activate()

        pin.deactivateConstraint(ofType: .leadingEdges)
        pin.deactivateConstraint(withIdentifier: "sibling1.height")
        XCTAssertEqual(pin.constraint(ofType: .leadingEdges)?.isActive, false)
        XCTAssertEqual(pin.constraint(withIdentifier: "sibling1.height")?.isActive, false)
    }

    func testRemoveConstraint() throws {
        let pin = sibling1
            .pin(to: parent.safeAreaLayoutGuide)
            .leadingEdges()
            .addConstraint(withIdentifier: "sibling1.height", constraint: {
                .height(forPinnableItem: sibling1)
            })
            .activate()

        let leading = pin.removeConstraint(ofType: .leadingEdges)
        let height = pin.removeConstraint(withIdentifier: "sibling1.height")
        XCTAssertEqual(leading?.isActive, true)
        XCTAssertEqual(height?.isActive, true)
        XCTAssertNil(pin.constraint(ofType: .leadingEdges))
        XCTAssertNil(pin.constraint(withIdentifier: "sibling1.height"))
    }

    func testIdentifiers() throws {
        let pin = sibling1
            .pin(to: parent.safeAreaLayoutGuide)
            .leadingEdges()
            .addConstraint(withIdentifier: "sibling1.height", constraint: {
                .height(forPinnableItem: sibling1)
            })
            .activate()

        let leadingByType = pin.constraint(ofType: .leadingEdges)
        let leadingByIdentifier = pin.constraint(withIdentifier: DoublePin.Constraint.leadingEdges.rawValue)
        let heightByIdentifier = pin.constraint(withIdentifier: "sibling1.height")

        XCTAssertEqual(leadingByType?.identifier, DoublePin.Constraint.leadingEdges.rawValue)
        XCTAssertEqual(leadingByIdentifier?.identifier, DoublePin.Constraint.leadingEdges.rawValue)
        XCTAssertEqual(heightByIdentifier?.identifier, "sibling1.height")
    }
}

private extension NSLayoutConstraint {

    static func width(forPinnableItem item: Any) -> NSLayoutConstraint {
        NSLayoutConstraint(
            item: item,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 50.0
        )
    }

    static func height(forPinnableItem item: Any) -> NSLayoutConstraint {
        NSLayoutConstraint(
            item: item,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 50.0
        )
    }
}
