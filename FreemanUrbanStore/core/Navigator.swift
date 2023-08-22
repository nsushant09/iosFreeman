//
//  Navigator.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import Foundation
import SwiftUI

struct Navigator{
    static func navigate(bindingBoolean : Binding<Bool>, destination : some View) -> NavigationLink<some View, some View>{
        return NavigationLink(isActive: bindingBoolean, destination: {destination}, label: {EmptyView()})
    }
    
    static func navigate(destination : some View) -> some View{
        @State var alwaysTrue = true
        return NavigationLink(isActive: $alwaysTrue, destination: {destination}, label: {EmptyView()})
    }
}
