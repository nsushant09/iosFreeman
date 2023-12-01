//
//  RegistrationView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/16/23.
//

import SwiftUI

struct RegistrationView: View {
    
    private let customView = CustomViews.instance
    
    @StateObject var registrationViewModel = RegistrationViewModel()
    
    @State var fullName : String = ""
    @State var phoneNumber : String = ""
    @State var dateOfBirth : Date = Date()
    @State var gender : String = "Male"
    @State var email : String = ""
    @State var password : String = ""
    
    @State var userDetailResponse : User? = nil
    @State var allUsers : [User]? = nil
    
    @State var navigateToOtpPage = false
    @State var otpView : OTPView?
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
        NavigationStack{
            
            Navigator.navigate(
                bindingBoolean: $navigateToOtpPage,
                destination: otpView
            )
            
            ScrollView{
                VStack{
                    Text("Welcome to Freeman,\nShop With Us")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 28, weight: .semibold, design: .monospaced))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 64, trailing: 0))
                    
                    inputFields()
                    
                    if(!registrationViewModel.errorMessage.isEmpty){
                        customView.errorMessage(registrationViewModel.errorMessage)
                    }
                    
                    loginOptionText()
                    processingButtons()
                }
                .padding()
            }
        }
        .onReceive(registrationViewModel.$navigateToOtpPage, perform: { boolean in
            if(boolean && registrationViewModel.userDetail != nil){
                otpView = OTPView(
                    authenticationKey: registrationViewModel.authenticationKey,
                    user: registrationViewModel.userDetail!
                )
                navigateToOtpPage = boolean
            }
        })
        .navigationBarBackButtonHidden(true)
        
    }
    
    static private var instance : RegistrationView? = nil
    static func getInstance() -> RegistrationView{
        if(RegistrationView.instance == nil){
            RegistrationView.instance = RegistrationView()
        }
        return RegistrationView.instance!
    }
    
    func inputFields() -> some View{
        Group{
            customView.inputTextField(
                title: "Full Name",
                bindingString: $fullName
            )
            
            
            customView.inputTextField(
                title: "Phone Number",
                bindingString: $phoneNumber
            )
            
            customView.datePicker(
                title: "Date of Birth",
                selection: $dateOfBirth,
                displayedComponents: [.date],
                inRange: ...Calendar.current.startOfDay(for: Date())
            )
            customView.menu(
                title: "Select Gender",
                selection : $gender,
                options: ["Male", "Female"]
            )
            
            customView.inputTextField(
                title: "Email",
                bindingString: $email
            )
            
            customView.inputSecureField(
                title: "Password",
                bindingString: $password
            )
        }
    }
    
    func loginOptionText() -> some View{
        HStack(alignment: .center, content: {
            Text("Already have an account?")
                .font(.system(
                    size: 14,
                    weight: .regular,
                    design: .rounded)
                )
            
            NavigationLink(destination: LoginView.getInstance(), label: {
                Text("Login")
                    .font(.system(
                        size: 16,
                        weight: .semibold,
                        design: .rounded)
                    )
                    .underline()
            })
        })
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
    }
    
    func processingButtons() -> some View{
        VStack{
            customView.darkFilledButton(action: {
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let user = User(
                    id: -1,
                    name: fullName,
                    email: email,
                    gender: gender,
                    password: password,
                    phoneNumber: phoneNumber,
                    dateOfBirth: dateFormatter.string(from : dateOfBirth),
                    role: "USER"
                )
                
                Task{
                    await registrationViewModel.registerUser(user:user)
                }
                
            }, label: {
                Text(registrationViewModel.createAccountText)
            })
            
            customView.darkOutlinedButton(action: {
                //                        TODO : Navigate to another view
            }, label: {
                Text("Create trader account")
            })
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
