//  NavigationBar.swift
//  MuzzChat
//  Created by Анастасия Набатова on 14/4/24.

import SwiftUI

struct ChatNavigationBarItem: View {
    let chat: Chat
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(chat.person.image ?? Images.profile)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                Text(chat.person.name).bold()
            }
            .foregroundColor(.black)
            .padding(.leading, 20)
        }
    }
}
