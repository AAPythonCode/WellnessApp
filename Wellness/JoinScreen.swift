import SwiftUI

struct JoinScreen: View {
    var body: some View {
        Image("AppIcon")
            .frame(maxWidth: .infinity)
            .padding()
            .scaledToFit()
        Text("The world's best way to learn a coding language, bit by bit.")
            .multilineTextAlignment(.center)
            .font(.custom("GmarketSansLight", size: 20))
        Button {
            // action
        } label: {
            Text("  Get Started                           ")
        }
        .foregroundStyle(.white)
        .font(.custom("GmarketSansLight", size: 20))
        .buttonStyle(.borderedProminent)
        .offset(y: 300)
        
        
        Button {
            // action
        } label: {
            Text(" I already have an account ")
        }
        .foregroundStyle(.black)
        .font(.custom("GmarketSansLight", size: 20))
        .offset(y: 310)
        .buttonStyle(.bordered)
 
    }
}
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
#Preview {
    ContentView(email: "", password: "")
}
