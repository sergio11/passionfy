//
//  UserProfileView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI
import Kingfisher

struct UserProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var currentImageIndex = 0
    
    let user: User
    
    var body: some View {
        VStack {
            HeaderView(user: user, dismiss: dismiss)
                .padding(.horizontal)
            
            ScrollView {
                VStack(spacing: 16) {
                    ProfileImageCarousel(user: user, currentImageIndex: $currentImageIndex)
                    
                    InfoSection(title: "About Me") {
                        Text(user.bio.isEmpty ? "Prefers to keep it mysterious..." : user.bio)
                            .customFont(.medium, 14)
                            .foregroundColor(.primary)
                    }
                    
                    InfoSection(title: "Essentials") {
                        ProfileInfoRow(icon: "person", title: user.gender.rawValue)
                        ProfileInfoRow(icon: "arrow.down.forward.and.arrow.up.backward.circle", title: user.preference.rawValue)
                        ProfileInfoRow(icon: "book", title: user.occupation)
                        ProfileInfoRow(icon: "mappin.and.ellipse", title: user.location)
                    }
                    
                    InfoSection(title: "Interests") {
                        ProfileInfoRow(icon: "star", title: user.interest.rawValue)
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

private struct HeaderView: View {
    let user: User
    let dismiss: DismissAction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(user.username)
                    .customFont(.semiBold, 20)
                
                if let birthdate = user.birthdate.toDate() {
                    Text("\(birthdate.age) years old")
                        .customFont(.regular, 18)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.down.circle.fill")
                    .imageScale(.large)
                    .fontWeight(.bold)
                    .foregroundStyle(.pink)
            }
        }
    }
}

private struct ProfileImageCarousel: View {
    let user: User
    @Binding var currentImageIndex: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            KFImage(URL(string: user.profileImageUrls[currentImageIndex]))
                .resizable()
                .scaledToFill()
                .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
                .overlay {
                    ImageScrollingOverlay(currentImageIndex: $currentImageIndex, imageCount: user.profileImageUrls.count)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            CardImageIndicatorView(currentImageIndex: currentImageIndex, imageCount: user.profileImageUrls.count)
        }
    }
}

private struct InfoSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .customFont(.semiBold, 16)
            
            content
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

private struct ProfileInfoRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.pink)
            
            Text(title)
                .customFont(.medium, 14)
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}


struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(user: MockData.users[0])
    }
}
