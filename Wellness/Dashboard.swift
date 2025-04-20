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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                self.isLoggedIn.toggle()
            }
    }
}

#Preview {
    Dashboard(isLoggedIn: .constant(false))
}
