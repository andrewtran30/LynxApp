//
//  OnBoarding.swift
//  Food
//
//  Created llby BqNqNNN on 7/12/20.
//

import SwiftUI
import UIKit


struct OnBoarding: View {
    @EnvironmentObject var viewModel: MainViewModel
    @State var showSheetView = false
    var email: String
    var password: String
    var phonenumber: String
    var firstname: String
    var lastname: String
    var gender: String
    var classyear: String
    init(email: String, password: String, phonenumber: String, firstname: String, lastname: String, gender: String, classyear: String) {
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        self.email = email
        self.password = password
        self.phonenumber = phonenumber
        self.firstname = firstname
        self.lastname = lastname
        self.gender = gender
        self.classyear = classyear
        }
    
    var body: some View {
        pages(email: email, password: password, phonenumber: phonenumber, firstname: firstname, lastname: lastname, gender: gender, classyear: classyear)
    }
    
}



struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding(email: "email@email.com", password: "1234567890", phonenumber: "1234567890", firstname: "1234567890", lastname: "1234567890", gender: "1234567890", classyear: "1234567890")
    }
}


struct pages: View {
    @EnvironmentObject var viewModel: MainViewModel
    var email: String
    var password: String
    var phonenumber: String
    var firstname: String
    var lastname: String
    var gender: String
    var classyear: String
    var body: some View {
        VStack {
            TabView {
                ForEach(Data) { page in
                    GeometryReader { g in
                        VStack {
                            Image(page.image)
                                .resizable()
                                .scaledToFit()
                            Text(page.title)
                                .font(.title).bold()
                                .padding(.all, 20)
                            Text(page.descrip)
                                .multilineTextAlignment(.center)
                                .padding(.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10)
                        }
                        .opacity(Double(g.frame(in : . global).minX)/200+1)
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .background(Color(.white))
            
            Button {
                viewModel.signUp(email: email, password: password, phonenumber: phonenumber, firstname: firstname, lastname: lastname, gender: gender, classyear: classyear)
            } label: {
                Text("Start")
                    .font(.headline)
                    .frame(width: 200, height: 40, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                    .cornerRadius(10)
            }

            Spacer()
            
        }
        .navigationBarItems(trailing: Button(action: {
            viewModel.signUp(email: email, password: password, phonenumber: phonenumber, firstname: firstname, lastname: lastname, gender: gender, classyear: classyear)
        }, label: {
            Image(systemName: "arrow.right")
                .font(Font.system(.title3))
                .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
        }))
        .navigationBarBackButtonHidden(true)
    }
}



//NavigationLink(
//    destination: // Location().navigationBarBackButtonHidden(true).navigationBarHidden(true),
//    label: {
//        Image(systemName: "arrow.right")
//            .font(Font.system(.title3))
//            .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
//    })
