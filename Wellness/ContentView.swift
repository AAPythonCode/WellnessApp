

import SwiftUI

struct ContentView: View {
    @State var email: String
    var body: some View {
        VStack {
            Text("Welcome to the Wellness App")
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                .bold()
                .foregroundColor(.white)
                .offset(y: -120)
                .font(Font.custom(
                    "Gill Sans", size: 27
                ))
            Image(systemName: "suit.heart.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(
                    width: 120,
                    height: 100
                )
                .scaledToFill()
                .offset(y: -120)
            Text("Log in")
                .font(Font.custom(
                    "Gill Sans Light", size: 27
                ))
                .foregroundStyle(.blue)

                .offset(y: -100)
            TextField("Enter email", text: $email)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .offset(x: 0, y: -55)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom(
                    "Gill Sans Light", size: 27
                ))
            TextField("Enter password", text: $email)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .offset(x: 0, y: -50)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom(
                    "Gill Sans Light", size: 27
                ))
            Button(action: signIn) {
                Label("Sign In", systemImage: "arrow.up")
            }
            .padding()
            .foregroundStyle(.green)
            .background(.blue)
            .cornerRadius(32)
            Button(action: signIn) {
                Label("... or sign up", systemImage: "none")
            }
            .offset(y: 22)
            .offset(x: -9)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
    }
    func signIn() {
        print("hello")
    }
}

#Preview {
    ContentView(email: "")
}
