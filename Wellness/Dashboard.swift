//
//  Dashboard.swift
//  Wellness
//
//  Created by A&A on 4/9/25.
//

import SwiftUI

var heartsRemaining = 5

struct Dashboard: View {
    @Binding var isLoggedIn: Bool
    @Binding var userName: String
    @Binding var userEmail: String
    @State var progress = 0
    @State var screenNum: Int = 0
    var body: some View {
        if screenNum == 0 {
            homeScreen()
        } else if screenNum == 1 {
            communityScreen()
        } else if screenNum == 2 {
            upgradeScreen()
        } else if screenNum == 3 {
            competitionsScreen()
        } else if screenNum == 4 {
            profileScreen()
        }
        Spacer()
        HStack {
            Button(action: {
                screenNum = 0
            }) {
                VStack {
                    Image(systemName: screenNum == 0 ? "house.fill" : "house")
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(screenNum == 0 ? .green : .gray)
                        .frame(width: 30, height: 30)
                }
                .padding()
            }
            Button(action: {
                screenNum = 1
            }) {
                VStack {
                    Image(systemName: screenNum == 1 ? "person.3.fill" : "person.3")
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(screenNum == 1 ? .orange : .gray)
                        .frame(width: 40, height: 40)
                }
                .padding()
            }
            Button(action: {
                screenNum = 2
            }) {
                VStack {
                    Image(systemName: screenNum == 2 ? "star.hexagon.fill" : "star.hexagon")
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(screenNum == 2 ? .gold : .gray)
                        .frame(width: 30, height: 30)
                }
                .padding()
            }
            Button(action: {
                screenNum = 3
            }) {
                VStack {
                    Image(systemName: screenNum == 3 ? "trophy.fill" : "trophy")
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(screenNum == 3 ? .blue : .gray)
                        .frame(width: 30, height: 30)
                }
                .padding()
            }
            Button(action: {
                screenNum = 4
            }) {
                VStack {
                    Image(systemName: screenNum == 4 ? "person.fill" : "person")
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(screenNum == 4 ? .purple : .gray)
                        .frame(width: 30, height: 30)
                }
                .padding()
            }
        }
    }
}

struct homeScreen: View {
    var body: some View {
        Spacer()
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 120)
                .foregroundStyle(.blue)
                .padding()
            Text("Hello!")
                .font(.custom("GmarketSansLight", size: 20))
                .foregroundStyle(.white)
        }
    }
}
struct communityScreen: View {
    var body: some View {
        Spacer()
        Text("communityScreen!")
    }
}
struct upgradeScreen: View {
    var body: some View {
        Spacer()
        Text("upgradeScreen!")
    }
}
struct competitionsScreen: View {
    var body: some View {
        Spacer()
        Text("competitionsScreen!")
    }
}
struct profileScreen: View {
    var body: some View {
        
    }
}
#Preview {
    Dashboard(isLoggedIn: .constant(false), userName: .constant("Sample User"), userEmail: .constant("sample@email.com"))
}
