//
//  EditProfileViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI
import Factory

class EditProfileViewModel: BaseUserViewModel {
    
    @Published var bio = ""
    @Published var occupation = ""
    @Published var selectedGender: String = Gender.male.rawValue
    @Published var selectedPreference: String = Preference.friendship.rawValue
    @Published var selectedInterest: String = Interest.men.rawValue

}

