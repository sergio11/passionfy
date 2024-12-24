//
//  EditProfileViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI
import Factory
import CoreLocation

class EditProfileViewModel: BaseUserViewModel {
    
    @Injected(\.updateUserUseCase) private var updateUserUseCase: UpdateUserUseCase
    @Injected(\.locationService) private var locationService: LocationService
    
    @Published var username = ""
    @Published var birthdate: Date = Date()
    @Published var bio = ""
    @Published var occupation = ""
    @Published var selectedGender: String = Gender.male.rawValue
    @Published var selectedPreference: String = Preference.friendship.rawValue
    @Published var selectedInterest: String = Interest.men.rawValue
    @Published var profileImages: [UnifiedImage] = []
    @Published var userCoordinates: UserCoordinates?
    @Published var userCity: String = ""
    @Published var userCountry: String = ""
    @Published var isLoadingLocation: Bool = false
    @Published var showDatePicker = false
    @Published var profileUpdated = false
    
    override init() {
        super.init()
        locationService.delegate = self
    }
    
    func updateUser() {
        let imageDatasWithIndices: [(index: Int, data: Data)] = self.profileImages.enumerated().compactMap { (index, image) in
            if case .local(let uIImage) = image, let imageData = uIImage.jpegData(compressionQuality: 0.5) {
                return (index, imageData)
            }
            return nil
        }
        executeAsyncTask {
            return try await self.updateUserUseCase.execute(params: UpdateUserParams(
                username: self.username,
                birthdate: self.birthdate.formatString(),
                occupation: self.occupation,
                bio: self.bio,
                gender: Gender(rawValue: self.selectedGender),
                preference: Preference(rawValue: self.selectedPreference),
                interest: Interest(rawValue: self.selectedInterest),
                profileImages: imageDatasWithIndices,
                userCoordinates: self.userCoordinates,
                userCity: self.userCity,
                userCountry: self.userCountry
            ))
        } completion: { [weak self] result in
            guard let self = self, case .success(let user) = result else { return }
            self.successMessage = "Profile updated successfully!"
            self.errorMessage = nil
            self.profileUpdated = true
            self.onCurrentUserLoaded(user: user)
        }
    }
    
    func updateLocation() {
        self.isLoadingLocation = true
        locationService.requestPermission()
        locationService.startUpdatingLocation()
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
        self.userCity = user.city
        self.userCountry = user.country
    }
}

extension EditProfileViewModel: LocationServiceDelegate {
    func didUpdateLocation(_ location: CLLocation, city: String, country: String) {
        print("[EditProfileViewModel] Received updated location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        print("[EditProfileViewModel] City: \(city), Country: \(country)")
        // Update ViewModel properties
        userCoordinates = UserCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        userCity = city
        userCountry = country
        
        locationService.stopUpdatingLocation()
        self.isLoadingLocation = false
    }
    
    func didChangeAuthorizationStatus(_ status: CLAuthorizationStatus) {
        print("[EditProfileViewModel] Authorization status changed: \(status.rawValue)")
    }
    
    func didFailWithError(_ error: Error) {
        print("[EditProfileViewModel] Location service error: \(error.localizedDescription)")
    }
}


