//
//  MainView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var mainViewModel = MainViewModel()
    @State var navigateToLogin = false
    
    init(){
        UITabBar.appearance().backgroundColor = .white
        
    }
    
    var body: some View {
        NavigationStack{
            
            Navigator.navigate(
                bindingBoolean: $navigateToLogin,
                destination: LoginView()
            )
            
            TabView{
                getTabItem(
                    view: HomeView(),
                    title: "Discover",
                    image: "house.fill"
                )
                
                getTabItem(view: SearchView(searchValue: ""),
                           title: "Search",
                           image: "magnifyingglass"
                )
                
                getTabItem(
                    view: CartView(),
                    title: "Cart",
                    image: "cart.fill"
                )
                
                getTabItem(
                    view: AccountView(),
                    title: "Account",
                    image: "person.fill"
                )
            }
            .onReceive(
                mainViewModel.$navigateToLogin,
                perform: {boolean in
                    navigateToLogin = boolean
                }
            )
            .tint(.accentColor)
            .navigationBarBackButtonHidden(true)
        }
    }
}

func getTabItem(view : some View, title : String, image : String) -> some View {
    return view.tabItem({
        Image(systemName : image)
        Text(title)
    })
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
