//
//  AccountView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct AccountView: View {
    
    @State var navigateAddProductView = false
    @State var navigateLoginView = false
    
    let customView = CustomViews.instance
    
    var body: some View {
        NavigationStack{
            
            Navigator.navigate(
                bindingBoolean: $navigateAddProductView,
                destination: AddProductView()
            )
            Navigator.navigate(
                bindingBoolean: $navigateLoginView,
                destination: LoginView()
            )
            
            VStack{
                customView.darkFilledButton(action: {
                    navigateAddProductView = true
                }, label: {
                    Text("Add Product")
                })
                
                customView.errorButton(action: {
                    if (ApplicationCache.logOut()){
                        navigateLoginView = true
                    }
                }, label: {
                    Text("Log Out")
                })
            }
            .padding()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
