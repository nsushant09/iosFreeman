//
//  CartView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct CartView: View {
    
    let customView = CustomViews.instance
    
    @StateObject var viewModel = CartViewModel()
    
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
            .padding(.horizontal)
            
            ScrollView{
                VStack{
                    
                    ForEach(viewModel.cartProducts){product in
                        CartProductView(
                            product: product, isQuantityVisible: true
                        ){id in
                            Task{
                                await viewModel.removeProductFromCart(productId:id)
                            }
                        }
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
                    VStack(alignment: .trailing, spacing:8){
                        Text("$\(viewModel.subTotalAmount.toString())")
                            .fontWeight(.bold)
                            .fontDesign(.monospaced)
                        Text("$\(viewModel.deliveryFee.toString())")
                            .fontWeight(.bold)
                            .fontDesign(.monospaced)
                        Text("\(viewModel.discount.toString())")
                            .fontWeight(.bold)
                            .fontDesign(.monospaced)
                    }
                }
                
                customView.darkFilledButton(action: {
                    
                }, label: {
                    HStack{
                        Text("Checkout for")
                        Text("$\(viewModel.checkoutPrice.toString())")
                            .font(.system(size : 18, weight: .bold))
                    }
                    .frame(maxWidth: .infinity)
                })
            }
            .padding(.horizontal)
        }
        .onAppear{
            onAppear()
        }
    }
    
    func onAppear(){
        Task{
            await viewModel.getCartProducts()
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
