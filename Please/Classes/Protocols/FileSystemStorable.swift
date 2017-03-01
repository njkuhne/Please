//
//  FileSystemStorable.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-22.
//
//

import Foundation

protocol FileSystemStorable {
	func store(data: Data, withIdentifier: String) -> Bool
	func move(localFile: URL, withIdentifier: String) -> Bool
}
