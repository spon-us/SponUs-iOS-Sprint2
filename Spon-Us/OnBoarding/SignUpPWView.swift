//
//  SignUpPWView.swift
//  Spon-Us
//
//  Created by 김수민 on 7/2/24.
//

import SwiftUI

struct SignUpPWView: View {
    @State var id: String
    @State private var password: String = ""
    @State private var isSecured: Bool = true

    var body: some View {
        HStack {
            if isSecured {
                SecureField("Password", text: $password)
                    .padding()
            } else {
                TextField("Password", text: $password)
                    .padding()
            }
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 10)
        }
    }
}

#Preview {
    SignUpPWView(id: "")
}
