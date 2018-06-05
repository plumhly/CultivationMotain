//
//  SearchViewController+URLSessionDelegates.swift
//  HalfTunes
//
//  Created by plum on 2018/6/5.
//  Copyright © 2018年 Ray Wenderlich. All rights reserved.
//

import Foundation

extension SearchViewController: URLSessionDownloadDelegate {
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
    guard let sourceURL = downloadTask.originalRequest?.url else {
      return;
    }
    
    let download = downloadService.activeDownloads[sourceURL]
    downloadService.activeDownloads[sourceURL] = nil
    
    let destination = localFilePath(for: location)
    print(destination)
    
    let fileManager = FileManager.default
    
    try? fileManager.removeItem(at: destination)
    
    do {
      try fileManager.copyItem(at: location, to: destination)
      download?.track.downloaded = true
    } catch let error {
      print("Could not copy file to disk: \(error.localizedDescription)")
    }
    
    if let index = download?.track.index {
      DispatchQueue.main.async {
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
      }
    }
  }
  
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
    guard let url = downloadTask.originalRequest?.url, let download = downloadService.activeDownloads[url] else {
      return
    }
    
    download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
    let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
    DispatchQueue.main.async {
      let cell = self.tableView.cellForRow(at: IndexPath(row: download.track.index, section: 0)) as? TrackCell
      cell?.updateDisplay(progress: download.progress, total: totalSize)
    }
  }
}
