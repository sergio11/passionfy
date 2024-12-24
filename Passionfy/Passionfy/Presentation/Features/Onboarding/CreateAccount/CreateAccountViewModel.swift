//
//  CreateAccountViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI
import Factory
import Combine
import CoreLocation

class CreateAccountViewModel: BaseAuthViewModel {
    
    @Published var username = ""
    @Published var birthdate = Birthdate(day: "", month: "", year: "")
    @Published var occupation: String = ""
    @Published var gender: Gender? = nil
    @Published var selectedPreference: Preference? = nil
    @Published var selectedInterest: Interest? = nil
    @Published var profileImages: [UnifiedImage] = []
    @Published var userCoordinates: (latitude: Double, longitude: Double)?
    @Published var userCity: String = ""
    @Published var userCountry: String = ""
    @Published var accountFlowStep: AccountFlowStepEnum = .welcome
    
    @Injected(\.verifyUsernameAvailabilityUseCase) private var verifyUsernameAvailabilityUseCase: VerifyUsernameAvailabilityUseCase
    @Injected(\.sendOtpUseCase) private var sendOtpUseCase: SendOtpUseCase
    @Injected(\.signUpUseCase) private var signUpUseCase: SignUpUseCase
    @Injected(\.locationService) private var locationService: LocationService
    
    override init() {
        super.init()
        locationService.delegate = self
    }
    
    func verifyUsernameAvailability() {
        executeAsyncTask {
            return try await self.verifyUsernameAvailabilityUseCase.execute(params: VerifyUsernameParams(username: self.username))
        } completion: { [weak self] result in
            guard let self = self else { return }
            if case let .success(isAvailable) = result {
                if isAvailable {
                    self.nextFlowStep()
                } else {
                    self.errorMessage = "There is already a user using this username, please use another one"
                    self.showAlert = true
                }
            }
        }
    }
    
    
    func sendOtp() {
        guard !isLoading else { return }
        executeAsyncTask {
            return try await self.sendOtpUseCase.execute(phoneNumber: self.phoneNumber, country: self.country)
        } completion: { [weak self] result in
            guard let self = self, case let .success(code) = result else { return }
            self.verificationCode = code
            self.nextFlowStep()
        }
    }
    
    func signUp() {
        let imageDatas: [Data] = self.profileImages.compactMap ({ image in
            if case .local(let uIImage) = image {
                return uIImage.jpegData(compressionQuality: 0.5)
            }
            return nil
        })
        guard
            let gender = self.gender,
            let preference = self.selectedPreference,
            let interest = self.selectedInterest,
            let userCoords = self.userCoordinates,
            !self.username.isEmpty,
            !self.phoneNumber.isEmpty,
            !self.otpText.isEmpty
        else {
            return
        }
        executeAsyncTask {
            return try await self.signUpUseCase.execute(params: SignUpParams(
                name: self.username,
                birthdate: self.birthdate.date,
                occupation: self.occupation,
                gender: gender,
                selectedPreference: preference,
                selectedInterest: interest,
                profileImages: imageDatas,
                phoneNumber: self.phoneNumber,
                verificationCode: self.verificationCode,
                otpText: self.otpText,
                userCoordinates: userCoords,
                userCity: self.userCity,
                userCountry: self.userCountry
            ))
        } completion: { [weak self] result in
            guard let self = self, case .success = result else { return }
            self.nextFlowStep()
        }
    }
    
    func nextFlowStep() {
        switch accountFlowStep {
        case .welcome:
            accountFlowStep = .username
        case .username:
            accountFlowStep = .birthdate
        case .birthdate:
            accountFlowStep = .gender
        case .gender:
            accountFlowStep = .interest
        case .interest:
            accountFlowStep = .preference
        case .preference:
            accountFlowStep = .occupation
        case .occupation:
            accountFlowStep = .requestLocation
        case .requestLocation:
            accountFlowStep = .pictures
        case .pictures:
            accountFlowStep = .phoneNumber
        case .phoneNumber:
            accountFlowStep = .otp
        case .otp:
            accountFlowStep = .completed
        case .completed:
            break
        }
    }
    
    func previousFlowStep() {
        switch accountFlowStep {
        case .welcome:
            break
        case .username:
            accountFlowStep = .welcome
        case .birthdate:
            accountFlowStep = .username
        case .gender:
            accountFlowStep = .birthdate
        case .interest:
            accountFlowStep = .gender
        case .preference:
            accountFlowStep = .interest
        case .occupation:
            accountFlowStep = .preference
        case .requestLocation:
            accountFlowStep = .occupation
        case .pictures:
            accountFlowStep = .requestLocation
        case .phoneNumber:
            accountFlowStep = .pictures
        case .otp:
            accountFlowStep = .phoneNumber
        case .completed:
            accountFlowStep = .otp
        }
    }
    
    func requestLocationPermission() {
        locationService.requestPermission()
        locationService.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationService.stopUpdatingLocation()
    }
}

extension CreateAccountViewModel: LocationServiceDelegate {
    func didUpdateLocation(_ location: CLLocation, city: String, country: String) {
        print("[CreateAccountViewModel] Received updated location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        print("[CreateAccountViewModel] City: \(city), Country: \(country)")
        
        // Update ViewModel properties
        userCoordinates = (latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        userCity = city
        userCountry = country
    }
    
    func didChangeAuthorizationStatus(_ status: CLAuthorizationStatus) {
        print("[CreateAccountViewModel] Authorization status changed: \(status.rawValue)")
    }
    
    func didFailWithError(_ error: Error) {
        print("[CreateAccountViewModel] Location service error: \(error.localizedDescription)")
    }
}

enum AccountFlowStepEnum {
    case welcome
    case username
    case birthdate
    case gender
    case preference
    case interest
    case occupation
    case requestLocation
    case pictures
    case phoneNumber
    case otp
    case completed
}
