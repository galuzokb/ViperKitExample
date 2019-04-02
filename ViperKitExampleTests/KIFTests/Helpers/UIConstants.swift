//
//  UIConstants.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/18/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

struct UIConstants {
    
    struct CommonAccessibilityLabels {
        static let PKHUDView = "PKHUD Progress View"
    }
    
    struct SplashAccessibilityLabels {
        static let backgroundView = "Splash Background View"
    }
    
    struct SigninAccessibilityLabels {
        static let backgroundView = "Sign In Background View"
        static let usernameTF = "Username Textfield"
        static let passwordTF = "Password Textfield"
        static let signinBtn = "Sign In Button"
    }
    
    struct SigninAlertLabels {
        static let wrongUsername = "Wrong username!"
        static let wrongPassword = "Wrong password!"
        static let wrongCredentials = "Wrong credentials!"
    }
    
    struct PostsAccessibilityLabels {
        static let backgroundView = "Posts Background View"
        static let tableView = "Posts Table View"
        static let logoutBtn = "Log Out Button"
        static let createPostBtn = "Create Post Button"
        static let tableTopView = "Posts Table View Top View"
        static let editBtn = "Edit Button"
        static let textLbl = "Text Label"
        
        static let idLbl = "Cell ID Label"
        static let titleLbl = "Cell Title Label"
        static let deleteBtn = "Cell Delete Button"
        
        static let refreshControl = "Posts Table View Refresh Control"
        
        static let tabBarItem = "Posts Tab Bar Item"
    }
    
    struct PostAccessibilityLabels {
        static let backgroundView = "Post Background View"
        static let backBtn = "Post Back Button"
        static let doneBtn = "Post Done Button"
        static let postIDLbl = "Post ID Label"
        static let userIDLbl = "User ID Label"
        static let titleTV = "Post Title Text View"
        static let bodyTV = "Post Title Text View"
    }
    
    struct EditTextAccessibilityLabels {
        static let backgroundView = "Edit Text Background View"
        static let textView = "Text View"
        static let cancelBtn = "Cancel Button"
        static let doneBtn = "Done Button"
    }
    
    struct SearchAccessibilityLabels {
        static let tabBarItem = "Search Tab Bar Item"
        static let searchBar = "Search Search Bar"
        static let tableView = "Search Table View"
    }
    
    struct SearchAlertLabels {
        static let wrongSearchTerm = "Enter ID in search field"
    }
}
