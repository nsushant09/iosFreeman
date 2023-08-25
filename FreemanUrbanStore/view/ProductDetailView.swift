//
//  ProductDetailView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/19/23.
//

import SwiftUI

struct ProductDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let product : Product
    let customView = CustomViews.instance
    
    @StateObject var viewModel : ProductDetailViewModel
    @State var favouriteIcon = "heart"
    
    init(mProduct : Product){
        product = mProduct
        self._viewModel = StateObject(wrappedValue: .init(mProduct: mProduct))
    }
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geometry in
                
                ScrollView{
                    getProductImage()
                        .overlay{
                            getToolbar()
                                .padding(.top)
                                .padding(.top)
                        }
                    
                    VStack{
                        showProductDetails()
                        showDescription()
                        showReview()
                    }
                    .frame(maxWidth: .infinity, maxHeight:.infinity)
                    .padding(.all)
                    .padding(.bottom)
                    .background(.white)
                    .cornerRadius(16)
                    .offset(y:-32)
                }
                .overlay(alignment:.bottom){
                    cartButton()
                }
                .ignoresSafeArea()
                
            }
        }
        .onAppear{
            onAppear()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func onAppear(){
        Task{
            await viewModel.fetchCart()
            await viewModel.fetchFavourite()
            await viewModel.fetchReviews()
        }
    }
    
    func getProductImage() -> some View{
        return AsyncImage(
            url: URL(string: product.imagePath),
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 500)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 0, style: .circular)
                    )
            },
            placeholder: {
                ProgressView()
            }
        )
        
    }
    
    func cartButton() -> some View{
        Group{
            customView.darkFilledButton(
                action: {
                    cartButtonAction()
                },
                label: {
                    cartButtonLabel()
                }
            )
            .padding(.horizontal)
            .padding(.bottom)
        }.background(.white)
    }
    
    func cartButtonAction(){
        if(viewModel.isAddedToCart){
            Task{
                await viewModel.removeFromCart()
            }
        }else{
            Task{
                await viewModel.addToCart()
            }
        }
    }
    
    func cartButtonLabel() -> some View{
        return Group{
            if(viewModel.isAddedToCart){
                Text("Remove From Cart")
            }else{
                Text("Add To Cart")
            }
        }
    }
    
    
    
    func getToolbar() -> some View{
        return HStack{
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 48, height: 48)
                .foregroundColor(CustomColors.fieldColor)
                .overlay(
                    Image(systemName: "chevron.backward")
                        .font(.title3)
                )
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 48, height: 48)
                .foregroundColor(CustomColors.fieldColor)
                .overlay(
                    Image(systemName: "square.and.arrow.up")
                        .font(.title3)
                )
                .onTapGesture {
                    //TODO : Share
                }
                .padding(.trailing, 8)
            
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 48, height: 48)
                .foregroundColor(CustomColors.fieldColor)
                .overlay(
                    Image(systemName: favouriteIcon)
                        .font(.title3)
                )
                .onTapGesture {
                    toggleFavourites()
                }
        }
        .onReceive(
            viewModel.$isAddedToFavourites,
            perform: {boolean in
                if(boolean){
                    favouriteIcon = "heart.fill"
                }else{
                    favouriteIcon = "heart"
                }
            }
        )
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.all)
    }
    
    func toggleFavourites(){
        withAnimation{
            if(viewModel.isAddedToFavourites){
                Task{await viewModel.removeFromFavourites()}
            }else{
                Task{await viewModel.addToFavourites()}
            }
        }
    }
    
    func showProductDetails() -> some View{
        return VStack{
            
            Text(product.name)
                .frame(maxWidth: .infinity, alignment:.leading)
                .font(.system(size: 24, weight: .medium, design: .default))
                .baselineOffset(-4)
            
            Text("$\(product.price.toString())")
                .frame(maxWidth: .infinity, alignment:.leading)
                .font(.system(size: 24, weight: .medium, design: .rounded))
                .baselineOffset(-4)
            
            
            Text("\(product.category?.name ?? "")")
                .frame(maxWidth: .infinity, alignment:.leading)
                .font(.system(size: 14, weight: .light, design: .monospaced))
                .baselineOffset(-4)
            
            HStack{
                RoundedRectangle(cornerRadius: 18)
                    .frame(width: 56, height: 24)
                    .foregroundColor(.accentColor)
                    .overlay(content:{
                        HStack(alignment: .firstTextBaseline){
                            Image(systemName: "star.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                            
                            Text(viewModel.averageReviewRating.toString())
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                        }
                    })
                
                Text("(\(viewModel.reviews.count) Review)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray.opacity(0.6))
            }
            .frame(maxWidth:.infinity,alignment: .leading)
            
            Rectangle()
                .frame(maxHeight: 1)
                .foregroundColor(Color.gray.opacity(0.2))
            
        }
    }
    
    func showDescription() -> some View{
        return VStack{
            Text("Description")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.accentColor)
                .font(.system(size: 24, weight: .semibold))
            
            Text(product.description)
                .foregroundColor(.gray)
                .baselineOffset(-4)
            
            Rectangle()
                .frame(maxHeight: 1)
                .foregroundColor(Color.gray.opacity(0.2))
        }
    }
    
    func showReview() -> some View{
        return VStack{
            Text("Reviews")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.accentColor)
                .font(.system(size: 24, weight: .semibold))
            
            if(viewModel.reviews.isEmpty){
                Text("There are no reviews in this product")
                    .multilineTextAlignment(.center)
                    .font(.system(size:18, weight: .medium, design: .monospaced))
                    .padding(.vertical)
            }
            
            ForEach(viewModel.reviews){review in
                ReviewCard(
                    username : review.user?.name ?? "",
                    rating: review.rating,
                    date : review.date,
                    description: review.description
                )
            }
        }
        .padding(.bottom)
    }
    
    static let productMock = Product(
        id: 0,
        name: "HeadPhone",
        description: "Wireless headphones have revolutionized the way we experience audio, providing a seamless and convenient way to enjoy music, podcasts, and more. Unlike their wired counterparts, wireless headphones utilize advanced Bluetooth technology to establish a wireless connection with devices such as smartphones, tablets, and laptops. This freedom from tangled cords and cables offers unparalleled mobility and convenience, allowing users to move around unrestricted while staying immersed in their audio world. With impressive battery life and quick charging capabilities, wireless headphones have become an essential companion for daily commutes, workouts, and relaxation sessions. They come in various styles, including over-ear, on-ear, and in-ear options, catering to different preferences for comfort and sound isolation. The continuous advancements in wireless audio technology have led to improved sound quality, enhanced noise cancellation features, and seamless integration with voice assistants, making wireless headphones a symbol of modern audio innovation. Whether you're a music enthusiast, a frequent traveler, or someone who simply values the convenience of wireless technology, these headphones have undoubtedly reshaped the way we enjoy audio content.",
        imagePath:"https://images.pexels.com/photos/5822534/pexels-photo-5822534.jpeg?auto=compress&cs=tinysrgb&w=1600",
        price: 208.48,
        stock: 10,
        category: Category(id: 0, name: "Category", imagePath: "")
    )
}


struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(
            mProduct : ProductDetailView.productMock
        )
    }
}
