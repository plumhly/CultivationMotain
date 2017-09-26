//
//  MarkupParse.swift
//  CoreTextMagazine
//
//  Created by plum on 2017/9/26.
//  Copyright © 2017年 plum. All rights reserved.
//

import UIKit

class MarkupParse: NSObject {
    //MARK: - property
    var color: UIColor = .black
    var fontName: String = "Arial"
    var attributeString: NSMutableAttributedString!
    var images:[[String:Any]] = []
    
    override init() {
        super.init()
    }
    
    func parseMarkup(_ markup: String) {
        attributeString = NSMutableAttributedString(string: "")
        do {
            let regex = try NSRegularExpression(pattern: "(.*?)(<[^>]+>|\\z)", options: [.caseInsensitive, .dotMatchesLineSeparators])
            let chunks = regex.matches(in: markup, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, markup.characters.count))
            
            let defaultFont: UIFont = .systemFont(ofSize: UIScreen.main.bounds.size.height / 40)
            
            for chunk in chunks {
                guard let markupRange = markup.range(from: chunk.range) else {continue}
                let parts = markup[markupRange].components(separatedBy: "<")
                let font = UIFont(name: fontName, size: UIScreen.main.bounds.size.height / 40) ?? defaultFont
                let attrs = [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font] as [NSAttributedStringKey : Any]
                let text = NSMutableAttributedString(string: parts[0], attributes: attrs)
                attributeString.append(text)
                
                if parts.count <= 1 {
                    continue
                }
                let tag = parts[1]
                
                if tag.hasPrefix("font") {
                    let colorRegex = try NSRegularExpression(pattern: "(?<=color=\")\\w+", options: NSRegularExpression.Options(rawValue: 0))
                    colorRegex.enumerateMatches(in: tag, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, tag.characters.count), using: { (match, _, _) in
                        
                        if let match = match, let range = tag.range(from: match.range) {
                            let colorSel = NSSelectorFromString(tag[range]+"Color")
                            color = UIColor.perform(colorSel).takeRetainedValue() as? UIColor ?? .black
                        }
                    })
                    
                    let faceRegex = try NSRegularExpression(pattern: "(?<=face=\")[^\"]+", options: NSRegularExpression.Options.init(rawValue: 0))
                    
                    faceRegex.enumerateMatches(in: tag, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, tag.characters.count), using: { (match, _, _) in
                        if let match = match,
                            let range = tag.range(from: match.range) {
                            fontName = String(tag[range])
                        }
                    })
                } else if(tag.hasPrefix("img")) {
                    var fileName:String = ""
                    let imageRegex = try NSRegularExpression(pattern: "(?<=src=\")[^\"]+", options: NSRegularExpression.Options.init(rawValue: 0))
                    imageRegex.enumerateMatches(in: tag, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, tag.characters.count), using: { (match, _, _) in
                        if let match = match, let range = tag.range(from: match.range) {
                            fileName = String(tag[range])
                        }
                    })
                    let setter = CTSettings()
                    var width: CGFloat = setter.columnRect.width
                    var height: CGFloat = 0
                    
                    if let image = UIImage(named: fileName) {
                        height = width * (image.size.height / image.size.width)
                        if height > setter.columnRect.height - font.lineHeight {
                            height = setter.columnRect.height - font.lineHeight
                            width = height * (image.size.width / image.size.height)
                        }
                    }
                    
                    images += [["width": NSNumber(value: Float(width)), "height": NSNumber(value: Float(height)), "filename": fileName, "location": NSNumber(value: attributeString.length)]]
                    
                    struct RunStruct {
                        let ascent: CGFloat
                        let descent: CGFloat
                        let width: CGFloat
                    }
                    
                    let extentBuffer = UnsafeMutablePointer<RunStruct>.allocate(capacity: 1)
                    extentBuffer.initialize(to: RunStruct(ascent: height, descent: 0, width: width))
                    
                    var callBacks = CTRunDelegateCallbacks(version: kCTRunDelegateVersion1, dealloc: { (pointer) in
                        
                    }, getAscent: { (pointer) -> CGFloat in
                        let d = pointer.assumingMemoryBound(to: RunStruct.self)
                        return d.pointee.ascent
                    }, getDescent: { (pointer) -> CGFloat in
                        let d = pointer.assumingMemoryBound(to: RunStruct.self)
                        return d.pointee.descent
                    }, getWidth: { (pointer) -> CGFloat in
                        let d = pointer.assumingMemoryBound(to: RunStruct.self)
                        return d.pointee.width
                    })
                    let delegate = CTRunDelegateCreate(&callBacks, extentBuffer)
                    
                    let attrDictionaryDelegate = [(kCTRunDelegateAttributeName as NSAttributedStringKey):delegate as Any]
                    attributeString.append(NSAttributedString(string: " ", attributes: attrDictionaryDelegate))
                }
             }
        } catch _ {
        
        }
            
    }
}

extension String {
    func range(from range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex),
        let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex),
        let from = String.Index.init(from16, within: self),
        let to = String.Index.init(to16, within: self)
        else {
            return nil;
        }
        return from ..< to
    }
}
