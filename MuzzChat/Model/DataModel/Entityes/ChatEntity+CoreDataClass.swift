//  Entity+CoreDataProperties.swift
//  MuzzChat
//  Created by Анастасия Набатова on 15/4/24.

import Foundation
import CoreData

@objc(ChatEntity)
final class ChatEntity: NSManagedObject {
    
    static func object(insertInto context: NSManagedObjectContext) -> ChatEntity? {
        guard let entity = ChatEntity.entityDescription(in: context) else {
            return nil
        }
        let chatEntity = ChatEntity(entity: entity, insertInto: context)
        return chatEntity
    }
}

extension ChatEntity {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<ChatEntity> {
        NSFetchRequest<ChatEntity>(entityName: String(describing: "ChatEntity"))
    }
    
    @NSManaged var hasUnreadMessage: Bool
    @NSManaged var messages: NSSet?
    @NSManaged var person: PersonEntity?
}

extension ChatEntity {
    
        @objc(addMessagesObject:)
        @NSManaged func addToMessages(_ value: MessageEntity)
    
        @objc(removeMessagesObject:)
        @NSManaged func removeFromMessages(_ value: MessageEntity)
    
        @objc(addMessages:)
        @NSManaged func addToMessages(_ values: NSSet)
    
        @objc(removeMessages:)
        @NSManaged func removeFromMessages(_ values: NSSet)
  }
