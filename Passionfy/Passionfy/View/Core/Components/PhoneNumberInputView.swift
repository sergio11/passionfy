//
//  PhoneNumberInputView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct PhoneNumberInputView: View {
    
    @Binding var showCountryList: Bool
    @Binding var phoneNumber: String
    @Binding var country: Country
    var title: String
    var label: String
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 8) {
                Text(title)
                    .customFont(.regular, 16)
                    .foregroundColor(Color.pink.opacity(0.8))
                    .multilineTextAlignment(.center)
                HStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 1)
                        .frame(width: 75, height: 45)
                        .foregroundColor(Color.pink.opacity(0.8))
                        .overlay(
                            Text("\(country.flag(country: country.isoCode))")
                            +
                            Text("+\(country.phoneCode)")
                                .customFont(.bold, 12)
                                .foregroundColor(Color.pink.opacity(0.8))
                        ).onTapGesture {
                            self.showCountryList.toggle()
                        }
                    
                    Text(label)
                        .customFont(.bold, 30)
                        .foregroundColor(Color.pink.opacity(0.6))
                        .opacity(phoneNumber.isEmpty ? 1.0: 0)
                        .frame(width: 250)
                        .overlay(
                            TextField("", text: $phoneNumber)
                                .customFont(.bold, 40)
                                .foregroundColor(Color.pink)
                                .multilineTextAlignment(.center)
                                .tint(Color.pink)
                                .keyboardType(.numberPad)
                                .filterNumericCharacters(binding: $phoneNumber)
                        )
                }.padding(.top)
            }
            Spacer()
        }
        .padding(.top)
    }
}

struct PhoneNumberInputView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberInputView(showCountryList: .constant(false), phoneNumber: .constant("955555666"), country: .constant(Country(isoCode: "US")), title: "Title", label: "Label")
    }
}
