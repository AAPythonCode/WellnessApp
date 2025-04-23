//
//  JoinScreen.swift
//  Wellness
//
//  Created by Aarnav Dhir on 4/23/25.
//

import SwiftUI

struct JoinScreen: View {
    var body: some View {
        Text("The world's best way to learn a coding language, bit by bit.")
            .multilineTextAlignment(.center)
            .font(.custom("GmarketSansLight", size: 20))
        Button {
            // action
        } label: {
            Text("Get Started")
        }
        .foregroundStyle(.white)
        .font(.custom("GmarketSansLight", size: 20))
        .buttonStyle(.borderedProminent)
        .offset(y: 320)
        
        
        Button {
            // action
        } label: {
            Text("I already have an account")
        }
        .foregroundStyle(.black)
        .font(.custom("GmarketSansLight", size: 20))
        .offset(y: 335)
    }
}
struct ButtonView: View {
    let label: String
    let icon: String?

    
    init(label: String, icon: String? = nil) {
        self.label = label
        self.icon = icon
    }

    var body: some View {
        Button {
           //action here
        } label: {
            if let icon {
                Image(systemName: icon)
            }
            Text(label)
        }
        .foregroundStyle(.white)
        .font(.custom("GmarketSansLight", size: 20))
        .buttonStyle(.borderedProminent)
        .offset(y: 320)
        
    }
}
#Preview("Join Screen") {
    JoinScreen()
}
