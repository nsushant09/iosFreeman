//
//  HomeView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeViewModel = HomeViewModel()
    
    @State var searchValue : String = ""
    @State var categories : [Category] = []
    
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
                    .foregroundColor(.accentColor)
                    .font(.system(size: 32, weight: .semibold))
                Spacer()
                
                NavigationLink(destination: {FavouriteView()}){
                    Image(systemName: "heart")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 24, weight: .semibold))
                }
            }
            .padding(.horizontal)
            
            ScrollView{
                VStack{
                    SliderView(images: HomeView.getCarouselData())
                    
                    
                    Text("Categories")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.accentColor)
                        .font(.system(size: 24, weight: .semibold))
                    
                    LazyVGrid(columns: categoriesGridColumns, content: {
                        ForEach(homeViewModel.categories){category in
                            CircularCategoriesView(
                                category: category
                            )
                        }
                    })
                    
                    Text("Products")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.accentColor)
                        .font(.system(size: 24, weight: .semibold))
                    
                    LazyVGrid(columns: productGridColumns,
                              alignment: .center,
                              spacing: 24,
                              pinnedViews: [.sectionHeaders],
                              content: {
                        
                        ForEach(homeViewModel.products){product in
                            ProductCardView(
                                product: product
                            )      
                        }
                    })
                    
                }
            }
            .padding(.horizontal)
        }
        .onAppear(perform: {
            Task{
                await homeViewModel.fetchCategories()
                await homeViewModel.fetchProducts()
            }
        })
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
