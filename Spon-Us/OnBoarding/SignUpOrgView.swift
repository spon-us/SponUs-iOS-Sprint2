//
//  SignUpOrgView.swift
//  Spon-Us
//
//  Created by 김수민 on 7/3/24.
//

import SwiftUI

struct SignUpOrgView: View {
    @ObservedObject var vm: SignUpViewModel
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    SignUpOrgView(vm: SignUpViewModel())
}
