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
                
                // Picture Selection Section
                PictureSelectionGridView(images: $viewModel.profileImages)
                    .padding()
                
                VStack(spacing: 24) {
                    // USERNAME Section
                    ProfileSectionView(
                        title: "USERNAME",
                        icon: "person.fill",
                        content: AnyView(
                            TextField("Enter your username", text: $viewModel.username)
                                .customFont(.medium, 16)
                                .padding()
                                .frame(alignment: .top)
                                .lineLimit(1)
                                .background(Color(.secondarySystemBackground))
                        )
                    )
                    
                    // BIRTHDATE Section
                    ProfileSectionView(
                        title: "BIRTHDATE",
                        icon: "calendar",
                        content: AnyView(
                            HStack {
                                Text(viewModel.birthdate.formatString())
                                    .customFont(.medium, 16)
                                    .padding()
                                                    
                                Spacer()
                                                    
                                Button(action: {
                                    viewModel.showDatePicker.toggle()
                                }) {
                                    Image(systemName: "calendar")
                                        .font(.title)
                                        .foregroundColor(.pink)
                                        .padding()
                                    }
                                }
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(8)
                                    
                                .popover(isPresented: $viewModel.showDatePicker) {
                                    VStack(spacing: 16) {
                                        HStack {
                                            Image(systemName: "calendar.badge.clock")
                                                .font(.title2)
                                                .foregroundColor(.pink)
                                            
                                            Text("Select Your Birthdate")
                                                .customFont(.semiBold, 20)
                                        }
                                        .padding(.top, 16)

                                        DatePicker(
                                            "Enter your birthdate",
                                            selection: $viewModel.birthdate,
                                            displayedComponents: .date
                                        )
                                        .datePickerStyle(GraphicalDatePickerStyle())
                                        .padding()
                                        .background(Color(.secondarySystemBackground))
                                        .cornerRadius(8)
                                        
                                    
                                        ActionButtonView(title: "Done", mode: .filled) {
                                            viewModel.showDatePicker.toggle()
                                        }
                                        .padding(.bottom, 16)
                                    }
                                }
                            )
                    )
                    
                    // ABOUT ME Section
                    ProfileSectionView(
                        title: "ABOUT ME",
                        icon: "person.crop.circle",
                        content: AnyView(
                            TextField("Add your bio", text: $viewModel.bio, axis: .vertical)
                                .customFont(.medium, 16)
                                .padding()
                                .frame(alignment: .top)
                                .background(Color(.secondarySystemBackground))
                        )
                    )
                    
                    // OCCUPATION Section
                    ProfileSectionView(
                        title: "OCCUPATION",
                        icon: "briefcase",
                        content: AnyView(
                            TextField("Add your occupation", text: $viewModel.occupation)
                                .customFont(.medium, 16)
                                .padding()
                                .frame(alignment: .top)
                                .lineLimit(1)
                                .background(Color(.secondarySystemBackground))
                        )
                    )
                    
                    // GENDER Section
                    PickerSectionView(
                        title: "GENDER",
                        icon: "person.fill",
                        selection: $viewModel.selectedGender,
                        options: Gender.allCases.map { $0.rawValue }
                    )
                    
                    // SEXUAL ORIENTATION Section
                    PickerSectionView(
                        title: "SEXUAL ORIENTATION",
                        icon: "heart.fill",
                        selection: $viewModel.selectedPreference,
                        options: Preference.allCases.map { $0.rawValue }
                    )

                    // INTEREST Section
                    PickerSectionView(
                        title: "INTEREST",
                        icon: "sparkle",
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
                        viewModel.updateUser()
                    }
                    .foregroundColor(Color.pink)
                    .fontWeight(.semibold)
                }
            }
            .onReceive(viewModel.$profileUpdated) { isUpdated in
                if isUpdated {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        dismiss()
                    }
                }
            }
            .modifier(LoadingAndMessageOverlayModifier(
                isLoading: $viewModel.isLoading,
                message: viewModel.message,
                messageType: viewModel.messageType,
                duration: 3.0
            ))
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
