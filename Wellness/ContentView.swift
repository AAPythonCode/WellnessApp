//
//  ContentView.swift
//  Wellness
//
//  Created by Aarnav Dhir on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 100, height: 100)
                .scaledToFill()
                .offset(x: -110, y: -190)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
