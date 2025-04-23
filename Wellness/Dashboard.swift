//
//  Dashboard.swift
//  Wellness
//
//  Created by Aarnav Dhir on 4/20/25.
//

import SwiftUI

struct Dashboard: View {
    @Binding var isLoggedIn: Bool

    var body: some View {
        HStack {
            Button("Logout") {
                isLoggedIn = false
            }
        }
        .padding()
    }
}

#Preview {
    Dashboard(isLoggedIn: .constant(false))
}
func LogIn() {
    
}
