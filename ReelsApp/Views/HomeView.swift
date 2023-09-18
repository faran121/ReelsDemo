//
//  HomeView.swift
//  ReelsApp
//
//  Created by Maliks on 16/09/2023.
//

import SwiftUI

struct HomeView: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State var currentTab = "Reels"
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Text("Home")
                    .tag("house.fill")
                Text("Search")
                    .tag("magnifyingglass")
                ReelsView()
                    .tag("Reels")
                Text("Safari")
                    .tag("safari")
                Text("Profile")
                    .tag("person.circle")
            }
            
            HStack(spacing: 0) {
                ForEach(["house.fill", "magnifyingglass", "Reels", "safari", "person.circle"], id: \.self) { image in
                    TabbarButton(currentTab: self.$currentTab, image: image, isSystemImage: image != "Reels")
                }
            }
            .padding()
            .padding(.vertical, 10)
            .overlay(Divider(), alignment: .top)
            .background(currentTab == "Reels" ? .black : .clear)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct TabbarButton: View {
    
    @Binding var currentTab: String
    
    var image: String
    var isSystemImage: Bool
    
    var body: some View {
        Button {
            withAnimation {
                currentTab = image
            }
        } label: {
            ZStack {
                if isSystemImage {
                    Image(systemName: image)
                        .font(.title2)
                }
                else {
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                }
            }
            .foregroundColor(currentTab == image ? currentTab == "Reels" ? .white : .primary : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}
