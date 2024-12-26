//
//  UserProfileView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct UserProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = UserProfileViewModel()

    let user: User
    var onUserReported: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            UserProfileHeaderView(user: user, dismiss: dismiss)
                .padding(.horizontal)
            
            ScrollView {
                VStack(spacing: 16) {
                    UserProfileImageCarouselView(user: user, currentImageIndex: $viewModel.currentImageIndex)
                    
                    UserProfileInfoSectionView(title: "About Me") {
                        Text(user.bio.isEmpty ? "Prefers to keep it mysterious..." : user.bio)
                            .customFont(.medium, 14)
                            .foregroundColor(.primary)
                    }
                    
                    UserProfileInfoSectionView(title: "Essentials") {
                        UserProfileInfoRowView(icon: "person", title: user.gender.rawValue)
                        UserProfileInfoRowView(icon: "arrow.down.forward.and.arrow.up.backward.circle", title: user.preference.rawValue)
                        UserProfileInfoRowView(icon: "book", title: user.occupation)
                        UserProfileInfoRowView(icon: "mappin.and.ellipse", title: "\(user.city), \(user.country)")
                    }
                    
                    UserProfileInfoSectionView(title: "Interests") {
                        UserProfileInfoRowView(icon: "star", title: user.interest.rawValue)
                    }
                    
                    UserProfileInfoSectionView(title: "Hobbies") {
                        UserProfileHobbiesRowView(hobbies: user.hobbies)
                    }
                    
                    ActionButtonView(
                        title: "Report User",
                        mode: .outlined
                    ) {
                        viewModel.showReportSheet = true
                    }.padding(.bottom)
                }
                .padding(.horizontal)
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .onReceive(viewModel.$userReported) { isUserReported in
            if isUserReported {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    onUserReported?()
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
        .sheet(isPresented: $viewModel.showReportSheet) {
            ReportUserSheet(isPresented: $viewModel.showReportSheet) { reason in
                viewModel.onUserReported(userId: user.id, reason: reason)
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(user: MockData.users[0])
    }
}
