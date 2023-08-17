//
//  MainView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            getTabItem(
                view: HomeView(),
                title: "Home",
                image: "house.fill"
            )
            
            getTabItem(view: SearchView(),
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
