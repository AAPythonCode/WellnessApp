import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct SignUpView: View {
    @State var email: String
    @State var password: String
    @State var reenter: String
    @State private var signUpErrorMessage: String = ""
    @Binding var logIn: Bool
    
    var isFormValid: Bool {
        return !email.isEmpty &&
               password.count > 3 &&
               password.count <= 20 &&
               password == reenter
    }
    var body: some View {
        VStack {
            Text("Welcome to the Wellness App")
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                .bold()
                .foregroundColor(.white)
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
            Text("Sign Up")
                .font(Font.custom(
                    "Gill Sans Light", size: 27
                ))
                .foregroundStyle(.green)

            TextField("Enter email", text: $email)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom(
                    "Gill Sans Light", size: 27
                ))
            SecureField("Enter password", text: $password)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom(
                    "Gill Sans Light", size: 27
                ))
            
            SecureField("Re-enter password", text: $reenter)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom(
                    "Gill Sans Light", size: 27
                ))

            validationMessage()
            Button(action: signInWithGoogle) {
                Image("Google")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .padding()
            }
            .background(.white)
            .cornerRadius(32)
            .shadow(radius: 32)
            Button(action: signUp) {
                Label("Sign Up", systemImage: "arrow.up")
            }
            .padding()
            .foregroundStyle(.blue)
            .background(isFormValid ? Color.green : Color.gray)
            .cornerRadius(32)
            .disabled(!isFormValid)

            if !signUpErrorMessage.isEmpty {
                Text(signUpErrorMessage)
                    .font(Font.custom("Gill Sans Light", size: 20))
                    .foregroundStyle(.green)
            }
            Button(action: logInBack) {
                Label("...or log in", systemImage: "none")
            }
            .foregroundColor(.green)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
    }
    
    @ViewBuilder
    func validationMessage() -> some View {
        if password.count < 1 {
            Text("Please enter a password.")
                .font(Font.custom("Gill Sans Light", size: 20))
                .foregroundStyle(.green)
        } else if password.count <= 3 {
            Text("Password should be more than 6 characters.")
                .font(Font.custom("Gill Sans Light", size: 20))
                .foregroundStyle(.green)
        } else if password.count > 20 {
            Text("Password should be less than 20 characters.")
                .font(Font.custom("Gill Sans Light", size: 20))
                .foregroundStyle(.green)
        } else if reenter != password {
            Text("Passwords do not match.")
                .font(Font.custom("Gill Sans Light", size: 20))
                .foregroundStyle(.green)
        }

    }
    
    func logInBack() {
        self.logIn.toggle()
        print("hi")
    }
    func signUp() {
        print("Sign up button tapped")
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                signUpErrorMessage = "Sign Up Error: \(error.localizedDescription)"
                
            } else {
                print("Account created for: \(result?.user.email ?? "unknown email")")
                self.logIn.toggle()
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
}

#Preview {
    SignUpView(email: "", password: "", reenter: "", logIn: .constant(false))
}
