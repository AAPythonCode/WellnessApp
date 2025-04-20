import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct ContentView: View {
    @State var email: String
    @State var password: String
    @State var logIn: Bool = false
    @State private var signUpErrorMessage: String = ""

    var body: some View {
        VStack {
            Text("Bit By Bit")
                .font(Font.custom("Gill Sans Light", size: 50))
                .multilineTextAlignment(.center)
                .bold()
                .foregroundStyle(.white)
                .padding()
                .offset(y: -30)

            Text("Welcome back to your coding journey.")
                .font(Font.custom("Gill Sans Light", size: 20))
                
                .multilineTextAlignment(.center)
                .bold()
                .foregroundStyle(.white)
                .padding()
                .offset(y: -50)

            Text("Log in with email")
                .font(Font.custom("Gill Sans Light", size: 27))
                .bold()
                .foregroundStyle(.white)
                .offset(y: -50)

            TextField("Enter email", text: $email)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom("Gill Sans Light", size: 27))
                .padding(.bottom, 5)
                .offset(y: -55)

            TextField("Enter password", text: $password)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom("Gill Sans Light", size: 27))
                .padding(.bottom, 5)
                .offset(y: -50)

            Button(action: signIn) {
                Label("Log In", systemImage: "arrow.up")
            }
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .cornerRadius(32)

            Button(action: resetPassword) {
                Label("Forgot Password?", systemImage: "person.badge.key")
            }
            .offset(y: 30)

            Text("Or, sign in with one of our sign-in providers.")
                .font(Font.custom("Gill Sans Light", size: 20))
                .multilineTextAlignment(.center)
                .bold()
                .foregroundStyle(.white)
                .padding(.top, 50)

            Button(action: signInWithGoogle) {
                Label {
                    Text("Sign in with Google")
                        .font(Font.custom("Gill Sans Light", size: 20))
                } icon: {
                    Image("Google")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            Button(action: signInWithGithub) {
                Label {
                    Text("Sign in with Github")
                        .font(Font.custom("Gill Sans Light", size: 20))
                } icon: {
                    Image("github")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            .foregroundStyle(.white)

            Button {
                logIn = true
            } label: {
                Label("...or sign up with email", systemImage: "none")
            }
            .offset(y: 50)
            .offset(x: -9)
        }
        .padding()
        .background(
            Image("coder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 2010, height: 950)
        )
        .fullScreenCover(isPresented: $logIn) {
            SignUpView(email: "", password: "", reenter: "", logIn: $logIn)
        }
    }

    func signIn() {
        self.logIn.toggle()
    }

    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            print("No root view controller")
            return
        }

        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                signUpErrorMessage = "Google Sign-In Error: \(error.localizedDescription)"
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                signUpErrorMessage = "Google Sign-In failed to retrieve tokens."
                return
            }
            let accessToken = user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    signUpErrorMessage = "Firebase Auth Error: \(error.localizedDescription)"
                } else {
                    print("Signed in with Google: \(authResult?.user.email ?? "unknown email")")
                    self.logIn.toggle()
                }
            }
        }
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

func signInWithGithub() {
    var provider = OAuthProvider(providerID: "github.com")
    provider.getCredentialWith(nil) { credential, error in
        if let error = error {
            print("GitHub credential error: \(error.localizedDescription)")
            return
        }
        guard let credential = credential else {
            print("GitHub credential is nil.")
            return
        }
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("GitHub sign-in error: \(error.localizedDescription)")
                return
            }
            guard authResult != nil else {
                print("Auth result is nil.")
                return
            }
            // User is signed in.
            // IdP data available in authResult.additionalUserInfo.profile.
            // GitHub OAuth access token can also be retrieved by:
            // authResult.credential?.accessToken
            // GitHub OAuth ID token can be retrieved by calling:
            // authResult.credential?.idToken
        }
    }
}

#Preview {
    ContentView(email: "", password: "")
}
