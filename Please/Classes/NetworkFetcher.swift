//
//  NetworkFetcher.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-23.
//
//

import Foundation

typealias NetworkCompletion = ((Cachable) -> Void)

class NetworkFetcher<T: Cachable>: Fetchable {
	private let fileSystem: FileSystemStorable & FileSystemFetchable
	
	init(fileSystem: FileSystemStorable & FileSystemFetchable) {
		self.fileSystem = fileSystem
	}
	
	private var downloaders: Dictionary<URL, FileDownloader> = [:]
	private var completions: Dictionary<URL, Array<NetworkCompletion>> = [:]
	
	// MARK: Fetchable
	func canFetch(for url: URL) -> Bool {
		return true
	}
	
	func fetch(for url: URL, completion: @escaping ((Cachable) -> Void)) {
		if self.downloaders[url] != nil {
			appendCompletion(for: url, completion: completion)
		}
		else {
			createNewDownloader(for: url, completion: completion)
		}
	}
	
	private func appendCompletion(for url: URL, completion: @escaping NetworkCompletion) {
		if var completions = self.completions[url] {
			completions.append(completion)
			self.completions[url] = completions
		}
		else {
			self.completions[url] = [completion]
		}
	}
	
	private func createNewDownloader(for url: URL, completion: @escaping NetworkCompletion) {
		let downloader = FileDownloader(url: url) { (tempURL) in
			self.didFinishDownload(for: url, tempURL: tempURL)
		}
		downloaders[url] = downloader
		self.appendCompletion(for: url, completion: completion)
		
		downloader.start()
	}
	
	func didFinishDownload(for url: URL, tempURL: URL) {
		if self.fileSystem.move(localFile: tempURL, withIdentifier: url), let data = fileSystem.load(fromFileWithIdentifier: url) {
			if let object = T(data: data), let completions = completions[url] {
				for completion in completions {
					completion(object)
				}
			}
		}
		
		downloaders[url] = nil
		completions[url] = nil
	}
}
