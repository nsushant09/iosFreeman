//
//  AccountView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct AccountView: View {
    
    private let user = ApplicationCache.loggedInUser
    
    @State var navigateAddProductView = false
    @State var navigateLoginView = false
    private let contents = ["Payment Center", "Account Setting", "Help", "Feedback"]
    
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
                toolbar
                userSummary
                Rectangle()
                    .frame(height:2)
                    .foregroundColor(.gray)
                extraContents
                
                Spacer()
                VStack{
                    addProduct
                    logout
                }.padding()
            }
        }
    }
    
    var extraContents : some View {
        VStack(alignment:.leading){
            ForEach(contents, id: \.self) {
                Text($0)
                    .foregroundColor(.accentColor)
                    .font(.system(size: 18, weight: .medium))
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                
                Rectangle()
                    .frame(height:1)
                    .foregroundColor(.accentColor)
            }
        }
    }
    
    var userSummary : some View{
        HStack{
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 64, weight: .semibold))
            
            VStack(alignment: .leading, spacing : 8){
                Text("Sushant Neupane")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 24, weight: .semibold))
                
                Text("View / Edit Profile")
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
    }
    
    var addProduct : some View{
        customView.darkFilledButton(action: {
            navigateAddProductView = true
        }, label: {
            Text("Add Product")
        })
    }
    
    var logout : some View{
        customView.errorButton(action: {
            if (ApplicationCache.logOut()){
                navigateLoginView = true
            }
        }, label: {
            Text("Log Out")
        })
    }
    
    var toolbar : some View{
        HStack{
            Text("My Account")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.accentColor)
                .font(.system(size: 32, weight: .semibold))
            Spacer()
            
            NavigationLink(destination: {FavouriteView()}){
                Image(systemName: "ellipsis")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 24, weight: .semibold))
            }
        }
        .padding(.horizontal)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
