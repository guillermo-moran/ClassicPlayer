//
//  LargerHitAreaButton.swift
//  ClassicPlayer
//
//  Created by Guillermo M on 12/26/25.
//  Copyright © 2025 Guillermo Moran. All rights reserved.
//


import UIKit

@IBDesignable
class LargerHitAreaButton: UIButton {

    // Negative values expand the tappable area beyond the button’s bounds
    @IBInspectable var hitTestTopInset: CGFloat = -12
    @IBInspectable var hitTestLeftInset: CGFloat = -12
    @IBInspectable var hitTestBottomInset: CGFloat = -12
    @IBInspectable var hitTestRightInset: CGFloat = -12

    // Ensure a minimum hit area (Apple HIG suggests 44x44 points)
    @IBInspectable var minimumHitWidth: CGFloat = 44
    @IBInspectable var minimumHitHeight: CGFloat = 44

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var hitFrame = bounds

        // Expand to minimum recommended size if needed
        let widthToAdd = max(0, minimumHitWidth - hitFrame.width)
        let heightToAdd = max(0, minimumHitHeight - hitFrame.height)
        hitFrame = hitFrame.insetBy(dx: -widthToAdd/2, dy: -heightToAdd/2)

        // Apply custom per-edge insets (negative expands)
        hitFrame = UIEdgeInsetsInsetRect(hitFrame, UIEdgeInsets(top: hitTestTopInset,
                                                                left: hitTestLeftInset,
                                                                bottom: hitTestBottomInset,
                                                                right: hitTestRightInset))
        return hitFrame.contains(point)
    }
}
