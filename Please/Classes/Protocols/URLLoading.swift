//
//  URLLoading.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-03-08.
//
//

import Foundation


public protocol URLLoading: AnyObject {
	associatedtype T: Cachable
	var url : URL? {get set}
	func cache() -> Cache<T>
	func completedLoading(with: T)
}

public extension URLLoading {
	var urlString: String? {
		get {
			return self.url?.absoluteString
		}
		set {
			if let newURLString = newValue {
				self.url = URL(string: newURLString)
			}
		}
	}
}

private var URLLoadingObjectTable = NSMapTable<AnyObject, NSURL>.weakToStrongObjects()
extension URLLoading {
	public var url: URL? {
		set {
			URLLoadingObjectTable.removeObject(forKey: self)
			if let url = newValue {
				URLLoadingObjectTable.setObject(url as NSURL, forKey: self)
				self.cache().retrieve(url: url) { (object) in
					if self.url != nil && url == self.url {
						self.completedLoading(with: object)
					}
				}
			}
		}
		get {
			return URLLoadingObjectTable.object(forKey: self) as URL?
		}
	}
}
