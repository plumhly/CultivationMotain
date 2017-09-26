//
//  ViewController.swift
//  CoreTextMagazine
//
//  Created by plum on 2017/9/26.
//  Copyright © 2017年 plum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let path = Bundle.main.path(forResource: "zombies", ofType: "txt") else {
            return
        }
        do {
            let text = try String(contentsOfFile: path, encoding: .utf8)
            let parse = MarkupParse()
            parse.parseMarkup(text)
            (view as? CTView)?.buidFrames(withAttribute: parse.attributeString, andImages: parse.images)
        } catch _ {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

