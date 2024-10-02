import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemBlue)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Top section containing logo, heading, and subheading
                Image(systemName: "hands.and.sparkles.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .aspectRatio(contentMode: .fit)
                    .colorInvert()
                    .padding(.top,200)
                Spacer()
            }

            // White card behind welcome, subheading, and buttons
            VStack {
                Spacer()
                    .padding(.top, 420)
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .frame(width : 400 ,height: 400)
                    .padding(.top, 100)
                    .shadow(radius: 5)
                    
            }
            

            VStack {
                Spacer(minLength: 550)
                Text("Welcome to SignEngage")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("Every hand tells a story")
                Spacer(minLength: 10)
                CustomButton(title: "Get Started") {
                    
                    print("Get Started tapped")
                }
                .padding(.bottom, 20)
                CustomButton2(title: "I already have an account") {
                    print("I already have an account tapped")
                }
                
               
                .padding(.bottom, 100)
            }
        }
    }
}

// Custom button view for reuse


#Preview {
    ContentView()
}


