//
//  FirebaseAuthenticationDataSourceImpl.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation
import Firebase
import FirebaseFirestore

/// A data source responsible for handling authentication operations using Firestore.
internal class FirebaseAuthenticationDataSourceImpl: AuthenticationDataSource {
    
    /// Signs in with the provided phone number asynchronously.
        /// - Parameter phoneNumber: The phone number to be verified.
        /// - Returns: A verification ID as a string.
        /// - Throws: An `AuthenticationError` in case of failure, including `phoneVerificationFailed` if phone verification fails.
    func signInWithPhone(phoneNumber: String) async throws -> String {
        do {
            let result = try await PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil)
            return result
        } catch {
            print(error.localizedDescription)
            throw AuthenticationDataSourceException.phoneVerificationFailed(message: "Phone verification failed: \(error.localizedDescription)", cause: error)
        }
    }
        
    /// Verifies the OTP (One-Time Password) code received through SMS verification.
        /// - Parameters:
        ///   - verificationCode: The verification ID received during phone number verification.
        ///   - otpCode: The OTP code received via SMS.
        /// - Returns: The user ID associated with the successfully signed-in user.
        /// - Throws: An `AuthenticationError` in case of failure, including `signInFailed` if sign-in fails.
    func verifyOTP(verificationCode: String, otpCode: String) async throws -> String {
        do {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: otpCode)
            let result = try await Auth.auth().signIn(with: credential)
            return result.user.uid
        } catch {
            print(error.localizedDescription)
            throw AuthenticationDataSourceException.signInFailed(message: "Sign-in failed: \(error.localizedDescription)", cause: error)
        }
    }
    
    /// Signs out the current user.
        /// - Throws: An `AuthenticationError` in case of failure, including `signOutFailed` if sign-out fails.
    func signOut() async throws {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
            throw AuthenticationDataSourceException.signOutFailed(message: "Sign-out failed: \(error.localizedDescription)", cause: error)
        }
    }
        
    /// Retrieves the ID of the current user.
        /// - Returns: The user ID if the user is signed in, otherwise `nil`.
    func getCurrentUserId() async throws -> String {
        guard let userSession = Auth.auth().currentUser else {
            throw AuthenticationDataSourceException.invalidSession(message: "An error ocurred when trying to get current user id", cause: nil)
        }
        return userSession.uid
    }
}
