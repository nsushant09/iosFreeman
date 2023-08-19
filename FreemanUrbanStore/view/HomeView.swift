//
//  HomeView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var searchValue : String = ""
    
    let productGridColumns : [GridItem] = [
        GridItem(.flexible(minimum: 0, maximum: .infinity), spacing:16),
        GridItem(.flexible(minimum: 0, maximum: .infinity), spacing:16),
    ]
    
    let categoriesGridColumns : [GridItem] = [
        GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 16),
        GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 16),
        GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 16),
        GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 16)
    ]
    
    
    var body: some View {
        NavigationStack{
            
            HStack{
                Text("Discover")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 32, weight: .semibold))
                Spacer()
                
                Image(systemName: "heart")
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 24, weight: .semibold))
            }
            
            ScrollView{
                VStack{
                    SliderView(images: HomeView.getCarouselData())
                    
                    Text("Categories")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 24, weight: .semibold))
                    
                    LazyVGrid(columns: categoriesGridColumns, content: {
                        ForEach(0..<8){index in
                            CircularCategoriesView(
                                imageUrl:"https://images.pexels.com/photos/5822534/pexels-photo-5822534.jpeg?auto=compress&cs=tinysrgb&w=1600",
                                title: "Category")
                        }
                    })
                    
                    Text("Products")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.accentColor)
                        .font(.system(size: 24, weight: .semibold))
                    
                    LazyVGrid(columns: productGridColumns,
                              alignment: .center,
                              spacing: 24,
                              pinnedViews: [.sectionHeaders],
                              content: {
                        
                        ForEach(0..<50){index in
                            ProductCardView(
                                imageUrl: "https://images.pexels.com/photos/5822534/pexels-photo-5822534.jpeg?auto=compress&cs=tinysrgb&w=1600",
                                price: "208.33",
                                title: "MacBook Pro",
                                category: "Category",
                                discountedPrice: nil)
                            
                        }
                    })
                    
                }
            }
        }
        .padding(.all)
    }
    
    static func getCarouselData() -> [KeyValue<String, String>]{
        var carouselItems = [KeyValue<String, String>]()
        carouselItems.append(KeyValue(
            key: "Electronics",
            value: "https://images.pexels.com/photos/2453658/pexels-photo-2453658.jpeg?auto=compress&cs=tinysrgb&w=1600"))
        carouselItems.append(KeyValue(
            key: "Fashion",
            value: "https://images.pexels.com/photos/5822534/pexels-photo-5822534.jpeg?auto=compress&cs=tinysrgb&w=1600"))
        carouselItems.append(KeyValue(
            key: "Sports",
            value: "https://images.pexels.com/photos/7689286/pexels-photo-7689286.jpeg?auto=compress&cs=tinysrgb&w=1600"))
        carouselItems.append(KeyValue(
            key: "Luxury",
            value: "https://images.pexels.com/photos/5026973/pexels-photo-5026973.jpeg?auto=compress&cs=tinysrgb&w=1600"))
        return carouselItems
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
