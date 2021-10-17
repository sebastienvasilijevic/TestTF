//
//  NSLayoutDimension+Extensions.swift
//  TestTheFork
//
//  Created by VASILIJEVIC Sebastien on 17/10/2021.
//

import UIKit

extension NSLayoutDimension {
    public func constraintPriority999(equalToConstant constant: CGFloat) -> NSLayoutConstraint {
        let constraint = self.constraint(equalToConstant: constant)
        constraint.priority = .init(999)
        return constraint
    }
}
