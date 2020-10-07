//
//  UserData.swift
//  SUStudy_Week2
//
//  Created by Yunjae Kim on 2020/09/03.
//  Copyright © 2020 Yunjae Kim. All rights reserved.
//


import SwiftUI
import Combine

final class UserData: ObservableObject  {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
    @Published var showFeaturedOnly = false

    @Published var profile = Profile.default

}



