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
    @State var gender : String = "Male"
    @State var email : String = ""
    @State var password : String = ""
    
    @State var userDetailResponse : User? = nil
    @State var allUsers : [User]? = nil
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
        NavigationStack{
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
                        
                        NavigationLink(destination: LoginView.getInstance(), label: {
                            Text("Login")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .underline()
                        })
                    })
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                    
                    customView.darkFilledButton(action: {
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        
                        let user = User(id: 0, name: "test", email: "testmail2", gender: gender, password: password, phoneNumber: phoneNumber, dateOfBirth: dateFormatter.string(from : dateOfBirth), role: "user")
                        
                        let postReq = HTTPRequestExecutor<User, User>
                            .Builder()
                            .setRequestUrl("http://localhost:8080/user/")
                            .setBindingResponse($userDetailResponse)
                            .setRequestBody(user)
                            .setHttpMethod(HTTPMethods.POST)
                            .build()
                        
                        postReq.execute()
                        
                    }, label: {
                        Text("Create account")
                    })

                    customView.darkOutlinedButton(action: {
                        let req = HTTPRequestExecutor<User, [User]>
                            .Builder()
                            .setRequestUrl("http://localhost:8080/user/all")
                            .setHttpMethod(HTTPMethods.GET)
                            .build()
                        
                        req.execute()
                            
                    }, label: {
                        Text("Create trader account")
                    })
                }
                .padding(.all)
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    static private var instance : RegistrationView? = nil
    static func getInstance() -> RegistrationView{
        if(RegistrationView.instance == nil){
            RegistrationView.instance = RegistrationView()
        }
        return RegistrationView.instance!
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
