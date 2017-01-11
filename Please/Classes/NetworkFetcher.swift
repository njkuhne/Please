//
//  Protocols.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2016-12-22.
//
//

import UIKit

class NetworkFetcher<Cachable: PleaseCachable>: Fetchable {
	
	var downloaders = Array<DataDownloader<Cachable>>()
	
	// MARK: Fetchable
	func canFetch(url: URL) -> Bool {
		return true
	}
	
	func fetch(url: URL, withCompletion: @escaping ((PleaseCachable) -> Void)) {
		var existingDownloader : DataDownloader<Cachable>?
		downloaders.forEach { (downloader : DataDownloader) in
			if downloader.dataURL == url {
				existingDownloader = downloader
			}
		}
		if let downloader = existingDownloader {
			downloader.completions.append(withCompletion)
		}
		else {
			let downloader = DataDownloader<Cachable>(url: url, completion: withCompletion)
			downloader.begin()
			self.downloaders.append(downloader)
		}
	}
}

typealias DataDownloaderCompletion = (PleaseCachable) -> (Void)
class DataDownloader<Cachable: PleaseCachable> : NSObject, URLSessionDownloadDelegate {
	
	let dataURL : URL
	var completions = Array<DataDownloaderCompletion>()
	
	init(url: URL, completion: @escaping DataDownloaderCompletion) {
		dataURL = url
		completions.append(completion)
	}
	
	private lazy var session: URLSession = {
		return URLSession.init(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
	}()
	
	func begin() {
		let task = self.session.downloadTask(with: dataURL)
		task.resume()
	}
	
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
		do {
			let data = try Data(contentsOf: location)
			let object = Cachable.convertToObject(data: data)
			completions.forEach({ (completion: DataDownloaderCompletion) in
				completion(object)
			})
		}
		catch _ {
			print("")
		}
	}
}
