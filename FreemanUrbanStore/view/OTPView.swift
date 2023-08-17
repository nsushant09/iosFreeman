//
//  OTPView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct OTPView: View {
    
    private let customView : CustomViews = CustomViews.instance
    @State var otpValue : String = ""
    
    @State var navigateMainView = false
    
    var body: some View {
        NavigationStack{
            
            Navigator.navigate(bindingBoolean: $navigateMainView, destination: MainView())
            
            VStack{
                Spacer()
                
                Image("LogoDark")
                    .resizable()
                    .scaledToFit()
                    .padding(.all)
                
                Text("OTP has been sent to your email")
                    .frame(maxWidth: .infinity, alignment:.leading)
                    .font(.system(.body, design: .rounded))
                    .padding(.leading)
                
                customView.inputTextField(title: "OTP", bindingString: $otpValue)
                customView.darkFilledButton(action: {
                    navigateMainView = true
                }, label: {
                    Text("Verify")
                        .frame(maxWidth: .infinity)
                })
                
                Spacer()
            }
            .padding(.all)
        }
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}
