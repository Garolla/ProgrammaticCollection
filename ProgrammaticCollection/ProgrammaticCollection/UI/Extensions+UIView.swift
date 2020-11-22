//
//  Extensions+UIView.swift
//  ProgrammaticCollection
//
//  Created by Emanuele Garolla on 22/11/2020.
//

import UIKit

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension CALayer {
    func setShadow(withOpacity opacity: Float = Constants.Shadows.cardShadowOpacity,
                   height y: Int = Constants.Shadows.cardShadowHeight,
                   shadowPath path: CGPath? = nil,
                   andBlur blur: CGFloat = Constants.Shadows.cardShadowBlur) {
        self.masksToBounds = false
        self.shadowOpacity = opacity
        self.shadowRadius = blur / 2.0
        self.shadowColor = UIColor.black.cgColor
        self.shadowOffset = CGSize(width: 0, height: y)
        self.shadowPath = path
    }

    func setShadowAndCornerRadius() {
        self.setShadow()
        self.cornerRadius = Constants.Radius.cardCornerRadius
    }
}
