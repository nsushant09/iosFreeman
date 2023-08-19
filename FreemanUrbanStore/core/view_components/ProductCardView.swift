//
//  ProductCardView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct ProductCardView: View {
    private let customView = CustomViews.instance
    
    let imageUrl : String
    let price : String
    let title : String
    let category : String
    let discountedPrice : String?
    
    var body: some View {
        NavigationStack{
            
            VStack{
                
                AsyncImage(
                    url:URL(string : imageUrl),
                    content : {image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width:170, height: 180)
                            .cornerRadius(16)
                    },
                    placeholder: {
                        ProgressView()
                    })
                
                VStack{
                    Text(title).frame(maxWidth: .infinity, alignment:.leading)
                        .lineLimit(1)
                        .foregroundColor(CustomColors.primary)
                        .font(.system(size:20, weight: .medium, design: .rounded))
                        .kerning(1)
                    
                    Text(category).frame(maxWidth: .infinity, alignment:.leading)
                        .lineLimit(1)
                        .foregroundColor(.primary.opacity(0.4))
                        .font(.system(size:12, weight: .medium, design: .serif))
                    
                    
                    HStack{
                        Text(
                            discountedPrice == nil ? "$\(price)" : "$\(discountedPrice!)"
                        )
                        .frame(maxWidth: .infinity, alignment:.leading)
                        .lineLimit(1)
                        .foregroundColor(CustomColors.primary)
                        .font(.system(size: 16, weight: .medium, design: .monospaced))
                        .baselineOffset(-4)
                        
                        Spacer()
                        
                        Text(
                            discountedPrice == nil ? "" : "$\(price)"
                        )
                        .frame(maxWidth: .infinity, alignment:.leading)
                        .lineLimit(1)
                        .foregroundColor(.gray.opacity(0.6))
                        .font(.system(size: 16, weight: .medium, design: .monospaced))
                        .baselineOffset(-4)

                    }
                    
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                Spacer()
            }
            .frame(width: 170, height: 260)
        }
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(imageUrl: "https://images.pexels.com/photos/5822534/pexels-photo-5822534.jpeg?auto=compress&cs=tinysrgb&w=1600",
                        price: "208.33", title: "MacBook Pro", category: "Category", discountedPrice: "200")
    }
}
