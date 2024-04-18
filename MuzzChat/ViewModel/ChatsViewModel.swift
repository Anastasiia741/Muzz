//  ChatViewModel.swift
//  MuzzChat
//  Created by Анастасия Набатова on 12/4/24.

import Foundation
import CoreData

final class ChatsViewModel {
    
    @Published var chats = Chat.sampleChat
    
    private let databaseManager: CoreDataManager
    
    init(databaseManager: CoreDataManager = CoreDataManager.shared) {
        self.databaseManager = databaseManager
    }
}

extension ChatsViewModel: ObservableObject {

    func sendMessage(_ text: String, in chat: Chat) ->  Message? {
        guard let index = chats.firstIndex(where: { $0.id == chat.id }) else { return nil }
        let message = Message(text, type: .sent)
        chats[index].messages.append(message)
        saveChat(chats[index])
        return message
    }
   
    func saveChat(_ chat: Chat) {
        try? databaseManager.saveChatToCoreData(chat)
    }
    
    func markAsUnread(_ newValue: Bool, chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id}) {
            chats[index].hasUnreadMessage = newValue
        }
    }
    
//MARK: - TASK: get messages from CoreData
    func fetchChats() {
        let chatEntities = databaseManager.loadMessages()
        if !chatEntities.isEmpty {
            chats = Chat.sampleChat
        } else {
            Task {
                do {
                    DispatchQueue.main.async {
                        let chat: [Chat] = self.chats.map { chat in
                            let person = Person(name: chat.person.name, image: chat.person.image)
                            let messages = chat.messages
                            return Chat(person: person, messages: messages, hasUnreadMessage: chat.hasUnreadMessage)
                        }
                    }
                }
            }
        }
    }
    
    func getSectionMessage(for chat: Chat) -> [[Message]] {
        let sortedMessages = chat.messages.sorted { $0.date < $1.date }
        var sections: [[Message]] = []
        var currentSection: [Message] = []
        for (index, message) in sortedMessages.enumerated() {
            if index == 0 {
                currentSection.append(message)
            } else {
                let previousMessage = sortedMessages[index - 1]
                let timeInterval = message.date.timeIntervalSince(previousMessage.date)
                let isSameUser = message.type == previousMessage.type
                
                if isSameUser && timeInterval < 20 {
                    currentSection.append(message)
                } else {
                    sections.append(currentSection)
                    currentSection = [message]
                }
            }
        }
        if !currentSection.isEmpty {
            sections.append(currentSection)
        }
        return sections
    }
}
