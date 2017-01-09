//
//  Pleasing.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-01-09.
//
//

import Foundation

public protocol Pleasing: AnyObject {
	var url : URL? {get set}
	func set(object: PleaseCachable)
}

extension Pleasing {
	public var url: URL? {
		get {
			return PleasingLoader.lookupURL(forPleasing: self)
		}
		set (url) {
			PleasingLoader.cancel(forPleasing: self)
			if let url = url {
				PleasingLoader.retrieve(url: url, forPleasing: self)
			}
		}
	}
}

typealias PleasingLoaderCompletion = (PleaseCachable) -> (Void)
class PleasingLoader : NSObject {
	static let sharedLoader = PleasingLoader()
	
	static func retrieve(url: URL, forPleasing: Pleasing) {
		self.sharedLoader.retrieve(url: url, forPleasing: forPleasing)
	}
	
	static func cancel(forPleasing : Pleasing) {
		self.sharedLoader.cancel(forPleasing: forPleasing)
	}
	
	static func lookupURL(forPleasing: Pleasing) -> URL {
		return URL.init(fileURLWithPath: "")
	}
	
	class PleasingLoaderPackage {
		var url: URL
		var completion : PleasingLoaderCompletion
		init(url:URL, completion:@escaping PleasingLoaderCompletion) {
			self.url = url
			self.completion = completion
		}
	}
	
	private let pleasingMap = NSMapTable<AnyObject, PleasingLoaderPackage>.strongToStrongObjects()
	
	private func retrieve(url: URL, forPleasing: Pleasing) {
		let completion = { (object: PleaseCachable) in
			forPleasing.set(object: object)
		}
		
		let package = PleasingLoaderPackage(url: url, completion: completion)
		self.pleasingMap.setObject(package, forKey: forPleasing as AnyObject)
		
		Please.retrieve(url: url) { (cachable: PleaseCachable) in
			self.fireCompletion(forPleasing: forPleasing, withCachable: cachable)
		}
	}
	
	private func cancel(forPleasing: Pleasing) {
		self.pleasingMap.removeObject(forKey: forPleasing)
	}
	
	private func fireCompletion(forPleasing: Pleasing, withCachable: PleaseCachable) {
		if let package = self.pleasingMap.object(forKey: forPleasing){
			self.pleasingMap.removeObject(forKey: forPleasing)
			DispatchQueue.main.async {
				package.completion(withCachable)
			}
		}
	}
}
