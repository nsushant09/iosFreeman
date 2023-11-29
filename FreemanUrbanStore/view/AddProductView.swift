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
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    var body: some View{
        NavigationStack{
            
            VStack{
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Text("Select a photo")
                    }.onChange(of: selectedItem) { newItem in
                        Task {
                            // Retrive selected asset in the form of Data
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                                if let selectedImageData,
                                   let uiImage = UIImage(data: selectedImageData){
                                    await viewModel.insertImage(image: uiImage)
                                }
                            }
                        }
                    }
            }
        }
    }
    
    // Functions
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
