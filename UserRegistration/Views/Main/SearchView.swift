//
//  SearchView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var shareData: ShareData
    @State var hometown = ""
    @State var purpose = ""
    @State var subject = ""
    
    @State var isModal = false
    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "", fee: "", schedule: "", place: "")
 
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    self.shareData.white.edgesIgnoringSafeArea(.all)
                    List{
                        ForEach(self.shareData.filteredSearchedUsers, id: \.id){ user in
                            VStack{
                                HStack{
                                    FirebaseImageView(imageURL: user.photoURL).frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.2)
                                        .clipShape(Circle()).shadow(radius: 2, x:2, y:2)
                                        .padding(.top, 8).padding(.leading)
                                    VStack(alignment: .leading,spacing: 5){
                                        HStack{
                                            if self.shareData.goodUser(user: user){
                                                Image(systemName: "hand.thumbsup.fill").foregroundColor(.yellow)
                                            }
                                            Text(user.name)
                                        }
                                        Text(user.age)
                                        
                                    }.foregroundColor(self.shareData.black).frame(width: geometry.size.width * 0.5, alignment: .leading)
                                }
                                .onTapGesture {
                                    if user.id == "" {return}
                                    self.userInfo = user
                                    self.isModal = true
                                }
                                if user.id == "" {
                                    Divider().hidden()
                                } else {
                                    Divider()
                                }
                            }.listRowBackground(self.shareData.emptyUser(user: user) ? self.shareData.white : self.shareData.white2)
                        }
                        
                        
                        
                    } //list
                        
                        .onAppear { UITableView.appearance().separatorStyle = .none }
                        .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
                        .sheet(isPresented: self.$isModal) {
                            UserProfileView(user: self.userInfo, matchUserProfile: false).environmentObject(self.shareData)
                    }
                    .navigationBarTitle(Text("ユーザー検索"), displayMode: .inline)
                    .navigationBarItems(leading:
                        Button(action: {
                            self.shareData.searchBoxOn.toggle()
                        }, label: {
                            Image(systemName: "magnifyingglass").foregroundColor(self.shareData.white)
                        }),
                                        trailing:
                        Button(action: {
                            self.shareData.myProfile = true
                        }, label: {
                            Image(systemName: "house.fill").foregroundColor(self.shareData.white)
                        })
                    )
                        .onAppear{
                            self.shareData.filteredSearchedUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "",fee: "", schedule:"", place:"")]
                    }
                    .onDisappear{
                        //                self.userProfileOn = false
                        self.shareData.filteredSearchedUsers = [User]()
                        self.hometown = ""
                        self.purpose = ""
                        self.subject = ""
                    }
                    
                    
                    
                } //navi
            }
            
        }
        
    }
    
    
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
