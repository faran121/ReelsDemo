//
//  ReelsView.swift
//  ReelsApp
//
//  Created by Maliks on 16/09/2023.
//

import SwiftUI
import AVKit

struct ReelsView: View {
    
    @State var currentReel = ""
    @State var reels = MediaFileJSON.map { item -> Reel in
        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        
        return Reel(player: player, mediaFile: item)
    }
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            TabView(selection: $currentReel) {
                ForEach($reels) { $reel in
                    ReelsPlayer(reel: $reel, currentReel: $currentReel)
                        .frame(width: size.width)
                        .rotationEffect(.init(degrees: -90))
                        .ignoresSafeArea(.all, edges: .top)
                        .tag(reel.id)
                }
            }
            .rotationEffect(.init(degrees: 90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: size.width)
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            currentReel = reels.first?.id ?? ""
        }
    }
}

struct ReelsPlayer: View {
    
    @Binding var reel: Reel
    @Binding var currentReel: String
    
    var body: some View {
        ZStack {
            if let player = reel.player {
                CustomVideoPlayer(player: player)
                
                GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .global).minY
                    let size = proxy.size
                    
                    DispatchQueue.main.async {
                        if -minY < (size.height / 2) && minY < (size.height / 2) && currentReel == reel.id {
                            player.play()
                        }
                        else {
                            player.pause()
                        }
                    }
                    return Color.clear
                }
                VStack {
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 30) {
                            HStack {
                                Image("Profile")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 35, height: 35)
                                    .clipShape(Circle())
                                Text("User")
                                    .font(.callout.bold())
                            }
                            .padding(.top, 650)
                        }
                        Spacer(minLength: 20)
                        ActionButtons(reel: reel)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .bottom)
            }
        }
    }
}


struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsView()
    }
}

struct ActionButtons: View {
    
    var reel: Reel
    
    var body: some View {
        VStack(spacing: 25) {
            Button {
            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "suit.heart")
                        .font(.title3)
                    Text("1,5M")
                        .font(.caption.bold())
                }
            }
            
            Button {
            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "bubble.right.fill")
                        .font(.title3)
                    Text("1,5M")
                        .font(.caption.bold())
                }
            }
            
            Button {
            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "paperplane.fill")
                        .font(.title3)
                }
            }
            
            Button {
            } label: {
                VStack(spacing: 10) {
                    Image("Menu")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .rotationEffect(.init(degrees: 90))
                }
            }
        }
    }
}
