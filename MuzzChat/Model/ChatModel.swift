//  ChatModel.swift
//  MuzzChat
//  Created by Анастасия Набатова on 12/4/24.

import Foundation

struct Chat: Identifiable {
    
    var id: UUID { person.id }
    let person: Person
    var messages: [Message]
    var hasUnreadMessage = false
}

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let image: String?
}

struct Message: Identifiable {
    
    enum MessageType: String {
        case sent, received, all
    }
    
    var id = UUID()
    let date: Date
    let text: String
    let type: MessageType
    
    init(_ text: String, type: MessageType, date: Date) {
        self.id = UUID()
        self.date = date
        self.type = type
        self.text = text
    }
    
    init(_ text: String, type: MessageType) {
        self.init(text, type: type, date: Date())
    }
}


struct ChatDomainModel: Identifiable {
    let id: UUID
    let person: [String]
    var messages: [Message]
    var hasUnreadMessage = false
}


extension Chat {
    static let sampleChat = [
        Chat(person: Person(name: "Oliver", image: "pic1"), messages: [
            Message("Hey there! How's it going?", type: .sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message("I'm doing well, thanks! Been quite busy lately.", type: .received, date: Date(timeIntervalSinceNow: -86400 * 2 + 300)),
            Message("I've been swamped too. Up for a movie this Friday?", type: .sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
            Message("Sounds like a plan. What time were you thinking?", type: .received, date: Date(timeIntervalSinceNow: -86400 * 1 + 300)),
        ], hasUnreadMessage: true),
        Chat(person: Person(name: "Emma", image: "pic2"), messages: [
            Message("Did you see the game last night?", type: .received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("Yes, it was incredible! That last-minute goal!", type: .sent, date: Date(timeIntervalSinceNow: -86400 * 3 + 20)),
            Message("Absolutely thrilling! We should go watch the next one together.", type: .received, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message("I'm in! Let's do it.", type: .sent, date: Date(timeIntervalSinceNow: -86400 * 2 + 20)),
        ]),
        Chat(person: Person(name: "Sophia", image: "pic3"), messages: [
            Message("Are we still on for the hike tomorrow?", type: .sent, date: Date(timeIntervalSinceNow: -86400)),
            Message("Yes, can't wait! We're meeting at the usual spot, right?", type: .received, date: Date(timeIntervalSinceNow: -86400 + 60)),
            Message("Yup, see you at 8 AM. Don't forget water and snacks!", type: .sent, date: Date(timeIntervalSinceNow: -86400 + 120)),
            Message("Will do. Thanks for the reminder!", type: .received, date: Date(timeIntervalSinceNow: -86400 + 180)),
        ], hasUnreadMessage: false),
        Chat(person: Person(name: "Tomas", image: "pic4"), messages: [
            Message("Hey! Did you also go to Oxford?", type: .sent, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message("Yes 😊 Are you going to the food festival on Sunday?", type: .received, date: Date(timeIntervalSinceNow: -86400 * 3 + 20)),
            Message("🙌", type: .sent, date: Date(timeIntervalSinceNow: -86400 * 3 + 40)),
            Message("I am! 😊 See you there for a coffee?", type: .received, date: Date(timeIntervalSinceNow: -86400 * 2)),
        ], hasUnreadMessage: true),
        Chat(person: Person(name: "Jane", image: "pic5"), messages: [
            Message("Hello!", type: .sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message("How are you?", type: .received, date: Date(timeIntervalSinceNow: -86400 * 2 + 20)),
            Message("I'm great, thanks for asking!", type: .sent, date: Date(timeIntervalSinceNow: -86400 * 2 + 40)),
            Message("Wanna catch up this weekend?", type: .received, date: Date(timeIntervalSinceNow: -86400)),
            Message("Sure, sounds good!", type: .sent, date: Date(timeIntervalSinceNow: -86400 + 20)),
        ], hasUnreadMessage: false),
        Chat(person: Person(name: "Bob", image: "pic6"), messages: [])
    ]
}
