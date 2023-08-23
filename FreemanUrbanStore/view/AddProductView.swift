//
//  AddProductView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/22/23.
//

import SwiftUI
import PhotosUI

struct AddProductView: View {
    
    let customView = CustomViews.instance
    
    @StateObject var viewModel = ProductCrudViewModel()
    @State var imageSelection : PhotosPickerItem? = nil
    
    @State var processing = false
    let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @State var buttonTextMessage = "Add Product"
    
    let numberFormatter = NumberFormatter()
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Text("Add Product")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 28, weight: .semibold, design: .monospaced))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 64, trailing: 0))
                    
                    inputFields()
                    
                    PhotosPicker(
                        {
                            guard let title = imageSelection?.itemIdentifier else
                            {return "Select a photo"}
                            return "\(title)"
                        }(),
                        selection: $imageSelection,
                        matching: .images,
                        photoLibrary: .shared()
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .tint(CustomColors.primary)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.gray.opacity(0.6))
                    .padding(16)
                    .background(CustomColors.fieldColor)
                    .cornerRadius(8)
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                    
                    customView.darkOutlinedButton(
                        action: {
                            buttonTextMessage = "Loading"
                            Task{
                                await viewModel.insertProduct()
                                if (viewModel.isProductInserted){
                                    buttonTextMessage = "Product Added"
                                }else{
                                    buttonTextMessage = "Error!!!"
                                }
                            }
                        },
                        label: {
                            Group{
                                if buttonTextMessage == "Loading"{
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                }else{
                                    Text(buttonTextMessage)
                                }
                            }
                        }
                    )
                }
                .onAppear{
                    Task{
                        await viewModel.productById()
//                        await viewModel.productsByCategory()
//                        await viewModel.productsByUser()
//                        await viewModel.allProduct()
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func inputFields() -> some View{
        VStack{
            customView.inputTextField(
                title: "Name",
                bindingString: $viewModel.name
            )
            
            
            customView.inputTextField(
                title: "Description",
                bindingString: $viewModel.description
            )
            
            customView.inputTextField(
                title: "Price",
                bindingString: $viewModel.price
            )
            
            customView.inputTextField(
                title: "Discounted Price (Optional)",
                bindingString: $viewModel.discountedPrice
            )
            
            customView.inputTextField(
                title: "Stock Quantity",
                bindingString: $viewModel.stock
            )
            
            customView.menu(
                title: "Category",
                selection : $viewModel.category,
                options: viewModel.categories.map({category in
                    category.name
                })
            )
            
        }
        .onAppear{
            Task{
                await viewModel.fetchCategoriesAsync()
            }
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
