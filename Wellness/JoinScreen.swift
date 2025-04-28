import SwiftUI

import FirebaseAuth
import FirebaseCore
import GoogleSignIn

struct JoinScreen: View {
    @State private var signUpOrNot = false
    @State private var signUpErrorMessage: String = ""
    @State private var isLoggedIn = false
    @State var userName = ""
    @State var userEmail = ""
    var body: some View {
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
            signUpOrNot = true
        } label: {
            Text("  Sign Up With Email              ")
        }
        .foregroundStyle(.white)
        .font(.custom("GmarketSansLight", size: 20))
        .buttonStyle(.borderedProminent)
        .offset(y: 200)
        .fullScreenCover(isPresented: $signUpOrNot) {
            SignUpView(email: "", password: "", reenter: "", logIn: $signUpOrNot)
        }
        
        Button {
            
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
        .fullScreenCover(isPresented: $isLoggedIn) {
            Dashboard(isLoggedIn: $isLoggedIn, userName: $userName, userEmail: $userEmail)
        }
    }
    func cool() {
        
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
                    self.signUpOrNot = false
                    self.isLoggedIn = true
                    userName = user.profile?.name ?? ""
                    userEmail = user.profile?.email ?? ""
                    
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
    JoinScreen()
}
