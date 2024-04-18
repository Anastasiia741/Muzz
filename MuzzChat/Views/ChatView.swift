//  ChatView.swift
//  MuzzChat
//  Created by Анастасия Набатова on 12/4/24.

import SwiftUI

struct ChatView: View {
    
    @EnvironmentObject var viewModel: ChatsViewModel
    let chat: Chat
    @State private var text = ""
    @State private var messageID: UUID?
    private let columns = [GridItem(.flexible(minimum: 10))]
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                ScrollView {
                    ScrollViewReader { scrollReader in
                        getMessagerView(viewWidth: geometry.size.width)
                            .padding(.horizontal)
                            .onChange(of: messageID) { newValue, _ in
                                if let messageID = newValue {
                                    scrollTo(messageID: messageID, shouldAnimate: true, scrollReader: scrollReader)
                                }
                            }
                            .onAppear {
                                if let messageID = chat.messages.last?.id {
                                    scrollTo(messageID: messageID, anchor: .bottom, shouldAnimate: false, scrollReader: scrollReader)
                                    viewModel.fetchChats()
                                }
                            }
                    }
                }
            }
            .padding(.bottom, 5)
            toolbarView()
        }
        .padding(.top, 1)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: ChatNavigationBarItem(chat: chat))
        .onAppear {
            viewModel.markAsUnread(false, chat: chat)
        }
    }
}

private extension ChatView {
    
    func scrollTo(messageID: UUID, anchor: UnitPoint? = nil, shouldAnimate: Bool, scrollReader: ScrollViewProxy ) {
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? .spring() : nil) {
                scrollReader.scrollTo(messageID, anchor: anchor)
            }
        }
    }
    
    func toolbarView() -> some View {
        VStack {
            let height: CGFloat = 37
            HStack {
                TextField(Texts.message, text: $text)
                    .padding(.horizontal, 10)
                    .frame(height: height)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                    .focused($isFocused)
                Button(action: {
                    sendMessage()
                }) {
                    Images.sentMessageButton
                        .foregroundColor(.white)
                        .frame(width: height, height: height)
                        .background(
                            Circle()
                                .foregroundColor(text.isEmpty ? .gray : .pink)
                        )
                }
                .disabled(text.isEmpty)
            }
            .frame(height: height)
        }
        .padding(.vertical)
        .padding(.horizontal)
        .background(.thinMaterial)
    }
    
    func sendMessage() {
        if let message = viewModel.sendMessage(text, in: chat) {
            text = ""
            messageID = message.id
            viewModel.saveChat(chat)
        }
    }
    
    func getMessagerView(viewWidth: CGFloat) -> some View {
        LazyVGrid(columns: columns, spacing: 0) {
            let sectionMessage = viewModel.getSectionMessage(for: chat)
            if sectionMessage.isEmpty {
                AnyView(Text(Texts.emptyChat)
                    .font(.title2)
                    .foregroundColor(.pink).opacity(0.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 250))
                
            } else {
                AnyView(LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(sectionMessage.indices, id: \.self) { sectionIndex in
                        let messages = sectionMessage[sectionIndex]
                        let firstMessage = messages.first ?? Message("", type: .sent, date: Date())
                        Section(header: Text(firstMessage.date.descriptiveStringForChat())
                            .foregroundColor(.gray)) {
                                ForEach(messages) { message in
                                    let isReceived = message.type == .received
                                    MessageView(message: message, viewWidth: viewWidth, isReceived: isReceived)
                                        .id(message.id)
                                }
                            }
                    }
                })
            }
        }
    }
}

