//
//  CartView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct CartView: View {
    
    let customView = CustomViews.instance
    
    @State var totalCheckoutAmount = 0;
    @State var subtotalAmount = 0;
    @State var deliveryFee = 0;
    @State var discountPercentage = 0;
    
    var body: some View {
        NavigationStack{
            
            HStack{
                Text("Cart")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.accentColor)
                    .font(.system(size: 32, weight: .semibold))
                Spacer()
                
                Image(systemName: "ellipsis")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 24, weight: .semibold))
            }
            
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
                HStack{
                    VStack(alignment: .leading,spacing: 8){
                        Text("Subtotal :")
                            .fontDesign(.monospaced)
                        Text("Delivery Fee :")
                            .fontDesign(.monospaced)
                        Text("Discount :")
                            .fontDesign(.monospaced)
                    }
                    Spacer()
                    VStack(spacing:8){
                        Text("$\(subtotalAmount)")
                            .fontWeight(.bold)
                            .fontDesign(.monospaced)
                        Text("$\(deliveryFee)")
                            .fontWeight(.bold)
                            .fontDesign(.monospaced)
                        Text("\(discountPercentage)%")
                            .fontWeight(.bold)
                            .fontDesign(.monospaced)
                    }
                }
                
                
            }
            Spacer()
            
            customView.darkFilledButton(action: {
                
            }, label: {
                HStack{
                    Text("Checkout for")
                    Text("$\(totalCheckoutAmount)")
                        .font(.system(size : 18, weight: .bold))
                }
                .frame(maxWidth: .infinity)
            })
        }
        .padding(.all)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
