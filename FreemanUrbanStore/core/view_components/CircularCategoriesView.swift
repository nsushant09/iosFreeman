//
//  CircularCategoriesView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/19/23.
//

import SwiftUI

struct CircularCategoriesView: View {
    let imageUrl : String
    let title : String
    
    var body: some View {
        
        NavigationStack{
            VStack{
                AsyncImage(
                    url:URL(string : imageUrl),
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
                
                Text(title)
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.accentColor)
            }
            .padding(8)

        }
        
    }
}

struct CircularCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CircularCategoriesView(imageUrl: "https://images.pexels.com/photos/5822534/pexels-photo-5822534.jpeg?auto=compress&cs=tinysrgb&w=1600", title: "Home Appliances")
    }
}
