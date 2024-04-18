//  CoreDataManager.swift
//  MuzzChat
//  Created by Анастасия Набатова on 15/4/24.

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    private var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ChatModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Failed to load the data \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension CoreDataManager: ObservableObject {
    
    func saveChatToCoreData(_ chat: Chat) throws {
        let context = container.viewContext
        let chatEntity = ChatEntity(context: context)
        chatEntity.hasUnreadMessage = chat.hasUnreadMessage
        
        let personEntity = PersonEntity(context: context)
        personEntity.id = chat.id
        personEntity.name = chat.person.name
        personEntity.image = chat.person.image
        chatEntity.person = personEntity
        
        var messagesArray = [MessageEntity]()
    
        for message in chat.messages {
            let messageEntity = MessageEntity(context: context)
            messageEntity.text = message.text
            messageEntity.date = message.date
            messagesArray.append(messageEntity)
        }
        chatEntity.messages = NSSet(array: messagesArray)
        try? viewContext.save()
    }
    
//MARK: - TASK: fix fetch messages
    func loadMessages() -> [Chat] {
        let request = ChatEntity.fetchRequest()
        let results = try? container.viewContext.fetch(request)
        return Chat.sampleChat
    }
}

extension NSManagedObject {
    static func entityDescription(in context: NSManagedObjectContext) -> NSEntityDescription? {
        NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: context)
    }
}

