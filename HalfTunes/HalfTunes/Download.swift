//
//  Download.swift
//  HalfTunes
//
//  Created by plum on 2018/6/5.
//  Copyright © 2018年 Ray Wenderlich. All rights reserved.
//

import Foundation

class Download: NSObject {
  let track: Track
  
  init(track: Track) {
    self.track = track;
  }
  
  var dataTask: URLSessionDownloadTask?
  var resumeData: Data?
  @objc dynamic var progress: Float = 0.0
  var isDownloading = false
}
