//
//  ContentView.swift
//  Spon-Us
//
//  Created by 박현수 on 5/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("브랜돌 디자인시스템")
                .korFont(.D3KrBd)
            Text("브랜돌 디자인시스템")
                .font(.D3EnBd)
                .background(Color.statusGreenSub)
                
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
