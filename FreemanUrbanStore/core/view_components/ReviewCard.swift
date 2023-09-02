//
//  ReviewCard.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/20/23.
//

import SwiftUI


struct ReviewCard: View {
    let username : String
    let rating : Int
    let date : String
    let description : String
    
    var body: some View {
        VStack{
            
            HStack(alignment:.center){
                Text(username)
                    .foregroundColor(.accentColor)
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Spacer()
                
                Text(date)
                    .foregroundColor(Color.gray.opacity(0.6))
                    .font(.system(size: 12))
            }
            .padding(.bottom, 2)
//            Loop for ratings
            HStack(spacing:0){
                ForEach(0..<rating){rating in
                    Image(systemName: "star.fill")
                        .font(.system(size: 14))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 4)
            
            Text(description)
                .frame(maxWidth:.infinity, alignment: .leading)
                .font(.system(size: 16, weight:.regular, design: .rounded))

        }
        .padding(.all,8)
        .background(CustomColors.fieldColor)
        .cornerRadius(16)
        .padding(.bottom, 8)
    }
}

struct ReviewCard_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCard(username : "Sushant Neupane", rating: 5, date : "08/03/2023", description: "Your stream is still running. We've pause this preview to save your resources.")
    }
}
