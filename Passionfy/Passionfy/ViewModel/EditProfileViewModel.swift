//
//  EditProfileViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI
import Factory

class EditProfileViewModel: BaseUserViewModel {
    
    @Injected(\.updateUserUseCase) private var updateUserUseCase: UpdateUserUseCase
    
    @Published var username = ""
    @Published var birthdate: Date = Date()
    @Published var bio = ""
    @Published var occupation = ""
    @Published var selectedGender: String = Gender.male.rawValue
    @Published var selectedPreference: String = Preference.friendship.rawValue
    @Published var selectedInterest: String = Interest.men.rawValue
    @Published var profileImages: [UnifiedImage] = []
    
    @Published var showDatePicker = false
    @Published var profileUpdated = false
    
    func updateUser() {
        let imageDatas: [Data] = self.profileImages.compactMap ({ image in
            if case .local(let uIImage) = image {
                return uIImage.jpegData(compressionQuality: 0.5)
            }
            return nil
        })
        executeAsyncTask {
            return try await self.updateUserUseCase.execute(params: UpdateUserParams(
                username: self.username,
                birthdate: self.birthdate.formatString(),
                occupation: self.occupation,
                bio: self.bio,
                gender: Gender(rawValue: self.selectedGender),
                preference: Preference(rawValue: self.selectedPreference),
                interest: Interest(rawValue: self.selectedInterest),
                profileImages: imageDatas
            ))
        } completion: { [weak self] result in
            guard let self = self, case .success(let user) = result else { return }
            self.successMessage = "Profile updated successfully!"
            self.errorMessage = nil
            self.profileUpdated = true
            self.onCurrentUserLoaded(user: user)
        }
    }
    
    override func onCurrentUserLoaded(user: User) {
        self.username = user.username
        if let birthdate = user.birthdate.toDate() {
            self.birthdate = birthdate
        }
        self.bio = user.bio
        self.occupation = user.occupation
        self.selectedGender = user.gender.rawValue
        self.selectedPreference = user.preference.rawValue
        self.selectedInterest = user.interest.rawValue
        self.profileImages = user.profileImageUrls.compactMap({ URL(string: $0) }).map({ .remote($0)})
    }
}


