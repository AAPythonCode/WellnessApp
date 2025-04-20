import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct ContentView: View {
    @State var email: String
    @State var password: String
    @State var logIn: Bool = false
    @State private var signUpErrorMessage: String = ""
    @State private var showingResetAlert = false
    @State private var resetEmail: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var loginError: String = ""
    
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
            
            Button("Forgot Password?") {
                showingResetAlert = true
            }
            .foregroundStyle(.white)
            .offset(y: 30)
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
                }
                .padding()
            }
            
            Text("─────── or ───────")
                .font(Font.custom("Gill Sans Light", size: 20))
                .multilineTextAlignment(.center)
                .bold()
                .foregroundStyle(.white)
                .padding(.top, 50)
            
            Button(action: signInWithGoogle) {
                Label {
                    Text("Sign in with Google")
                        .foregroundStyle(.white)
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
            .font(Font.custom("Gill Sans Light", size: 27))
            .foregroundStyle(.white)
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
        .fullScreenCover(isPresented: $isLoggedIn) {
            Dashboard(isLoggedIn: .constant(false))
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
    
    func signInWithGithub() {
        let provider = OAuthProvider(providerID: "github.com")
        provider.scopes = ["user:email"]
        provider.customParameters = [
            "allow_signup": "false"
        ]

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
                guard let authResult = authResult else {
                    print("Auth result is nil.")
                    return
                }
                print("Signed in with GitHub: \(authResult.user.email ?? "unknown email")")
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
