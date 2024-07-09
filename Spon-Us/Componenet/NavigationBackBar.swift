//
//  NavigationBackBar.swift
//  Spon-Us
//
//  Created by 김수민 on 7/2/24.
//

import SwiftUI

struct NavigationBackBar: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack(){
            Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
                Image("icLeft")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(6)
            })
            .padding(.leading, 5)
            .padding(.vertical, 8)
            Spacer()
        }
    }
}

#Preview {
    NavigationBackBar()
}
