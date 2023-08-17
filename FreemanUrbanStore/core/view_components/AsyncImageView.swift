//
//  AsyncImageView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct AsyncImageView: View {
    let url : String
    var body: some View {
        AsyncImage(
            url:URL(string : url),
            content : {image in
                image
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(16)
            },
            placeholder: {
                ProgressView()
            })
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(url : "")
    }
}
