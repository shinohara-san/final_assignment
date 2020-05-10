//
//  MatchingListView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/05/02.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//
import SwiftUI

struct MatchingListView: View {
    @EnvironmentObject var shareData: ShareData

    var body: some View {
        //       Group{
        GeometryReader{ geometry in
            ZStack{
                self.shareData.pink.edgesIgnoringSafeArea(.all)
                NavigationView{
                    
                    List{
                        ForEach(self.shareData.filteredMatchUserArray, id: \.matchRoomId){ user in
                            //id: がないとForEachが狂う？ idでダメだったのでmatchRoomIdに変えたら行けた
                            NavigationLink(destination: MessageView(user, user.matchRoomId)){
                                VStack{
                                    HStack{
                                    FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.1)
                                        .clipShape(Circle()).shadow(radius: 2, x:2, y:2).animation(.spring())
                                    
                                        if self.shareData.goodUser(user: user){
                                            Image(systemName: "hand.thumbsup.fill").foregroundColor(.yellow)
                                        
                                        Text(user.name)
                                    }
                                    Text(user.name)
                                    Text(user.age)
                                }.foregroundColor(self.shareData.black).frame(width: geometry.size.width * 1, alignment: .leading)

                                }
                            }.disabled(self.shareData.naviLinkOff)
                            .listRowBackground(self.shareData.emptyUser(user: user) ? self.shareData.white : self.shareData.white2) //foreachに
                            }
                        }
                    .onAppear { UITableView.appearance().separatorStyle = .none}
                    .onDisappear { UITableView.appearance().separatorStyle = .none }
                    .navigationBarTitle(Text("マッチ一覧"), displayMode: .inline)
                    .navigationBarItems(trailing:
                    Button(action: {
                        self.shareData.myProfile = true
                    }, label: {
                        Image(systemName: "house.fill").foregroundColor(self.shareData.white)
                    })
                    )
                }
            }
        }.onAppear{
            self.shareData.getAllMatchUser()
        }.onDisappear{
            self.shareData.matchUserArray = [User]()
        }
    }
}

struct MatchingListView_Previews: PreviewProvider {
    static var previews: some View {
        MatchingListView()
    }
}
