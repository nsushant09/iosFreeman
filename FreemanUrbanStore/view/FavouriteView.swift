//
//  FavouriteView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/19/23.
//

import SwiftUI

struct FavouriteView: View {
    
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
                    
                    ForEach(0..<3){index in
                        CartProductView(
                            imageUrl: "https://images.pexels.com/photos/5822534/pexels-photo-5822534.jpeg?auto=compress&cs=tinysrgb&w=1600",
                            title: "Title",
                            category: "Category",
                            price: "200.58")
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
                    
                    ForEach(0..<50){index in
                        ProductCardView(
                            imageUrl: "https://images.pexels.com/photos/2453658/pexels-photo-2453658.jpeg?auto=compress&cs=tinysrgb&w=1600",
                            price: "208.33",
                            title: "MacBook Pro",
                            category: "Category",
                            discountedPrice: nil)
                        
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
