//
//  ProductCardView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct ProductCardView: View {
    private let customView = CustomViews.instance
    
    let product : Product
    
    var body: some View {
        NavigationStack{
            
            NavigationLink(destination: {
                ProductDetailView(
                    mProduct: product)
            }){
                VStack{
                    
                    AsyncImage(
                        url:URL(string : product.imagePath),
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
                        Text(product.name).frame(maxWidth: .infinity, alignment:.leading)
                            .lineLimit(1)
                            .foregroundColor(CustomColors.primary)
                            .font(.system(size:20, weight: .medium, design: .rounded))
                            .kerning(1)
                        
                        Text(product.category?.name ?? "").frame(maxWidth: .infinity, alignment:.leading)
                            .lineLimit(1)
                            .foregroundColor(.primary.opacity(0.4))
                            .font(.system(size:12, weight: .medium, design: .serif))
                        
                        
                        HStack{
                            Text(
                                product.discountedPrice == nil ? "$\(product.price.toString())" : "$\(product.discountedPrice!.toString())"
                            )
                            .frame(maxWidth: .infinity, alignment:.leading)
                            .lineLimit(1)
                            .foregroundColor(CustomColors.primary)
                            .font(.system(size: 16, weight: .medium, design: .monospaced))
                            .baselineOffset(-4)
                            
                            Spacer()
                            
                            Text(
                                product.discountedPrice == nil ? "" : "$\(product.price)"
                            )
                            .frame(alignment:.trailing)
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
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(product: ProductDetailView.productMock)
    }
}
