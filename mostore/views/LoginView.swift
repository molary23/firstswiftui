//
//  ContentView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI
var loginTuple = (
    "Email Address",
    "Password",
    "Login",
    "Register"
)

struct LoginView: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("shopping")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack(content: {
                    HStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.red)
                        Text("Mo Store")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(Color.white)
                            .shadow(color: Color.black.opacity(0.8), radius: 1, x: 1, y: 2)
                    }
                    .frame(maxWidth: .infinity)

                    VStack {
                        Text(loginTuple.2)
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .fontDesign(.rounded)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                            .padding(.bottom, 20.0)
                            .shadow(color: Color.black.opacity(0.8), radius: 1, x: 1, y: 1)

                        VStack(spacing: 30, content: {
                            VStack(spacing: 15, content: {
                                TextField(loginTuple.0, text: $emailAddress)
                                    .textFieldStyle(.roundedBorder)
                                    .accessibilityLabel(loginTuple.0)
                                    .id("login__email")

                                SecureField(loginTuple.1, text: $password)
                                    .accessibilityLabel(loginTuple.1)
                                    .id("login__password")
                                    .textFieldStyle(.roundedBorder)

                            })
                            VStack(spacing: 15, content: {
                                Button(loginTuple.2) {}
                                    .padding(.vertical, 8.0)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(20)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)

                                Button(loginTuple.3) {}
                                    .padding(.vertical, 8.0)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .foregroundColor(Color.blue)
                                    .fontWeight(.bold)
                            })

                        })
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .compositingGroup()
                        .shadow(color: Color.black.opacity(0.8), radius: 1, x: 1, y: 1)
                    }

                    .padding()
                    .padding(.vertical, 20)
                    .frame(width: .infinity, height: 300)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color(#colorLiteral(red: 0.9150597453, green: 0.9150597453, blue: 0.9150597453, alpha: 0.55)))
                            .shadow(color: Color.black, radius: 10, x: 10, y: 15)
                    )

                    Rectangle()
                        .frame(height: 80)
                        .foregroundColor(Color.clear)
                })
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .background(Color.black.opacity(0.5))
            }

        }.ignoresSafeArea(.keyboard, edges: .all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
