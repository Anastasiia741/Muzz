//  ChatDomainModel.swift
//  MuzzChat
//  Created by Анастасия Набатова on 17/4/24.

import Foundation

struct ChatDomainModel: Identifiable {
    var id: UUID
    let person: [String]
    var messages: [String]
    var hasUnreadMessage: Bool
}
