//
//  EditProfileView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = EditProfileViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                if let user = viewModel.user {
                    ProfileImageGridView(user: user)
                        .padding()
                }
                
                VStack(spacing: 24) {
                    // ABOUT ME Section
                    ProfileSectionView(
                        title: "ABOUT ME",
                        content: AnyView(
                            TextField("Add your bio", text: $viewModel.bio, axis: .vertical)
                                .customFont(.medium, 16)
                                .padding()
                                .frame(height: 64, alignment: .top)
                                .background(Color(.secondarySystemBackground))
                        )
                    )
                    
                    // OCCUPATION Section
                    ProfileSectionView(
                        title: "OCCUPATION",
                        content: AnyView(
                            HStack {
                                Image(systemName: "book")
                                Text("Occupation")
                                Spacer()
                                Text(viewModel.occupation)
                                    .customFont(.medium, 16)
                            }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .font(.subheadline)
                        )
                    )
                    
                    // GENDER Section
                    PickerSectionView(
                        title: "GENDER",
                        selection: $viewModel.selectedGender,
                        options: Gender.allCases.map { $0.rawValue }
                    )
                    
                    // SEXUAL ORIENTATION Section
                    PickerSectionView(
                        title: "SEXUAL ORIENTATION",
                        selection: $viewModel.selectedPreference,
                        options: Preference.allCases.map { $0.rawValue }
                    )

                    // INTEREST Section
                    PickerSectionView(
                        title: "INTEREST",
                        selection: $viewModel.selectedInterest,
                        options: Interest.allCases.map { $0.rawValue }
                    )
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
            .onAppear {
                viewModel.loadCurrentUser()
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
