//
//  MainTabView.swift
//  MVVMSwiftUICombine
//
//  Created by Robertas Baronas on 06/12/2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Users()
                .tabItem {
                    Label("Users", systemImage: "person")
                }
            Text("Posts")
                .tabItem {
                    Label("Posts", systemImage: "square.and.pencil")
                }
        }
    }
}

#Preview {
    MainTabView()
}
