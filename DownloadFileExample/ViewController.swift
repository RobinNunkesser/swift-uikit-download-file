//
//  ViewController.swift
//  DownloadFileExample
//
//  Created by Prof. Dr. Nunkesser, Robin on 09.03.23.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    @IBOutlet weak var progressLabel: UILabel!
    
    let percentFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter
    }()
    
    private lazy var urlSession = URLSession(configuration: .default,
                                             delegate: self,
                                             delegateQueue: nil)
    var downloadTask : URLSessionDownloadTask?

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://ipv4.download.thinkbroadband.com/50MB.zip")!
        
        startDownload(url: url)
    }
    
    private func startDownload(url: URL) {
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
        self.downloadTask = downloadTask
    }
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        if downloadTask == self.downloadTask {
            let calculatedProgress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            DispatchQueue.main.async {
                self.progressLabel.text = self.percentFormatter.string(from:
                                                                        NSNumber(value: calculatedProgress))
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        debugPrint(location)
    }


}

