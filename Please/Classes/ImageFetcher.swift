//
//  Protocols.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2016-12-22.
//
//

import UIKit

class ImageFetcher: ImageFetchable {
	
	// MARK ImageFetchable
	func canFetchImage(forUniversalLocation location: String) -> Bool {
		return true
	}
	
	func fetchImage(forUniversalLocation location: String, andCompletion: ((UIImage) -> Void)) {
		
	}
}

class DataDownloader {
	
}
