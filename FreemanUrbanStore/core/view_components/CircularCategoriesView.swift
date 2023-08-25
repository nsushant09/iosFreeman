//
//  CircularCategoriesView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/19/23.
//

import SwiftUI

struct CircularCategoriesView: View {
    
    let category : Category
    
    var body: some View {
        
        NavigationStack{
            NavigationLink(
                destination: {
                    SearchView(searchValue: category.name)
                },
                label: {
                content()
            })
        }
    }
    
    func content() -> some View{
        VStack{
            AsyncImage(
                url:URL(string : category.imagePath),
                content : {image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:64, height: 64)
                        .cornerRadius(.infinity)
                },
                placeholder: {
                    ProgressView()
                })
            
            Text(category.name)
                .font(.system(size: 12, weight: .light, design: .serif))
                .multilineTextAlignment(.center)
                .foregroundColor(.accentColor)
        }
        .padding(8)
    }
}

struct CircularCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CircularCategoriesView(
            category: Category(
                id: 0,
                name: "Electronics",
                imagePath: "https://images.pexels.com/photos/18032304/pexels-photo-18032304/free-photo-of-middle-of-trees-on-botanical-garden-hamma.jpeg?auto=compress&cs=tinysrgb&w=1600&lazy=load")
        )
    }
}
