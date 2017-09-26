//
//  CTView.swift
//  CoreTextMagazine
//
//  Created by plum on 2017/9/26.
//  Copyright © 2017年 plum. All rights reserved.
//

import UIKit
import CoreText

class CTView: UIScrollView {
    
    var imageIndex: Int!
    
    func buidFrames(withAttribute attribu: NSAttributedString ,andImages images: [[String: Any]]) {
        imageIndex = 0
        isPagingEnabled = true
        let framesetter = CTFramesetterCreateWithAttributedString(attribu as CFAttributedString)
        var pageView = UIView()
        var textPos = 0
        var columIndex: CGFloat = 0
        var pageIndex: CGFloat = 0
        let settings = CTSettings()
        
        while textPos < attribu.length {
            if columIndex.truncatingRemainder(dividingBy: settings.columnsPerPage) == 0 {
                columIndex = 0
                pageView = UIView(frame: settings.pageRect.offsetBy(dx: pageIndex * bounds.width, dy: 0))
                pageIndex += 1
                addSubview(pageView)
            }
            let columnXOri = pageView.frame.width / settings.columnsPerPage
            let columnOffset = columIndex * columnXOri
            let columnFrame = settings.columnRect.offsetBy(dx: columnOffset, dy: 0)
            let path = CGMutablePath()
            path.addRect(CGRect(origin: .zero, size: columnFrame.size))
            
            let ctframe = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, nil)
            let columView = CTColumnView(frame: columnFrame, ctframe: ctframe)
            if images.count > imageIndex {
                attachImagesWithFrane(images, cftframe: ctframe, margin: settings.margin, columnView: columView)
            }
            pageView.addSubview(columView)
            let txtRange = CTFrameGetVisibleStringRange(ctframe)
            textPos += txtRange.length
            columIndex += 1
        }
        contentSize = CGSize(width: pageIndex * bounds.width, height: bounds.height)
        
    }
    
    func attachImagesWithFrane(_ images: [[String: Any]], cftframe: CTFrame, margin: CGFloat, columnView: CTColumnView) {
        let lines = CTFrameGetLines(cftframe) as NSArray
        var origins = [CGPoint](repeating: .zero, count: lines.count)
        CTFrameGetLineOrigins(cftframe, CFRangeMake(0, 0), &origins)
        var nextImage = images[imageIndex]
        guard var imgLocation = nextImage["location"] as? Int else {
            return
        }
        for lineIndex in 0..<lines.count {
            let line = lines[lineIndex] as! CTLine
            if let glyphRuns = CTLineGetGlyphRuns(line) as? [CTRun],
                let imageFileName = nextImage["filename"] as? String,
                let img = UIImage(named: imageFileName) {
                for run in glyphRuns {
                    let runRange = CTRunGetStringRange(run)
                    if (runRange.location > imgLocation || runRange.location + runRange.length <= imgLocation) {
                        continue
                    }
                    var imageBounds: CGRect = .zero
                    var ascent: CGFloat = 0
                    imageBounds.size.width = CGFloat(CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, nil, nil))
                    imageBounds.size.height = ascent
                    
                    let xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, nil)
                    imageBounds.origin.x = origins[lineIndex].x + xOffset
                    imageBounds.origin.y = origins[lineIndex].y
                    
                    columnView.images += [(image: img, frame: imageBounds)]
                    imageIndex! += 1
                    if imageIndex < images.count {
                        nextImage = images[imageIndex]
                        imgLocation = (nextImage["location"] as AnyObject).intValue
                    }
                }
            }
        }
    }

}
