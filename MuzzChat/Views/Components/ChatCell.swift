//  ChatCell.swift
//  MuzzChat
//  Created by Анастасия Набатова on 12/4/24.

import SwiftUI

struct ChatCell: View {
    let chat: Chat
    var body: some View {
        HStack(spacing: 20){
            Image(chat.person.image ?? Images.profile)
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            ZStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(chat.person.name)
                            .bold()
                        Spacer()
                        Text(chat.messages.last?.date.descriptiveStringForChats() ?? "")
                    }
                    HStack {
                        if let lastMessage = chat.messages.last {
                            Text(lastMessage.text)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                                .frame(height: 50, alignment: .top)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 40)
                        } else {
                            Text(Texts.noMessage)
                                .foregroundColor(.gray).opacity(0.7)
                                .frame(height: 50, alignment: .top)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 40)
                                .font(.subheadline)
                        }
                    }
                }
                Circle()
                    .foregroundColor(chat.hasUnreadMessage ? .pink : .clear)
                    .frame(width: 18, height: 18)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(height: 80)
    }
}

