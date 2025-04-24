//
//  launchrocket.swift
//  Bit By Bit
//
//  Created by Aarnav Dhir on 4/23/25.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack {
            // Background color (white)
            Color.white
                .ignoresSafeArea()
            
            VStack {
                // Your logo image from Assets.xcassets
                Image("appe") // Updated to your app logo name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150) // Adjust size as needed
                
                // App name or tagline
                Text("Bit By Bit") // Replace with your actual app name or tagline
                    .font(.custom("GmarketSansLight", size: 30))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Center vertically and horizontally
        }
    }
}

#Preview {
    LaunchView()
}
