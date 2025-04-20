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
            Text("Bit by Bit")
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                .bold()
                .foregroundColor(.white)
                .font(Font.custom(
                    "Gill Sans", size: 27
                ))
            Text("Get started with your ultimate coding journey! Let's. Get. Started. ")
                .font(.title2)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                .bold()
                .foregroundColor(.white)
                .font(Font.custom(
                    "Gill Sans", size: 27
                ))
            
            Image(systemName: "")
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
                .foregroundStyle(.white)
            
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
            
            Button(action: signUp) {
                Label("Sign Up", systemImage: "arrow.up")
            }
            .padding()
            .foregroundStyle(.white)
            .background(isFormValid ? Color.black : Color.gray)
            .cornerRadius(32)
            .disabled(!isFormValid)
            
            
            .background(.white)
            .cornerRadius(32)
            .shadow(radius: 32)
            if !signUpErrorMessage.isEmpty {
                Text(signUpErrorMessage)
                    .font(Font.custom("Gill Sans Light", size: 20))
                    .foregroundStyle(.white)
            }
            Button(action: logInBack) {
                Label {
                    Text("Sign in with Google")
                        .font(Font.custom("Gill Sans Light", size: 20))
                } icon: {
                    Image("Google")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            .foregroundStyle(.white)
        }
        .padding()
        .background(
            Image("coder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 2010, height: 950)
        )
    }
    
    @ViewBuilder
    func validationMessage() -> some View {
        if password.count < 1 {
            Text("Please enter a password.")
                .font(Font.custom("Gill Sans Light", size: 20))
                .foregroundStyle(.white)
        } else if password.count <= 3 {
            Text("Password should be more than 6 characters.")
                .font(Font.custom("Gill Sans Light", size: 20))
                .foregroundStyle(.white)
        } else if password.count > 20 {
            Text("Password should be less than 20 characters.")
                .font(Font.custom("Gill Sans Light", size: 20))
                .foregroundStyle(.white)
        } else if reenter != password {
            Text("Passwords do not match.")
                .font(Font.custom("Gill Sans Light", size: 20))
                .foregroundStyle(.white)
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
        #Preview {
            SignUpView(email: "", password: "", reenter: "", logIn: .constant(false))
        }
    }
}
