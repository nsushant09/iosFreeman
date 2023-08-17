//
//  SliderView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct SliderView: View {
    
    let time = Timer.publish(every: 5, on: .main, in: .default).autoconnect()
    let images : [KeyValue<String, String>]
    @State var selection = 0
    
    var body: some View {
        
        TabView(selection: $selection){
            ForEach(0..<images.count){i in
                    ZStack{
                        AsyncImageView(url: images[i].value)
                        
                        Text(images[i].key)
                            .font(.system(size: 28, weight: .semibold, design: .monospaced))
                            .kerning(2)
                            .foregroundColor(Color.white)
                    }

            }
        }
        .cornerRadius(16)
        .frame(maxWidth: .infinity)
        .frame(height: 250)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
        .onReceive(time) { _ in
            withAnimation {
                selection = (selection + 1) % images.count
            }
        }
        
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(images: HomeView.getCarouselData())
    }
}
