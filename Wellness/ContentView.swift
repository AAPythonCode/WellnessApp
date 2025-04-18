

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Welcome to the Wellness App")
                .font(.largeTitle)
                .fontWeight(.black)
                .bold()
                .foregroundColor(.white)
                .offset(x: -30, y: -190)
            Image(systemName: "globe")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 100, height: 100)
                .scaledToFill()
                .offset(x: -110, y: -190)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
    }
}

#Preview {
    ContentView()
}
