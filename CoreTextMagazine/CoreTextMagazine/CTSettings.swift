
//
//  CTSettings.swift
//  CoreTextMagazine
//
//  Created by plum on 2017/9/26.
//  Copyright © 2017年 plum. All rights reserved.
//

import UIKit

class CTSettings {
    let margin: CGFloat = 20
    var columnsPerPage: CGFloat!
    var pageRect: CGRect!
    var columnRect: CGRect!
    
    init() {
        columnsPerPage = UIDevice.current.userInterfaceIdiom == .phone ? 1 : 2
        pageRect = UIScreen.main.bounds.insetBy(dx: margin, dy: margin)
        columnRect = CGRect(x: 0, y: 0, width: pageRect.width / columnsPerPage, height: pageRect.height).insetBy(dx: margin, dy: margin)
    }
    
}
