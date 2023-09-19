//
//  HomeView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-15.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeController = HomeController()
    @StateObject var cartManager = CartManager()
    var body: some View {
        if !homeController.currentUserId.isEmpty && homeController.isSignedIn {
            ProductView()
                .environmentObject(CartManager())
        } else {
            LoginView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
