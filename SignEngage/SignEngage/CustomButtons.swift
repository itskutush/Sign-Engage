//
//  CustomButton.swift
//  weatherapp
//
//  Created by user@90 on 02/10/24.
import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(width:320 , height: 15)
                .font(.system(size:17 , weight: .semibold, design: .default))
                .foregroundColor(.white)
                .padding() // Padding for button appearance
                .background(Color(UIColor.systemBlue))
                .cornerRadius(14)
        }
    }
}



struct CustomButton2: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(width:320 , height: 15)
                .font(.system(size:17 , weight: .semibold, design: .default))
                .foregroundColor(.blue)
                .padding() // Padding for button appearance
                .background(Color(UIColor.systemGray5))
                .cornerRadius(14)
        }
    }
}



