//
//  APITwitterDelegate.swift
//  Day04
//
//  Created by Dmitry Novikov on 14.08.2022.
//

import Foundation

protocol APITwitterDelegate: AnyObject {
	func getTweets(tweets: [Tweet])
	func showErrors(error: NSError)
}
