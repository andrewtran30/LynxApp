
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: MainViewModel
    @Binding var courier: Bool 
    @State var deleteAccount = false
    
    var body: some View {
        
//        Toggle(isOn: $courier) {
//        Text("Courier?")
//        }.onChange(of: courier, perform:  { value in
//            viewModel.courier = courier
//        })
        
        ZStack {
            
            if(deleteAccount){
            VStack {
                Spacer()
                
                HStack{
                    
                Button {
                    deleteAccount = false
                } label: {
                    Text("**CANCEL**")
                        .font(.system(size: 10))
                        .padding()
                        .frame(width: UIScreen.main.bounds.width/2 - 50, height: 50)
                        .foregroundColor(.white)
                        .background(Color("lynxPurple"))
                }

                Button {
                    viewModel.deleteAccount()
                } label: {
                    Text("**CONFIRM DELETE**")
                        .font(.system(size: 10))
                        .padding()
                        .frame(width: UIScreen.main.bounds.width/2 - 50, height: 50)
                        .foregroundColor(.white)
                        .background(Color("lynxPurple"))
                    
                }
                }
                
                Spacer().frame(height: 5)
                
                
            }
            }
//            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
          
        VStack(spacing:0){
        Button {
            viewModel.signOut()
        } label: {
            Text("**SIGN OUT**")
                .font(.system(size: 20))
                .padding()
                .frame(width: UIScreen.main.bounds.width - 50)
                .foregroundColor(.white)
                .background(Color("lynxPurple"))
                .cornerRadius(40)
        }
        
        Button {
            deleteAccount = true
        } label: {
            Text("**DELETE ACCOUNT**")
                .font(.system(size: 10))
                .padding()
                .foregroundColor(.blue)
        }
        
            }
            
        }
    }
}
