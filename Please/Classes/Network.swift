//
//  Protocols.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2016-12-22.
//
//

import UIKit

class Network: ImageFetchable {
	
	// MARK ImageRetrievable
	func canFetchImage(forUniversalLocation location: String) -> Bool {
		return true
	}
	
	func fetchImage(forUniversalLocation location: String, andCompletion: ((UIImage) -> Void)) {
		
	}
}

class DataDownloader {
	
}
