//
//  SearchVC+URLSessionDelegate.swift
//  HalfTunes
//
//  Created by plum on 2018/6/5.
//  Copyright © 2018年 Ray Wenderlich. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: URLSessionDelegate {
  func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
    DispatchQueue.main.async {
      if let appdelegete = UIApplication.shared.delegate as? AppDelegate, let completionHandler = appdelegete.backgroundSessionCompletionHandler {
        appdelegete.backgroundSessionCompletionHandler = nil;
        completionHandler()
      }
    }
  }
}
