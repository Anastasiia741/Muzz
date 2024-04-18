//  MuzzChatApp.swift
//  MuzzChat
//  Created by Анастасия Набатова on 12/4/24.

import SwiftUI

@main
struct MuzzChatApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainChatsView(viewModel: ChatsViewModel())
        }
    }
}
