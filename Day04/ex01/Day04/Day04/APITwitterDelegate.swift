//
//  APITwitterDelegate.swift
//  Day04
//
//  Created by Dmitry Novikov on 14.08.2022.
//

import Foundation

protocol APITwitterDelegate {
	func receivedTweet(_ : [Tweet])
	func caseOfError(_ : NSError)
}
