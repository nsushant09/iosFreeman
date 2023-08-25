//
//  SearchView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var searchViewModel = SearchViewModel()
    
    let searchValue : String
    let productGridColumns : [GridItem] = [
        GridItem(.flexible(minimum: 0, maximum: .infinity), spacing:16),
        GridItem(.flexible(minimum: 0, maximum: .infinity), spacing:16),
    ]
    
    var body: some View {
        NavigationStack{
            toolbar()
            ScrollView{
                productsSection()
            }
            Spacer()
        }
        .onAppear{
            onAppear()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func toolbar() -> some View{
        return HStack{
            
            Image(systemName: "chevron.backward")
                .foregroundColor(.accentColor)
                .font(.system(size: 24, weight: .semibold))
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
            Text(searchValue.isEmpty ? "All Products" : searchValue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.accentColor)
                .font(.system(size: 32, weight: .semibold))
            
            Spacer()
            
            Image(systemName: "ellipsis")
                .foregroundColor(.accentColor)
                .font(.system(size: 24, weight: .semibold))
        }
        .padding(.horizontal)
    }
    
    func onAppear(){
        Task{
            await searchViewModel.fetchSearchProducts(value:searchValue)
        }
    }
    
    func productsSection() -> some View{
        VStack{
            
            if(searchViewModel.products.isEmpty){
                Text("There are no products that match your description")
                    .multilineTextAlignment(.center)
                    .font(.system(size:18, weight: .medium, design: .monospaced))
                    .padding(.vertical)
            }
            
            LazyVGrid(columns: productGridColumns,
                      alignment: .center,
                      spacing: 24,
                      pinnedViews: [.sectionHeaders],
                      content: {
                
                ForEach(searchViewModel.products){product in
                    ProductCardView(
                        product: product
                    )
                }
            })
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchValue: "")
    }
}
