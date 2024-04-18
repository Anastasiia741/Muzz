//
//  PersonEntity+CoreDataProperties.swift
//  MuzzChat
//
//  Created by Анастасия Набатова on 17/4/24.
//

import Foundation
import CoreData

extension PersonEntity {
    @nonobjc class func fetchRequest() -> NSFetchRequest<PersonEntity> {
            return NSFetchRequest<PersonEntity>(entityName: "PersonEntity")
        }
    
        @NSManaged var id: UUID?
        @NSManaged var image: String?
        @NSManaged var name: String?
        @NSManaged var chats: ChatEntity?
    //
}
