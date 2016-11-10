//
//  Extensions.swift
//  FAAlertController
//
//  Created by Jesse Cox on 10/23/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func image(fromView view: UIView, croppedToRect rect: CGRect?) -> UIImage {
        let scaleFactor = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, scaleFactor)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        if let rect = rect {
            let scaledRect = rect.applying(CGAffineTransform(scaleX: scaleFactor , y: scaleFactor))
            if let imageRef = image.cgImage?.cropping(to: scaledRect) {
                image = UIImage(cgImage: imageRef)
            }
        }
        return image
    }
    
}
