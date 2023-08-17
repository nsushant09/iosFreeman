//
//  HomeView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var searchValue : String = ""
    
    var body: some View {
        NavigationStack{
            
            Image("LogoDark")
                .resizable()
                .scaledToFit()
                .padding(EdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64))
            
            ScrollView{
                VStack{
                    SliderView(images: HomeView.getCarouselData())
                    Text("Products")
                        .frame(maxWidth: .infinity, alignment : .leading)
                        .font(.system(size: 24, weight: .medium, design: .rounded))
                    
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(0..<20){i in
                                ProductCardView()
                            }
                        }
                    }
                    
                }
                .padding(.all)
            }
        }
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
