//
//  FileSystemFetchable.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-22.
//
//

import Foundation

protocol FileSystemFetchable {
	func has(fileWithIdentifier: Identifiable) -> Bool
	func load(fromFileWithIdentifier: Identifiable) -> Data?
}
