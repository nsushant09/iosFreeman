//
//  RegistrationView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/16/23.
//

import SwiftUI

struct RegistrationView: View {
    
    private let customView = CustomViews.instance
    
    @State var fullName : String = ""
    @State var phoneNumber : String = ""
    @State var dateOfBirth : Date = Date()
    @State var gender : String = ""
    @State var email : String = ""
    @State var password : String = ""
    
    var genders = ["male", "female"]
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Text("Welcome to Freeman,\nShop With Us")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 28, weight: .semibold, design: .monospaced))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 64, trailing: 0))
                    
                    customView.inputTextField(title: "Full Name", bindingString: $fullName)
                    customView.inputTextField(title: "Phone Number", bindingString: $phoneNumber)
                    customView.datePicker(title: "Date of Birth", selection: $dateOfBirth, displayedComponents: [.date])
                    customView.menu(title: "Select Gender", selection : $gender, options: ["Male", "Female"])
                    customView.inputTextField(title: "Email", bindingString: $email)
                    customView.inputSecureField(title: "Password", bindingString: $password)
                    
                    HStack(alignment: .center, content: {
                        Text("Already have an account?")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                        Text("Login")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .underline()
                    })
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                    
                    customView.darkFilledButton(action: {}, label: {
                        Text("Create account")
                    })
                    
                    customView.darkOutlinedButton(action: {}, label: {
                        Text("Create trader account")
                    })
                }
                .padding(.all)
            }
        }
        
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
