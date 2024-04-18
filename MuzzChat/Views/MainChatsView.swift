//  ContentView.swift
//  MuzzChat
//  Created by Анастасия Набатова on 12/4/24.

import SwiftUI

struct MainChatsView: View {
    @StateObject var viewModel: ChatsViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.chats) { chat  in
                    ZStack {
                        ChatCell(chat: chat)
                        NavigationLink {
                            ChatView(chat: chat)
                                .environmentObject(viewModel)
                        } label: {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 0)
                        .opacity(0)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(Texts.title)
        }
        .padding()
        .accentColor(.pink)
    }
}

