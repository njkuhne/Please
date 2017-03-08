//
//  Identifiable.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-03-03.
//
//

import Foundation

protocol Identifiable {
	var identifierString: String {get}
}

extension URL: Identifiable {
	var identifierString: String {
		return "\(self.hashValue)"
	}
}
