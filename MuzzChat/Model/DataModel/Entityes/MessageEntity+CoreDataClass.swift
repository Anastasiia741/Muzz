//  MessageEntity+CoreDataClass.swift
//  MuzzChat
//  Created by Анастасия Набатова on 17/4/24.

import Foundation
import CoreData

@objc(MessageEntity)
final class MessageEntity: NSManagedObject {
    
}

extension MessageEntity {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<MessageEntity> {
        NSFetchRequest<MessageEntity>(entityName: String(describing: MessageEntity.self))
    }
    
    @NSManaged var date: Date?
    @NSManaged var id: UUID?
    @NSManaged var text: String?
    @NSManaged var type: String?
    @NSManaged var person: NSSet?
    @NSManaged var chats: NSSet?
}

extension MessageEntity {
    
    @objc(addPersonObject:)
    @NSManaged func addToPerson(_ value: PersonEntity)
    
    @objc(removePersonObject:)
    @NSManaged func removeFromPerson(_ value: PersonEntity)
    
    @objc(addPerson:)
    @NSManaged func addToPerson(_ values: NSSet)
    
    @objc(removePerson:)
    @NSManaged func removeFromPerson(_ values: NSSet)
    
}

extension MessageEntity {
    
    @objc(addChatsObject:)
    @NSManaged func addToChats(_ value: ChatEntity)
    
    @objc(removeChatsObject:)
    @NSManaged func removeFromChats(_ value: ChatEntity)
    
    @objc(addChats:)
    @NSManaged  func addToChats(_ values: NSSet)
    
    @objc(removeChats:)
    @NSManaged  func removeFromChats(_ values: NSSet)
}
