//
//  AddProductView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/22/23.
//

import SwiftUI
import PhotosUI

struct UpdateProductView: View {
    
    let customView = CustomViews.instance
    @StateObject var viewModel = ProductCrudViewModel()
    
    
    @State var buttonTextMessage = "Update Product"
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    var body: some View{
        NavigationStack{
            VStack{
                header
                inputField
                photoPicker()
                addButton()
                Spacer()
            }
            .padding()
        }
    }
    
    var header : some View{
        Text("Add Product")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 28, weight: .semibold, design: .monospaced))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 64, trailing: 0))
    }
    
    var inputField : some View{
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
    
    func addButton() -> some View{
        customView.darkFilledButton(
                action: {
                    buttonTextMessage = "Loading..."
                    Task{
                        await viewModel.updateProduct()
                        if (viewModel.isProductUpdated){
                            buttonTextMessage = "Product Updated"
                        }else{
                            buttonTextMessage = "Error!!!"
                        }
                    }
                },
                label: {
                    Group{
                        if buttonTextMessage == "Loading..."{
                            ProgressView()
                                .progressViewStyle(.circular)
                        }else{
                            Text(buttonTextMessage)
                        }
                    }
                }
            )
        }
    
    func photoPicker() -> some View{
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()) {
                Text("Select a photo")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .tint(CustomColors.primary)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundColor(Color.gray.opacity(0.6))
            .padding(16)
            .background(CustomColors.fieldColor)
            .cornerRadius(8)
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            .onChange(of: selectedItem) { newItem in
                Task {
                    // Retrive selected asset in the form of Data
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                        if let selectedImageData,
                           let uiImage = UIImage(data: selectedImageData){
                            viewModel.image = uiImage
                        }
                    }
                }
            }
    }
    // Functions
}

struct UpdateProductView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProductView()
    }
}
