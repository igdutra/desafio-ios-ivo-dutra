//
//  UIImage+Extension.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 13/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

extension UIImage {
    struct Default {
        static let photoPlaceholder = UIImage(named: "placeholder")
    }

    /// Using view.layer.cornerRadius turns only background (the layer) with cornerRadius. An image from imageView needs to be also drawn with this.
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
       let maxRadius = min(size.width, size.height) / 2
       let cornerRadius: CGFloat

       if let radius = radius, radius > 0 && radius <= maxRadius {
           cornerRadius = radius
       } else {
           cornerRadius = maxRadius
       }

       UIGraphicsBeginImageContextWithOptions(size, false, scale)
       let rect = CGRect(origin: .zero, size: size)
       UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
       draw(in: rect)
       let image = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       return image
    }

    /// Calculate image correct size, based on device width
    func resizedImage(toFitIn width: CGFloat) -> UIImage {

        // Calculate resize ratio based on the device width (-16 to leading and trailing anchors from CharachtersTableViewCell)
        let resizeRatio = (width - 16) / self.size.width

        // Apply same ratio to both dimensions, in order to respect its aspect Ratio
        let size = self.size.applying(CGAffineTransform(scaleX: resizeRatio, y: resizeRatio))
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen

        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.draw(in: CGRect(origin: .zero, size: size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage?.withRoundedCorners(radius: 12) ?? UIImage()
    }
}
