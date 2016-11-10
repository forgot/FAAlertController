//
//  HighlightView.swift
//  FAAlertController
//
//  Created by Jesse Cox on 11/4/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit

class HighlightView: UIView {
    
    var image: UIImage?
    
    init(frame: CGRect, image: UIImage?) {
        super.init(frame: frame)
        self.image = image
        isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard image != nil else {
            print("There is no image to draw")
            return
        }
        let context = UIGraphicsGetCurrentContext()!
        context.interpolationQuality = .high
        
        image!.draw(in: rect, blendMode: .normal, alpha: 1.0)
        context.saveGState()
        
        let path1 = UIBezierPath(rect: rect)
        context.setBlendMode(.colorBurn)
        UIColor(white: 0.6, alpha: 1.0).setFill()
        path1.fill()
        
        let path2 = UIBezierPath(rect: rect)
        context.setBlendMode(.plusDarker)
        UIColor(white: 0.0, alpha: 0.04).setFill()
        path2.fill()
        
        context.restoreGState()
    }
    
}
