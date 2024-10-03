//
//  LandingPageView.swift
//  SignEngage
//
//  Created by admin26 on 03/10/24.
//

import SwiftUI

struct LandingPageView: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            ContentView()
        }else{
            ZStack{
                Color(UIColor.systemBlue).edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Top section containing logo, heading, and subheading
                    Image(systemName: "hands.and.sparkles.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .aspectRatio(contentMode: .fit)
                        .colorInvert()
                        .padding(.top,300)
                    Spacer()
                } .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation {
                                    self.isActive = true
                                }
                            }
                        }
                    }
                }
            }
        }

#Preview {
    LandingPageView()
}
