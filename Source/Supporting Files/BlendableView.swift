//
//  BlendableView.swift
//  FAAlertController
//
//  Created by Jesse Cox on 11/1/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit


/// An empty protocol that allows a conforming `UIView` to be blended with another view.
///
/// The protocol itself declares no properties or methods, but has been extended to allow conforming `UIView`s to be blended with another view.
protocol Blendable: class {}
extension Blendable where Self: UIView {
    
    /// Renders the portion of the target view beneath `Self` into the current graphics context.
    ///
    /// - parameter rect:    The portion of the targets bounds to render into the current graphics context.
    /// - parameter target:  The `UIView` to draw into the current graphics context.
    /// - parameter context: The `CGContext` to use when rendering the target view.
    /// - parameter quality: The `CGInterpolationQuality` to use when rendering the target view.
    func blend(_ rect: CGRect, of target: UIView?, in context: CGContext, quality: CGInterpolationQuality) {
        guard let target = target else {
            print("The value for target is nil.")
            return
        }
        context.saveGState()
        context.interpolationQuality = quality
        let origin = convert(rect, to: target).origin
        context.translateBy(x: 0 - origin.x, y: 0 - origin.y)
        target.layer.render(in: context)
        context.restoreGState()
    }
    
}

/// A `UIView` subclass that allows for blend modes.
@IBDesignable
class BlendableView: UIView, Blendable {
    
    /// The view that will be blended with `Self`.
    var target: UIView?
    
    /// The blend mode to use when `Self` is drawn.
    var blendMode: CGBlendMode = .normal

    
    convenience init(frame: CGRect, target: UIView?, blendMode: CGBlendMode) {
        self.init(frame: frame)
        self.target = target
        self.blendMode = blendMode
    }
    
    /// Subclasses should call `super.draw(_ rect: CGRect)` to render the target view into the graphics context.
    override func draw(_ rect: CGRect) {
        blend(rect, of: target, in: UIGraphicsGetCurrentContext()!, quality: .none)
    }
    
}

