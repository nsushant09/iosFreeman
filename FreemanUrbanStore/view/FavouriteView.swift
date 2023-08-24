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
            HStack{
                
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
            
            ScrollView{
                VStack{
                    
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
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
