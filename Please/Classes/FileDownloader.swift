//
//  FileDownloader.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-22.
//
//

import Foundation

enum FileDownloaderState {
	case notStarted
	case running
	case finished
	case failed
}

typealias FileDownloaderCompletion = (_ tempFileURL: URL) -> Void
class FileDownloader: NSObject {
	
	let url: URL
	let completion: FileDownloaderCompletion
	
	var state: FileDownloaderState = .notStarted
	
	private lazy var session: URLSession = {
		return URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
	}()
	
	init(url: URL, completion: @escaping FileDownloaderCompletion) {
		self.url = url
		self.completion = completion
		super.init()
	}
	
	func start() {
		let task = session.downloadTask(with: url) {[unowned self] (url: URL?, response: URLResponse?, error: Error?) in
			if let url = url {
				self.finish(withURL: url)
			}
			else if let error = error {
				self.state = .failed
			}
		}
		
		state = .running
		task.resume()
	}
	
	private func finish(withURL: URL) {
		state = .finished
		completion(withURL)
	}
}
