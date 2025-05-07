import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore

struct SignUpView: View {
    @State var email: String
    @State var password: String
    @State var reenter: String
    @State var emailCertified: String
    @State private var signUpErrorMessage: String = ""
    @Binding var logIn: Bool
    @State private var showDashboard = false
    
    var isFormValid: Bool {
        return !email.isEmpty &&
        password.count > 3 &&
        password.count <= 20 &&
        password == reenter
    }
    var body: some View {
        
        VStack(spacing: 20) {
            Text("Start your coding journey, bit by bit!")
                .font(Font.custom("GmarketSansLight", size: 35))
                .multilineTextAlignment(.center)
                .bold()
                .foregroundStyle(.black)
                .padding()

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
                    "GmarketSansLight", size: 27
                ))
                .foregroundStyle(.black)
            
            TextField("Enter email", text: $email)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom(
                    "GmarketSansLight", size: 27
                ))
            SecureField("Enter password", text: $password)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom(
                    "GmarketSansLight", size: 27
                ))
            
            SecureField("Re-enter password", text: $reenter)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(width: 380)
                .textFieldStyle(.roundedBorder)
                .font(Font.custom(
                    "GmarketSansLight", size: 27
                ))
            
            validationMessage()
            
            Button(action: signUp) {
                Label("Sign Up", systemImage: "arrow.up")
            }
            .padding()
            .font(Font.custom("GmarketSansLight", size: 15))
            .foregroundStyle(.white)
            .background(isFormValid ? Color.black : Color.gray)
            .cornerRadius(32)
            .disabled(!isFormValid)
            .background(.white)
            .cornerRadius(32)

            if !signUpErrorMessage.isEmpty {
                Text(signUpErrorMessage)
                    .font(Font.custom("GmarketSansLight", size: 20))
                    .foregroundStyle(.black)
            }
            Button(action: logInBack) {
                Label("", systemImage: "arrow.backward")
                    .font(Font.custom("GmarketSansLight", size: 27))
            }
            .foregroundStyle(.black)
            .offset(x: -170, y: -670)

        }
        .padding()
        .background(.white)
        .fullScreenCover(isPresented: $showDashboard) {
            ContentView(isLogInPresented: .constant(false), emailCertifiedDash: "")
        }
    }
    
    @ViewBuilder
    func validationMessage() -> some View {
        if password.count < 1 {
            Text("Please enter a password.")
                .font(Font.custom("GmarketSansLight", size: 20))
                .foregroundStyle(.black)
        } else if password.count < 6 {
            Text("Password should be more than 6 characters.")
                .font(Font.custom("GmarketSansLight", size: 20))
                .foregroundStyle(.black)
        } else if password.count > 20 {
            Text("Password should be less than 20 characters.")
                .font(Font.custom("GmarketSansLight", size: 20))
                .foregroundStyle(.black)
        } else if reenter != password {
            Text("Passwords do not match.")
                .font(Font.custom("GmarketSansLight", size: 20))
                .foregroundStyle(.black)
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
                let db = Firestore.firestore()
                print("Account created for: \(result?.user.email ?? "unknown email")")
                guard let email = result?.user.email, !email.isEmpty else {
                    print("Error: email is empty, skipping Firestore call.")
                    return
                }
                self.emailCertified = email
                print("email: \(self.emailCertified)")
                db.collection("users").document(self.emailCertified).setData([
                    "email": self.emailCertified,
                    "createdAt": Timestamp(date: Date()),
                    "firstName": "",
                    "lastName": ""
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    } else {
                        print("Document successfully written!")
                        self.showDashboard = true
                    }
                }
            }
        }
    }
}
#Preview {
    SignUpView(email: "", password: "", reenter: "", emailCertified: "", logIn: .constant(false))
}
