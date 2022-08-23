//
//  Article+CoreDataProperties.swift
//  dredfort2022
//
//  Created by Dmitry Novikov on 23.08.2022.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var content: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var image: Data?
    @NSManaged public var language: String?
    @NSManaged public var modificationDate: Date?
    @NSManaged public var title: String?

	override public var description:String {
		let titele: String = "TITLE: \(String(describing: title))\n"
		let content: String = "CONTENT: \(String(describing: content))\n"
		let language: String = "LANGUAGE: \(String(describing: language))\n"
		let image: String = "IMAGE: \(String(describing: image))\n"
		let creationDate: String = "CREATION DATE: \(String(describing: creationDate))\n"
		let modificationDate: String = "MODIFICATION DATE: \(String(describing: modificationDate))"

		return titele + content + language + image + creationDate + modificationDate
	}

}
