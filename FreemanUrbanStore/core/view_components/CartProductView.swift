//
//  CartProductView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/19/23.
//

import SwiftUI

struct CartProductView: View {
    
    let product : Product
    let isQuantityVisible : Bool
    let onRemoveClick : (Int) -> Void
    
    var body: some View {
        NavigationStack{
            NavigationLink(
                destination:ProductDetailView(mProduct: ProductDetailView.productMock)){
                HStack{
                    AsyncImage(
                        url:URL(string : product.imagePath),
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
                            Text(product.name)
                                .lineLimit(1)
                                .font(.system(size: 24, weight: .medium, design: .rounded))
                                .foregroundColor(.accentColor)
                                .kerning(0.6)
                            Spacer()
                            Image(systemName: "xmark")
                                .foregroundColor(.gray.opacity(0.6))
                                .font(.system(size: 18, weight: .semibold))
                                .onTapGesture {
                                    onRemoveClick(product.id)
                                }
                        }
                        
                        Text(product.category?.name ?? "")
                            .lineLimit(1)
                            .font(.system(size: 14, weight: .light, design: .serif))
                            .foregroundColor(.accentColor.opacity(0.4))
                            .frame(maxWidth: .infinity, alignment:.leading)
                            .baselineOffset(-4)
                        
                        Spacer()
                            .frame(height: 16)
                        
                        HStack(alignment:.center){
                            Text("$\(product.price.toString())")
                                .lineLimit(1)
                                .foregroundColor(.accentColor)
                                .font(.system(size: 18, weight: .medium, design: .monospaced))
                            Spacer()
                            
                            quantityGroup()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                }
                .padding(.vertical, 8)
            }
        }
    }
    
    func quantityGroup() -> some View{
        return HStack{
            if isQuantityVisible {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.4), lineWidth:1)
                    .frame(width: 36, height: 36)
                    .foregroundColor(.blue)
                    .overlay(
                        Image(systemName: "minus")
                            .foregroundColor(.gray.opacity(0.4))
                    )
                
                Text("1")
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
}

struct CartProductView_Previews: PreviewProvider {
    static var previews: some View {
        CartProductView(
            product: ProductDetailView.productMock, isQuantityVisible: true, onRemoveClick: {id in}
        )
    }
}
