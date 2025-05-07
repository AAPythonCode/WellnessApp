import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore

struct ContentView: View {
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    @State private var signUpErrorMessage: String = ""
    @State private var isResetPasswordAlertVisible: Bool = false
    @State private var resetEmailAddress: String = ""
    @State private var isUserLoggedIn: Bool = false
    @State private var loginErrorMessage: String = ""
    @State private var githubSignInErrorMessage: String = ""
    @State private var shouldReturnToJoinScreen: Bool = false
    @Binding var isLogInPresented: Bool
    @State var emailCertifiedDash: String

    var body: some View {
        VStack {
            Text("Welcome back to your coding journey!")
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

            TextField("Enter email", text: $userEmail)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom("GmarketSansLight", size: 27))
                .padding(.bottom, 5)
                .padding()

            TextField("Enter password", text: $userPassword)
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
            .foregroundStyle(.white)
            .background(.black)
            .cornerRadius(32)

            Button("Forgot Password?") {
                isResetPasswordAlertVisible = true
            }
            .foregroundStyle(.black)
            .padding()
            .sheet(isPresented: $isResetPasswordAlertVisible) {
                VStack {
                    Text("Reset your password. ")
                        .font(Font.custom("GmarketSansLight", size: 35))
                        .multilineTextAlignment(.center)
                        .bold()
                        .foregroundStyle(.black)
                        .padding()

                    Text("Don't worry, we all forget sometimes! 😅")
                        .font(Font.custom("GmarketSansLight", size: 23))
                        .multilineTextAlignment(.center)
                        .bold()
                        .foregroundStyle(.black)
                        .padding()
                    TextField("Enter your email (it should be valid)", text: $resetEmailAddress)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .font(Font.custom("GmarketSansLight", size: 15))

                    Button("Send Reset Email (Check Your Inbox)") {
                        resetPassword()
                        isResetPasswordAlertVisible = false
                    }
                    .buttonStyle(.borderedProminent)
                    .font(Font.custom("GmarketSansLight", size: 15))
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
                    

                    Text("(Swipe down to close this menu.)")
                        .multilineTextAlignment(.center)
                        .padding()
                        .tint(.gray)
                        .font(Font.custom("GmarketSansLight", size: 15))
                }
                .padding()
            }

            Button {
                isLogInPresented = false
            } label: {
                Label("", systemImage: "arrow.backward")
            }
            .font(Font.custom("GmarketSansLight", size: 27))
            .foregroundStyle(.black)
            .padding()
            .offset(x: -170, y: -571)

        }
        .padding()
        .background(.white)
        .fullScreenCover(isPresented: $isUserLoggedIn) {
            Dashboard(emailCertified: emailCertifiedDash, isLoggedIn: $isUserLoggedIn, progress: 0, screenNum: 0)
        }
        .alert("GitHub Sign-In Error", isPresented: .constant(!githubSignInErrorMessage.isEmpty)) {
            Button("OK", role: .cancel) {
                githubSignInErrorMessage = ""
            }
        } message: {
            Text(githubSignInErrorMessage)
        }
    }

    func signIn() {
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { result, error in
            if let error = error {
                print("Oopsie: \(error.localizedDescription)")
            } else {
                print("Login successful")
                if let user = result?.user {
                    let fetchedEmail = user.email ?? ""
                    print("Firebase returned email: \(fetchedEmail)")
                    emailCertifiedDash = fetchedEmail
                    isUserLoggedIn = true
                    print("Updated emailCertified: \(emailCertifiedDash)")
                }
            }
        }
    }

    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: resetEmailAddress) { error in
            if let error = error {
                print("Password reset error: \(error.localizedDescription)")
            } else {
                print("Password reset email sent to \(resetEmailAddress)")
            }
        }
    }
}

#Preview {
    ContentView(isLogInPresented: .constant(false), emailCertifiedDash: "")
}
