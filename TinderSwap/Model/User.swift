//
//  User.swift
//  TinderSwap
//
//  Created by STEPHEN INNOVATIONS on 2022-05-17.
//

import SwiftUI

// User Model...
struct User: Identifiable {
    var id = UUID().uuidString
    var name: String
    var place: String
    var profilePic: String
}
