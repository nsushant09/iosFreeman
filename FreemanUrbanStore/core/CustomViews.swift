//
//  CustomViews.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/16/23.
//

import Foundation
import SwiftUI

struct CustomViews{
    
    static let instance = CustomViews()
    
    var logoImage : some View {
        CustomImages.darkLogo
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.all)
    }
    
    func inputTextField(title : String, bindingString : Binding<String>) -> some View{
        return TextField(title, text : bindingString)
            .tint(CustomColors.primary)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundColor(Color.primary)
            .padding(.all)
            .background(CustomColors.fieldColor)
            .cornerRadius(8)
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            .textInputAutocapitalization(TextInputAutocapitalization.never)
            .autocorrectionDisabled()
    }
    
    func inputSecureField(title : String, bindingString : Binding<String>) -> some View{
        return SecureField(title, text : bindingString)
            .tint(CustomColors.primary)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundColor(Color.primary)
            .padding(.all)
            .background(CustomColors.fieldColor)
            .cornerRadius(8)
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            .textInputAutocapitalization(TextInputAutocapitalization.never)
            .autocorrectionDisabled()
    }
    
    func darkOutlinedButton(action :@escaping () -> Void, label : () -> some View) -> some View{
        return Button(action: action, label: label)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .frame(maxWidth:.infinity)
            .padding(.all)
            .foregroundColor(CustomColors.primary)
            .background(Color.white.opacity(0))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(CustomColors.primary, lineWidth: 2))
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
    }
    
    func darkFilledButton(action :@escaping () -> Void, label : () -> some View) -> some View{
        return Button(action: action, label: label)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .frame(maxWidth:.infinity)
            .padding(.all)
            .foregroundColor(Color.white)
            .background(CustomColors.primary)
            .cornerRadius(8)
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
    }
    
    func datePicker(title : String, selection : Binding<Date>,displayedComponents : DatePickerComponents ) -> some View{
        return DatePicker(title, selection: selection, displayedComponents: displayedComponents)
            .tint(CustomColors.primary)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundColor(Color.gray.opacity(0.6))
            .padding(12)
            .background(CustomColors.fieldColor)
            .cornerRadius(8)
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
    }
    
    func menu(title : String,selection : Binding<String>, options : [String]) -> some View{
        
        return HStack{
            Text(title)
            Spacer()
            Picker(title, selection: selection){
                Group{
                    ForEach(options, id : \.self){option in
                        Text(option)
                    }
                }
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .font(.system(size: 16, weight: .semibold, design: .rounded))
        .foregroundColor(Color.gray.opacity(0.6))
        .background(CustomColors.fieldColor)
        .cornerRadius(8)
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
    }
}
