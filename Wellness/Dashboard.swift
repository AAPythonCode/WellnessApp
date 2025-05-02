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
            upgradeScreen(chosenColor: .navyBlue)
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
                    Image(screenNum == 0 ? "home-filled" : "home-unfilled")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenNum == 0 ? 40 : 30, height: screenNum == 0 ? 40 : 30)
                }
                .padding()
            }
            Button(action: {
                screenNum = 1
            }) {
                VStack {
                    Image(screenNum == 1 ? "group-unfilled" : "group-filled")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenNum == 1 ? 40 : 30, height: screenNum == 1 ? 40 : 30)
                }
                .padding()
            }
            Button(action: {
                screenNum = 2
            }) {
                VStack {
                    Image(screenNum == 2 ? "certification-filled" : "certification-unfilled")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenNum == 2 ? 40 : 30, height: screenNum == 2 ? 40 : 30)
                }
                .padding()
            }
            Button(action: {
                screenNum = 3
            }) {
                VStack {
                    Image(screenNum == 3 ? "trophy-filled" : "trophy-unfilled")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenNum == 3 ? 40 : 30, height: screenNum == 3 ? 40 : 30)
                }
                .padding()
            }
            
            Button(action: {
                screenNum = 4
            }) {
                VStack {
                    Image(screenNum == 4 ? "user-filled" : "user-unfilled")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenNum == 4 ? 40 : 30, height: screenNum == 4 ? 40 : 30)
                }
                .padding()
            }
        }
    }
}


