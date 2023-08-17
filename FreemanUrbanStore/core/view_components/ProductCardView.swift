//
//  ProductCardView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct ProductCardView: View {
    private let customView = CustomViews.instance
    var body: some View {
        NavigationStack{
            
            VStack{
                
                AsyncImage(
                    url:URL(string : "https://images.pexels.com/photos/5822534/pexels-photo-5822534.jpeg?auto=compress&cs=tinysrgb&w=1600"),
                    content : {image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width:200, height: 130)
                            .cornerRadius(16)
                    },
                    placeholder: {
                        ProgressView()
                    })
                
                VStack{
                    Text("$208.33").frame(maxWidth: .infinity, alignment:.leading)
                        .font(.system(size: 16, weight: .medium, design: .monospaced))
                    
                    Text("Title").frame(maxWidth: .infinity, alignment:.leading)
                        .font(.system(size:18, weight: .medium, design: .monospaced))
                        .baselineOffset(-2)
                    
                    Text("So, if you want to maintain the aspect ratio of 1600:900 while changing the height to 200, the corresponding width should be approximately 355.56. However, in practical scenarios, you might round it to a whole number or a more practical value depending on your layout requirements.")
                        .frame(maxWidth: .infinity, alignment:.leading)
                        .font(.system(size:14, weight: .regular, design: .rounded))
                        .kerning(0.2)
                        .baselineOffset(-4)
                }
                .padding(EdgeInsets(top: 4, leading: 8, bottom: 8, trailing: 8))
                
                Spacer()
                    .frame(height: 1)
            }
            .frame(width: 200, height: 300)
            .background(CustomColors.fieldColor)
            .cornerRadius(16)
            
        }
        
        
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView()
    }
}
