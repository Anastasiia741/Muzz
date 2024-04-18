//  File.swift
//  MuzzChat
//  Created by Анастасия Набатова on 15/4/24.

import SwiftUI

struct MessageView: View {
    let message: Message
    let viewWidth: CGFloat
    let isReceived: Bool
    @State private var scale: CGFloat = 0.5
    
    var body: some View {
        HStack {
            ZStack {
                Text(message.text)
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .background(isReceived ? Color.black.opacity(0.2) : .green.opacity(0.7))
                    .cornerRadius(13)
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                            scale = 1
                        }
                    }
            }
            .frame(width: viewWidth * 0.7, alignment: isReceived ? .leading : .trailing)
            .padding(.vertical, 15)
        }
        .frame(maxWidth: .infinity, alignment: isReceived ? .leading : .trailing)
    }
}
