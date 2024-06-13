//
//  SignInView.swift
//  lynx
//
//  Created by Arnav Wadehra on 6/14/22.
//

import SwiftUI

struct SignInView: View {
    @State var emailText = ""
    @State var passText = ""

    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100, alignment: .center)
                    .padding(.bottom, 10)
                
                TextField("Email", text: $emailText)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 3)
                    .autocapitalization(.none)

                SecureField("Password", text: $passText)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)
                    .autocapitalization(.none)
                
                NavigationLink("Don't have an account? **Sign Up.**", destination: SignUpView())
                    .font(.system(size: 14))
                    .foregroundColor(.blue)
                    .padding(.bottom, 12)
                
                
                Button(action: {
                    viewModel.signIn(email: emailText, password: passText)
                }) {
                    HStack {
                        Text("SIGN IN")
                        Image("SignInArrow")
                    }.font(Font.headline.weight(.heavy))
                        .padding(.horizontal, 50)
                        .padding(.vertical, 12)
                        .foregroundColor(.white)
                        .background(Color("lynxPurple"))
                        .cornerRadius(100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .frame(width: UIScreen.main.bounds.width - 30, height: 50, alignment: .center)
                }
                
            }
            .padding(.bottom, UIScreen.main.bounds.height / 2)
            .padding(.top, UIScreen.main.bounds.height / 3)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