struct profileScreen: View {
    var body: some View {

    }
}
struct communityScreen: View {
    var body: some View {
        Spacer()
        Text("communityScreen!")
    }
}
struct upgradeScreen: View {
    @State var colors: [Color] = [.red, .orange, .green, .blue, .purple, .indigo, .navyBlue]
    @State var counter: Int = 0
    @State var chosenColor: Color
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    var body: some View {
        ScrollView {
            Spacer()
            VStack(spacing: 10) {
                ZStack {
                    roundRect(height: 680, color: .gold)
                    VStack {
                        Text("Bit by Bit presents: ")
                        .multilineTextAlignment(.center)
                        .font(.custom("GmarketSansBold", size: 20))
                        .padding(20.0)
                        .foregroundStyle(chosenColor)
                        HStack {
                            Text("""
                         The
                         Compile
                         Club®
                         """)
                            .multilineTextAlignment(.center)
                            .font(.custom("GmarketSansBold", size: 40))
                            .foregroundStyle(chosenColor)
                        Image(systemName: "lightbulb.max.fill")
                            .resizable()
                            .foregroundStyle(chosenColor)
                            .scaledToFit()
                            .frame(width: 130, height: 130)
                        }
                    
                        Label {
                            Text("Scroll down to learn more!")
                                .multilineTextAlignment(.center)
                                .font(.custom("GmarketSansLight", size: 30))
                                .foregroundStyle(chosenColor)
                            } icon : {
                            Image(systemName: "arrowshape.down.circle.fill")
                                .font(.system(size: 65))
                                .foregroundStyle(chosenColor)
                                .offset(y: 15)
                        }
                    }
                }
                ZStack {
                    roundRect(height: 120, color: .gold)
                    HStack(spacing: 0) {
                        Text("""
                             Join      
                             the      
                             """)
                            .font(.custom("GmarketSansLight", size: 20))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(chosenColor)
                        Text("Compile Club")
                            .font(.custom("GmarketSansBold", size: 23))
                            .foregroundStyle(chosenColor)
                        Text("""
                            for      
                            advanced      
                            coding!      
                            """)
                            .font(.custom("GmarketSansLight", size: 20))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(chosenColor)
                    }
                }
                ZStack {
                    roundRect(height: 120, color: .green)
                    Text("Features:")
                        .multilineTextAlignment(.center)
                        .font(.custom("GmarketSansBold", size: 40))
                        .foregroundStyle(.navyBlue)
                }
                ZStack {
                    roundRect(height: 300, color: .green)
                    VStack {
                        Text("Competitions")
                            .multilineTextAlignment(.center)
                            .font(.custom("GmarketSansBold", size: 40))
                            .foregroundStyle(.navyBlue)
                            .padding(.bottom, 20)
                            .offset(y: -10)
                            Text("Compete against others! New challenges every Saturday.")
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                                .font(.custom("GmarketSansLight", size: 25))
                                .foregroundStyle(.navyBlue)
                        VStack {
                            HStack(spacing: 0) {
                                bottomText(content: "(Find me in the ", size: 25)
                                Image("trophy-filled")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                            bottomText(content: "section of the app!)", size: 25)
                        }
                    }
                }
                ZStack {
                    roundRect(height: 300, color: .green)
                    VStack {
                        topText(content: "Pro Practice", size: 40)
                            .offset(y: -40)
                        bottomText(content: "Practice and improve with Pro levels! ", size: 25)
                            .offset(y: -35)
                        HStack{
                            bottomText(content: "(Once you upgrade, you'll find me in the", size: 20)
                            Image("certification-filled")
                                .resizable()
                                .frame(width: 40, height: 40)
                            bottomText(content: "section of the app!)", size: 20)
                        }
                    }
                }
                ZStack {
                    roundRect(height: 300, color: .green)
                    topText(content: "Fix Mistakes", size: 40)
                        .offset(y: -90)
                    bottomText(content: "Fix your mistakes by practicing them over and over! ", size: 25)
                        .offset(y: -20)
                    HStack{
                        bottomText(content: "(Once you upgrade, you'll find me in the", size: 20)
                            .offset(y: 70)
                        Image("certification-filled")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .offset(y: 70)
                        bottomText(content: "section of the app!)", size: 20)
                            .offset(y: 70)
                    }
                }
                ZStack{
                    roundRect(height: 220, color: .gold)
                    topText(content: "We saved the best one for last!",
                            size: 45)
                        .offset(y: 25.0)
                }
                ZStack {
                    roundRect(height: 400, color: .purple)
                    VStack {
                        Text("Computer Link")
                            .multilineTextAlignment(.center)
                            .font(.custom("GmarketSansBold", size: 40))
                            .foregroundStyle(.white)
                            .offset(y: -50)
                        Text("""
                            Connect your phone to a comuter with an access code! 
                            (Some optional typing lessons are in Pro levels)
                            """)
                            .multilineTextAlignment(.center)
                            .font(.custom("GmarketSansLight", size: 20))
                            .foregroundStyle(.white)
                            .padding()
                        HStack{
                            Text("(Once you upgrade, you'll find me in the")
                                .multilineTextAlignment(.center)
                                .font(.custom("GmarketSansLight", size: 20))
                                .foregroundStyle(.white)
                                
                            Image("certification-filled")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                
                            Text("section of the app!)")
                                .multilineTextAlignment(.center)
                                .font(.custom("GmarketSansLight", size: 20))
                                .foregroundStyle(.white)
                                
                        }
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            counter += 1
            if counter % 2 != 0 {
                chosenColor = colors.randomElement() ?? .red
            }
        }
    }
}
struct competitionsScreen: View {
    var body: some View {
        Spacer()
        Text("competitionsScreen!")
    }
}
struct homeScreen: View {
    var body: some View {
        roundRect(height: 100, color: .blue)
    }
}

//Convienience Structs
// ______________________________________________________________________________________________________
struct roundRect: View {
    var height: CGFloat
    var color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: height)
            .foregroundStyle(color)
            .padding(.horizontal, 10)
    }
}
struct coderCoding: View {
    var body: some View {
        Image("coder")
            .resizable()
            .frame(width: 70, height: 70)
            .offset(y: 30)
    }
}
struct topText: View {
    var content: String
    var size: CGFloat

    var body: some View {
        Text(content)
            .multilineTextAlignment(.center)
            .font(.custom("GmarketSansBold", size: size))
            .foregroundStyle(.navyBlue)
            .padding(.bottom, 20)
            .offset(y: -10)
    }
}
struct bottomText: View {
    var content: String
    var size: CGFloat
    var body: some View {
        Text(content)
            .multilineTextAlignment(.center)
            .font(.custom("GmarketSansLight", size: size))
            .foregroundStyle(.navyBlue)
    }
}
#Preview {
    Dashboard(isLoggedIn: .constant(false), userName: .constant(""), userEmail: .constant(""))
}
