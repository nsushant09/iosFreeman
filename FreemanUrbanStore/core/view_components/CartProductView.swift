//
//  CartProductView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/19/23.
//

import SwiftUI

struct CartProductView: View {
    
    let imageUrl : String
    let title : String
    let category : String
    let price : String
    let quantity = 1
    
    var body: some View {
        NavigationStack{
            NavigationLink(
                destination:ProductDetailView(product: ProductDetailView.productMock)){
                HStack{
                    AsyncImage(
                        url:URL(string : imageUrl),
                        content : {image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:120, height: 120)
                                .cornerRadius(16)
                        },
                        placeholder: {
                            ProgressView()
                        })
                    
                    VStack{
                        HStack(alignment: .center){
                            Text(title)
                                .lineLimit(1)
                                .font(.system(size: 24, weight: .medium, design: .rounded))
                                .foregroundColor(.accentColor)
                                .kerning(0.6)
                            Spacer()
                            Image(systemName: "xmark")
                                .foregroundColor(.gray.opacity(0.6))
                                .font(.system(size: 18, weight: .semibold))
                        }
                        
                        Text(category)
                            .lineLimit(1)
                            .font(.system(size: 14, weight: .light, design: .serif))
                            .foregroundColor(.accentColor.opacity(0.4))
                            .frame(maxWidth: .infinity, alignment:.leading)
                            .baselineOffset(-4)
                        
                        Spacer()
                            .frame(height: 16)
                        
                        HStack(alignment:.center){
                            Text("$\(price)")
                                .lineLimit(1)
                                .foregroundColor(.accentColor)
                                .font(.system(size: 18, weight: .medium, design: .monospaced))
                            Spacer()
                            
                            Group{
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.4), lineWidth:1)
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(.blue)
                                    .overlay(
                                        Image(systemName: "minus")
                                            .foregroundColor(.gray.opacity(0.4))
                                    )
                                
                                Text(quantity.codingKey.stringValue)
                                    .fontDesign(.monospaced)
                                    .padding(.horizontal, 8)
                                
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.accentColor, lineWidth:1)
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(.blue)
                                    .overlay(
                                        Image(systemName: "plus")
                                            .foregroundColor(.accentColor)
                                    )
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                }
                .padding(.vertical, 8)
            }
        }
    }
}

struct CartProductView_Previews: PreviewProvider {
    static var previews: some View {
        CartProductView(
            imageUrl: "https://images.pexels.com/photos/5822534/pexels-photo-5822534.jpeg?auto=compress&cs=tinysrgb&w=1600",
            title: "Title",
            category: "Category",
            price: "200.58")
    }
}
