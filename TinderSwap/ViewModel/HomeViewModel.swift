//
//  HomeViewModel.swift
//  TinderSwap
//
//  Created by STEPHEN INNOVATIONS on 2022-05-17.
//

import SwiftUI

// View model and it holds all user data...
class HomeViewModel: ObservableObject {
    
    // Store All the fetched Users here...
    // Since we're building UI so using sample Users here...
    @Published var fetched_users: [User] = []

    @Published var displaying_users: [User]?
    
    init(){
        // fetching users...
        fetched_users = [
            User(name: "Natalia", place: "Vadalia NYC", profilePic: "user0"),
            User(name: "Elisa", place: "Central Park NYC", profilePic: "user1"),
            User(name: "Jasmine", place: "Metropolitan NYC", profilePic: "user2"),
            User(name: "zahra", place: "Liberty NYC", profilePic: "user3"),
            User(name: "Brittany", place: "vadalia NYC", profilePic: "user4"),
            User(name: "Angelina", place: "Empitre State NYC", profilePic: "user5"),
            User(name: "Roshel", place: "Time Square NYC", profilePic: "user6")
        ]
        
        // store it in displaying users...
        // what is displaying users?
        // it will be updated/removed based on user interaction to reduce memory usage...
        // and the same time we need all the fetched user data...
        
        displaying_users = fetched_users
    }
    
    func getIndex(user: User)->Int{
        let index = displaying_users?.firstIndex(where: { currentUser in
            return user.id == currentUser.id
        }) ?? 0
        
        return index
    }
    
    func refreshData(){
        displaying_users = fetched_users
    }
}

