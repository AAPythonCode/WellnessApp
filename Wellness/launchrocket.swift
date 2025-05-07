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
                Image("appe")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    LaunchView()
}
