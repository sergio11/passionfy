//
//  CurrentUserProfile.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct CurrentUserProfile: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                if let user = viewModel.user {
                    // Header view
                    Section {
                        CurrentUserProfileHeaderView(user: user)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.showEditProfile.toggle()
                                }
                            }
                    }
                    .listRowInsets(EdgeInsets())
                    .background(Color(.systemGray6))
                    
                    // Account info
                    Section(header: Text("Account Information")) {
                        ProfileRow(label: "Name", value: user.username)
                        if let birthdate = user.birthdate.toDate() {
                            ProfileRow(label: "Age", value: "\(birthdate.age) years old")
                        } else {
                            ProfileRow(label: "Age", value: "N/A")
                        }
                    }
                    
                    // Legal
                    Section(header: Text("Legal")) {
                        NavigationLink(destination: TermsOfServiceView()) {
                            Text("Terms of Service")
                                .customFont(.medium, 16)
                        }
                    }
                    
                    // Contact
                    Section(header: Text("Contact")) {
                        NavigationLink(destination: ContactUsView()) {
                            Text("Contact Us")
                                .customFont(.medium, 16)
                        }
                        NavigationLink(destination: FeedbackView()) {
                            Text("Provide Feedback")
                                .customFont(.medium, 16)
                        }
                    }
                                        
                    // Privacy
                    Section(
                        header: Text("Privacy"),
                        footer: ProfileActions(showSignOutAlert: $viewModel.showSignOutAlert)
                    ) {
                        NavigationLink(destination: PrivacyPolicyView()) {
                            Text("Privacy Policy")
                                .customFont(.medium, 16)
                        }
                        NavigationLink(destination: DataSecurityView()) {
                            Text("Data Security")
                                .customFont(.medium, 16)
                        }
                    }
                    
                } else {
                    // Placeholder for loading or error state
                    Section {
                        HStack {
                            Spacer()
                            Text("Loading user information...")
                                .customFont(.medium, 16)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.insetGrouped)
            .fullScreenCover(
                isPresented: $viewModel.showEditProfile,
                onDismiss: {
                    viewModel.loadCurrentUser()
                }
            ) {
                EditProfileView()
            }
            .onAppear {
                viewModel.loadCurrentUser()
            }
            .alert(isPresented: $viewModel.showSignOutAlert) {
                Alert(
                    title: Text("Are you sure?"),
                    message: Text("Do you really want to sign out?"),
                    primaryButton: .destructive(Text("Sign Out")) {
                        viewModel.signOut()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

// Reusable row for profile info
private struct ProfileRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .customFont(.medium, 16)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .customFont(.regular, 16)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

private struct ProfileActions: View {
    
    @Binding var showSignOutAlert: Bool
    
    var body: some View {
        VStack {
            
            Text("Managing your account settings is simple. You can log out or delete your account below.")
                .customFont(.regular, 14)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            ActionButtonView(
                title: "Logout",
                mode: .filled,
                width: 300
            ) {
                showSignOutAlert.toggle()
            }
            ActionButtonView(
                title: "Delete Account",
                mode: .outlined,
                width: 300
            ) {
                print("DEBUG: Delete account")
            }
            
            Text("Built with passion by DreamSoftware. Sergio Sánchez Sánchez © 2024")
                .customFont(.regular, 12)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}

struct CurrentUserProfile_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfile()
    }
}

