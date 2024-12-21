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
                    Section(header: Text("Privacy")) {
                        NavigationLink(destination: PrivacyPolicyView()) {
                            Text("Privacy Policy")
                                .customFont(.medium, 16)
                        }
                        NavigationLink(destination: DataSecurityView()) {
                            Text("Data Security")
                                .customFont(.medium, 16)
                        }
                    }
                    
                    // Logout and delete account
                    Section {
                        VStack(spacing: 16) {
                            ActionButtonView(
                                title: "Logout",
                                mode: .filled,
                                width: 300
                            ) {
                                viewModel.showSignOutAlert.toggle()
                            }
                            
                            Divider()
                                .background(Color.gray.opacity(0.5))
                                .padding(.horizontal)
                            
                            ActionButtonView(
                                title: "Delete Account",
                                mode: .outlined,
                                width: 300
                            ) {
                                print("DEBUG: Delete account")
                            }
                        }
                        .padding()
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

struct CurrentUserProfile_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfile()
    }
}

