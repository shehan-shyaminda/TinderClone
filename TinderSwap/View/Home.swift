//
//  Home.swift
//  TinderSwap
//
//  Created by STEPHEN INNOVATIONS on 2022-05-17.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            // Top Nav Bar
            Button(action: {
                
            }, label:  {
                Image("menu")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(
                Text("Discover")
                    .font(.title.bold())
            )
            .foregroundColor(.black)
            .padding()
            
            // Users Stafck
            ZStack{
                if let users = homeData.displaying_users{
                    if users.isEmpty {
                        Text("Come back later we can find more matches for you!")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }else{
                        // Displaying Cards...
                        ForEach(users.reversed()){ user in
                            // Card View...
                            // Cards are reversed since its ZStack
                            // you can use reverse here...
                            // or you can use while fetching users...
                            StackCardView(user: user)
                                .environmentObject(homeData)
                        }
                    }
                }else{
                    ProgressView()
                }
            }
            .padding()
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Action Buttons...
            HStack(spacing: 15){
                Button(action: {
                    withAnimation{
                        homeData.refreshData()
                    }
                }, label: {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(Color("Gray"))
                        .clipShape(Circle())
                })
            
                Button(action: {
                    doSwipe(rightSwipe: false)
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(18)
                        .background(Color("Blue"))
                        .clipShape(Circle())
                })
                .disabled(homeData.displaying_users?.isEmpty ?? false)
            
                Button(action: {}, label: {
                    Image(systemName: "star.fill")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(Color("Yellow"))
                        .clipShape(Circle())
                })
                .disabled(homeData.displaying_users?.isEmpty ?? false)
            
                Button(action: {
                    doSwipe(rightSwipe: true)
                }, label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(18)
                        .background(Color("Pink"))
                        .clipShape(Circle())
                })
                .disabled(homeData.displaying_users?.isEmpty ?? false)
            }
            .padding(.bottom)
            .opacity((homeData.displaying_users?.isEmpty ?? false) ? 0.6 : 1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(colorScheme == .dark ? Color.white : Color.white)
    }
    
    // removing cards when doing Swipe...
    func doSwipe(rightSwipe: Bool = false){
        guard let first = homeData.displaying_users?.first else {
            return
        }
        
        //Using Notification to post and receiving in Stack Cards...
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": first.id,
            "rightSwipe": rightSwipe
        ])
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
