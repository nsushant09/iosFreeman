//
//  FavouriteView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/19/23.
//

import SwiftUI

struct FavouriteView: View {
    
    @StateObject var viewModel = FavouriteViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let justForYouGridColumns : [GridItem] = [
        GridItem(.flexible(minimum: 0, maximum: .infinity), spacing:16),
        GridItem(.flexible(minimum: 0, maximum: .infinity), spacing:16),
    ]
    
    var body: some View {
        NavigationStack{
            toolbar()
            ScrollView{
                VStack{
                    favouriteProductsSection()
                    justForYouSection()
                }
            }
            .padding(.horizontal)
            Spacer()
        }
        .onAppear{
            onAppear()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func toolbar() -> some View{
        return HStack{
            
            Image(systemName: "chevron.backward")
                .foregroundColor(.accentColor)
                .font(.system(size: 24, weight: .semibold))
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
            Text("Favourites")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.accentColor)
                .font(.system(size: 32, weight: .semibold))
            
            Spacer()
            
            Image(systemName: "ellipsis")
                .foregroundColor(.accentColor)
                .font(.system(size: 24, weight: .semibold))
        }
        .padding(.horizontal)
    }
    
    func favouriteProductsSection() -> some View {
        return VStack{
            
            if(viewModel.favouriteProducts.isEmpty){
                Text("There are no reviews in this product")
                    .multilineTextAlignment(.center)
                    .font(.system(size:18, weight: .medium, design: .monospaced))
                    .padding(.vertical)
            }
            
            ForEach(viewModel.favouriteProducts){product in
                CartProductView(
                    product: product, isQuantityVisible: false
                ){id in
                    Task{
                        await viewModel.removeProductFromCart(productId:id)
                    }
                }
            }
        }
    }
    
    func justForYouSection() -> some View{
        return VStack{
            Text("Just For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.accentColor)
                .font(.system(size: 24, weight: .semibold))
            
            LazyVGrid(columns: justForYouGridColumns,
                      alignment: .center,
                      spacing: 24,
                      pinnedViews: [.sectionHeaders],
                      content: {
                
                ForEach(0..<3){index in
                    ProductCardView(
                        product: ProductDetailView.productMock
                    )
                    
                }
            })
        }
    }
    
    func onAppear(){
        Task{
            await viewModel.getFavouriteProducts()
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
