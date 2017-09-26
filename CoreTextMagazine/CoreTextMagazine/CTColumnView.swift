//
//  CTFrameView.swift
//  CoreTextMagazine
//
//  Created by plum on 2017/9/26.
//  Copyright © 2017年 plum. All rights reserved.
//

import UIKit

class CTColumnView: UIView {
    
    var ctfame: CTFrame!
    var images: [(image: UIImage, frame: CGRect)] = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
     init(frame: CGRect, ctframe: CTFrame) {
        super.init(frame: frame)
        self.ctfame = ctframe;
        self.backgroundColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.textMatrix = .identity
        context.translateBy(x: 0, y: rect.size.height)
        context.scaleBy(x: 1, y: -1)
        CTFrameDraw(ctfame, context)
        
        for imageData in images {
            if let image = imageData.image.cgImage {
                let imageBounds = imageData.frame
                context.draw(image, in: imageBounds)
            }
        }
    }
    


}
