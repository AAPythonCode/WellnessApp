import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct ContentView: View {
    @State var email: String
    @State var password: String
    @State private var signUpErrorMessage: String = ""
    @State private var showingResetAlert = false
    @State private var resetEmail: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var loginError: String = ""
    @State private var githubSignInError: String = ""
    @State private var goBackToJoinScreen = false
    
    var body: some View {
        VStack {
            
            Text("Welcome back to your coding journey.")
                .font(Font.custom("GmarketSansLight", size: 35))
            
                .multilineTextAlignment(.center)
                .bold()
                .foregroundStyle(.black)
                .padding()
            
            Text("Log in with email")
                .font(Font.custom("GmarketSansLight", size: 23))
                .bold()
                .foregroundStyle(.black)
                .padding()
            
            TextField("Enter email", text: $email)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom("GmarketSansLight", size: 27))
                .padding(.bottom, 5)
                .padding()
            
            TextField("Enter password", text: $password)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom("GmarketSansLight", size: 27))
                .padding(.bottom, 5)
            
            Button(action: signIn) {
                Label("Log In", systemImage: "arrow.up")
            }
            .padding()
            .foregroundStyle(.black)
            .background(.blue)
            .cornerRadius(32)
            
            Button("Forgot Password?") {
                showingResetAlert = true
            }
            .foregroundStyle(.black)
            .padding()
            .sheet(isPresented: $showingResetAlert) {
                VStack {
                    Text("Reset your password. ")
                        .font(.title2)
                        .padding()
                    Text("Don't worry, we all forget sometimes! 😅")
                    TextField("Enter your email (it should be valid)", text: $resetEmail)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    Button("Send Reset Email (Check Your Inbox)") {
                        resetPassword()
                        showingResetAlert = false
                    }
                    Text("(Swipe down to close this menu.)")
                        .padding()
                        .tint(.gray)
                }
                .padding()
            }
            
            
            
            Button {
                goBackToJoinScreen = true
            } label: {
                Label("", systemImage: "arrow.backward")
            }
            .font(Font.custom("GmarketSansLight", size: 27))
            .foregroundStyle(.black)
            .padding()
            .offset(x: -170, y: -610)
            
        }
        .padding()
        .background(.white)
        .fullScreenCover(isPresented: $isLoggedIn) {
            Dashboard(isLoggedIn: .constant(false))
        }
        .fullScreenCover(isPresented: $goBackToJoinScreen) {
            JoinScreen()
        }
        .alert("GitHub Sign-In Error", isPresented: .constant(!githubSignInError.isEmpty)) {
            Button("OK", role: .cancel) {
                githubSignInError = ""
            }
        } message: {
            Text(githubSignInError)
        }
    }
    
    func signIn() {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Oopsie: \(error.localizedDescription)")
            } else {
                print("Login successful")
                isLoggedIn = true
            }
        }
    }
    

    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: resetEmail) { error in
            if let error = error {
                print("Password reset error: \(error.localizedDescription)")
            } else {
                print("Password reset email sent to \(resetEmail)")
            }
        }
    }
}

#Preview {
    ContentView(email: "", password: "")
}
