import SwiftUI

import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import AuthenticationServices
import FirebaseUI

struct JoinScreen: View {
    @State private var isSignUpPresented = false
    @State private var signUpErrorMessage: String = ""
    @State private var isLoggedIn = false
    @State var userName = ""
    @State var userEmail = ""
    @State var isLogInPresented = false
    @Binding var emailCertified: String
    @State var temporaryAccessCode: String
    @State var githubAccessToken: String
    var body: some View {
        VStack {
            Image("AppIcon")
                .frame(maxWidth: .infinity)
                .padding()
                .scaledToFit()
            Image("appe")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .offset(y: -110)
            Text("The world's best way to learn a coding language, bit by bit.")
                .multilineTextAlignment(.center)
                .font(.custom("GmarketSansLight", size: 20))
            Button {
                isSignUpPresented = true
            } label: {
                Text("  Sign Up With Email              ")
            }
            .foregroundStyle(.white)
            .font(.custom("GmarketSansLight", size: 20))
            .buttonStyle(.borderedProminent)
            .offset(y: 200)
            .fullScreenCover(isPresented: $isSignUpPresented) {
                SignUpView(email: "", password: "", reenter: "", emailCertified: "", logIn: $isSignUpPresented)
            }

            Button {
                isLogInPresented = true
            } label: {
                Text("Log In With Email                    ")
            }
            .foregroundStyle(.black)
            .font(.custom("GmarketSansLight", size: 20))
            .offset(y: 210)
            .buttonStyle(.bordered)

            Text("──────── or ────────")
                .foregroundStyle(.black)
                .font(Font.custom("GmarketSansLight", size: 20))
                .multilineTextAlignment(.center)
                .bold()
                .foregroundStyle(.white)
                .offset(y: 80)
                .fullScreenCover(isPresented: $isLogInPresented) {
                    ContentView(isLogInPresented: $isLogInPresented, emailCertifiedDash: "")
                }

            Button(action: signInWithGoogle) {
                Label {
                    Text("Sign in with Google")
                        .foregroundStyle(.black)
                        .font(Font.custom("GmarketSansLight", size: 20))
                } icon: {
                    Image("Google")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }

            Button(action: cool) {
                Label {
                    Text("Sign in with Github")
                        .foregroundStyle(.black)
                        .font(Font.custom("GmarketSansLight", size: 20))
                } icon: {
                    Image("GitHub")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 40, height: 40)
                }
            }
            .offset(x: -3, y: -105)
        }
        .fullScreenCover(isPresented: $isLoggedIn) {
            Dashboard(emailCertified: emailCertified, isLoggedIn: $isLoggedIn, progress: 0, screenNum: 0)
        }
    }
    

    func startGitHubSignIn() {
                let authUI = FUIAuth.defaultAuthUI()!
                authUI.providers = [FUIGitHubAuth()]
                
                // Present the FirebaseUI sign-in screen
                authUI.delegate = self as? FUIAuthDelegate
                let authViewController = authUI.authViewController()
                UIApplication.shared.windows.first?.rootViewController?.present(authViewController, animated: true, completion: nil)
    }
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("No root view controller")
            return
        }
        
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                self.signUpErrorMessage = "Google Sign-In Error: \(error.localizedDescription)"
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                self.signUpErrorMessage = "Google Sign-In failed to retrieve tokens."
                return
            }
            let accessToken = user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.signUpErrorMessage = "\(error.localizedDescription)"
                } else {
                    print("Signed in with Google: \(authResult?.user.email ?? "unknown email")")
                    self.userName = user.profile?.name ?? ""
                    self.userEmail = user.profile?.email ?? ""
                    if let email = user.profile?.email, !email.isEmpty {
                        self.emailCertified = email
                        self.isSignUpPresented = false
                        self.isLoggedIn = true
                    } else {
                        self.signUpErrorMessage = "Email is empty; cannot proceed."
                        print("Error: Email is empty, skipping login flow to avoid Firestore crash.")
                    }
                }
            }
            
            
        }
        
        // fancy button struct
        struct ButtonView: View {
            let label: String
            let icon: String?
            
            
            init(label: String, icon: String? = nil) {
                self.label = label
                self.icon = icon
            }
            
            var body: some View {
                Button {
                    //action here
                } label: {
                    if let icon {
                        Image(systemName: icon)
                    }
                    Text(label)
                }
                .foregroundStyle(.white)
                .font(.custom("GmarketSansLight", size: 20))
                .buttonStyle(.borderedProminent)
                .offset(y: 320)
                
            }
        }
    }
}
#Preview {
    JoinScreen(emailCertified: .constant(""))
}
