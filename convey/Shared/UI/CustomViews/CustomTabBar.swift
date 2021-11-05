

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab: String
    
    // Storing Each Tab Midpoints to animate it in future...
    @State var tabPoints : [CGFloat] = []
    
    var body: some View {
        
        HStack(spacing: 0){
            
            // Tab Bar Buttons...
            
            TabBarButton(image: "person", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButton(image: "house", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
//            TabBarButton(image: "gear", selectedTab: $selectedTab, tabPoints: $tabPoints)
//
//            TabBarButton(image: "questionmark", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            
        }
        .padding()
        .background(
            Color.blue
                .clipShape(TabCurve(tabPoint: getCurvePoint() - 15))
        )
        .overlay(
        
            Circle()
                .fill(Color.blue)
                .frame(width: 10, height: 10)
                .offset(x: getCurvePoint() - 20)
            
            ,alignment: .bottomLeading
        )
        .cornerRadius(30)
        .padding(.horizontal)
    }
    
    // extracting point...
    func getCurvePoint()->CGFloat{
        
        // if tabpoint is empty...
        if tabPoints.isEmpty{
            return 10
        }
        else{
            switch selectedTab {
            case "person":
                return tabPoints[1]
            default:
                return tabPoints[0]
            }
        }
    }
}

struct TabBarButton: View {
    
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints: [CGFloat]
    
    var body: some View{
        
        // For getting mid Point of each button for curve Animation....
        GeometryReader { reader -> AnyView in
            
            // extracting MidPoint and Storing....
            let midX = reader.frame(in: .global).midX
            
            DispatchQueue.main.async {
                
                // avoiding junk data....
                if tabPoints.count <= 4 {
                    tabPoints.append(midX)
                }
            }
            
            return AnyView(
            
                Button(action: {
                    // changing tab...
                    // spring animation...
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)){
                        selectedTab = image
                    }
                }, label: {
                    
                    // filling the color if it' selected...
                    
                    Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color.white)
                    // Lifting View...
                    // if its selected...
                        .offset(y: selectedTab == image ? -10 : 0)
                })
                // Max Frame...
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
            )
        }
        // maxHeight..
        .frame(height: 50)
    }
}
