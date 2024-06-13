//
//  ProfileView.swift
//  lynx
//
//  Created by Arnav Wadehra on 6/14/22.
//

import SwiftUI
import Kingfisher



struct ProfileView: View {
    let user: User
    @EnvironmentObject var viewModel: MainViewModel
    @Binding var courier: Bool 
    
    var body: some View {
        VStack {

            Spacer()
            Group{
            Text("\(user.firstname) \(user.lastname)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(1)
            
            Text("Class of " + "\(user.classyear)")
                .font(.title3)
                .italic()
                .padding(2)
            
//            Text("Lynx Balance " + "\(user.balance)")
//                .font(.title3)
//                .italic()
//                .padding(2)
            
                Text("\(user.phonenumber.applyPatternOnNumbers(pattern: "(###) ###-####", replacementCharacter: "#"))")
                .font(.title2)
                .padding(2)
            }
            Divider()
                .frame(width: UIScreen.main.bounds.width - 100, height: 50)
            if(!viewModel.courier){
                HStack {
                    VStack{
                        Text("$\(Double(user.balance) / 100.0, specifier: "%.2f")")
                            .font(.title)
                            .font(.custom("Avenir", size: 18))
                            .padding(.bottom, 10)
                        Text("Current Lynx Balance")
                            .fontWeight(.light)
                            .font(.custom("Avenir", size: 18))
                    }
                }
            } else {
         
                HStack {
                    VStack{
                        Text("$\(Double(Double(user.courierBalance)/100.0), specifier: "%.2f")")
                            .font(.title)
                            .font(.custom("Avenir", size: 18))
                            .padding(.bottom, 10)
                        Text("Current Courier Earnings")
                            .fontWeight(.light)
                            .font(.custom("Avenir", size: 18))
                    }

                }
            }
            
            Divider().frame(width: UIScreen.main.bounds.width - 100, height: 50)
            
            
            
            Toggle(isOn: $courier) {
                Text("Courier Status")
                    .padding(.leading, 25)
                    .font(.custom("Avenir", size: 18))
            }.onChange(of: courier, perform:  { value in
                viewModel.courier = courier
            }).padding(.trailing, 25)
            Spacer()
            
            if (!viewModel.courier) {
                NavigationLink(destination: AddFundsView()) {
                    Text("**ADD FUNDS**")
                        .font(.system(size: 15))
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 50)
                        .foregroundColor(.white)
                        .background(Color("lynxPurple"))
                        .cornerRadius(40)
                        .padding(.bottom, 30)
                }.onAppear {
                    viewModel.fetchUser()
                }
            } else {
                NavigationLink(destination: WithdrawFundsView(viewModel: viewModel, user: user)) {
                    Text("**WITHDRAW EARNINGS**")
                        .font(.system(size: 15))
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 50)
                        .foregroundColor(.white)
                        .background(Color("courierTheme"))
                        .cornerRadius(40)
                        .padding(.bottom, 30)
                }
            }
            
            
            
            
        }.toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                NavigationLink(destination: SettingsView(courier: $courier)) {
                    Image(systemName: "gearshape.fill").padding()
                    }
                }
            }
        }
    }


extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}
