//
//  APIErrors.swift
//  Day04
//
//  Created by Dmitry Novikov on 15.08.2022.
//

import Foundation

enum APIErrors: Error {
	case aouchRequestError
	case tokenRequestError
	case tweetsRequestError
	case tweetsParseError
}

class IsError {
	static var error: APIErrors?
}
