import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State var email: String
    @State var password: String
    @State var logIn: Bool = false

    var body: some View {
        VStack {
            Text("Welcome to the Wellness App")
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                .bold()
                .foregroundColor(.white)
                .offset(y: -120)
                .font(Font.custom("Gill Sans", size: 27))

            Image(systemName: "suit.heart.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 120, height: 100)
                .scaledToFill()
                .offset(y: -120)

            Text("Log in")
                .font(Font.custom("Gill Sans Light", size: 27))
                .foregroundStyle(.blue)
                .offset(y: -100)

            TextField("Enter email", text: $email)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .offset(y: -55)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom("Gill Sans Light", size: 27))

            TextField("Enter password", text: $password)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .offset(y: -50)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom("Gill Sans Light", size: 27))

            Button(action: signIn) {
                Label("Log In", systemImage: "arrow.up")
            }
            .padding()
            .foregroundStyle(.green)
            .background(.blue)
            .cornerRadius(32)

            Button(action: resetPassword) {
                Label("Forgot Password?", systemImage: "person.badge.key")
            }
            .offset(y: 20)
            Button {
                logIn = true
            } label: {
                Label("...or sign up", systemImage: "none")
            }
            .offset(y: 50)
            .offset(x: -9)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
        .fullScreenCover(isPresented: $logIn) {
            SignUpView(email: "", password: "", reenter: "", logIn: $logIn)
        }
    }

    func signIn() {
        self.logIn.toggle()
    }

    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Password reset error: \(error.localizedDescription)")
            } else {
                print("Password reset email sent to \(email)")
            }
        }
    }
}

#Preview {
    ContentView(email: "", password: "")
}
