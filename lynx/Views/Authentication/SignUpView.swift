//
//  SignUpView.swift
//  lynx
//
//  Created by Arnav Wadehra on 6/14/22.
//

import SwiftUI

struct SignUpView: View {
    @State var usertext = ""
    @State var passText = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var phonenumber = ""
    @State var classyear = ""
    @State var gender = ""
    @State private var showAlert = false
    @State private var isDisabled = true
    
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("First Name", text: $firstName)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)
                
                TextField("Last Name", text: $lastName)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)
                
                TextField("Email (@virginia.edu)", text: $usertext)
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

                SecureField("Password (Min. 6 characters)", text: $passText)
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
           
                TextField("Phone Number (10 Digits)", text: $phonenumber)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)
                
                TextField("Class Year", text: $classyear)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)
                
                TextField("Gender", text: $gender)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)


                NavigationLink(destination: OnBoarding(email: usertext, password: passText, phonenumber: phonenumber, firstname: firstName, lastname: lastName, gender: gender, classyear: classyear)) {
                    
                    Text("SIGN UP")
                        .font(Font.headline.weight(.heavy))
                            .padding(.horizontal, 100)
                            .padding(.vertical, 12)
                            .foregroundColor(.white)
                            .background(!(!firstName.isEmpty && !lastName.isEmpty && usertext.contains("@virginia.edu") && passText.count >= 6 && phonenumber.count == 10 && !classyear.isEmpty && !gender.isEmpty) ? .gray : Color("lynxPurple"))
                            .cornerRadius(100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.gray, lineWidth: 1))
                }.disabled(!(!firstName.isEmpty && !lastName.isEmpty && usertext.contains("@virginia.edu") && passText.count >= 6 && phonenumber.count == 10 && !classyear.isEmpty && !gender.isEmpty))
            }
        }
    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}

struct Previews_SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
