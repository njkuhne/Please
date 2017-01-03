//
//  Protocols.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2016-12-22.
//
//

import UIKit

class ImageFetcher: ImageFetchable {
	
	var downloaders = Array<DataDownloader>()
	
	// MARK: ImageFetchable
	func canFetchImage(forUniversalLocation location: String) -> Bool {
		return true
	}
	
	func fetchImage(forUniversalLocation location: String, andCompletion: @escaping ((UIImage) -> Void)) {
		var existingDownloader : DataDownloader?
		downloaders.forEach { (downloader : DataDownloader) in
			if downloader.imageUniversalLocation == location {
				existingDownloader = downloader
			}
		}
		if let downloader = existingDownloader {
			downloader.completions.append(andCompletion)
		}
		else {
			let downloader = DataDownloader(universalLocation: location, completion: andCompletion)
			downloader.begin()
			self.downloaders.append(downloader)
		}
	}
}

typealias DataDownloaderCompletion = (UIImage) -> (Void)
class DataDownloader : NSObject, URLSessionDownloadDelegate {

	let imageUniversalLocation : String
	var completions = Array<DataDownloaderCompletion>()
	
	init(universalLocation: String, completion: @escaping DataDownloaderCompletion) {
		imageUniversalLocation = universalLocation
		completions.append(completion)
	}
	
	private var imageURL : URL? {
		get {
			return URL(string: imageUniversalLocation)
		}
	}
	
	private lazy var session: URLSession = {
		return URLSession.init(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
	}()
	
	func begin() {
		if let url = self.imageURL {
			let task = self.session.downloadTask(with: url)
			task.resume()
		}
	}
	
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
		if let data = NSData.init(contentsOf: location) {
			if let image = UIImage(data: data as Data) {
				for completion in completions {
					completion(image)
				}
			}
		}
	}
}
