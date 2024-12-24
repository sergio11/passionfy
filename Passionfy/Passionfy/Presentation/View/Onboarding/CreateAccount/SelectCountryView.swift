//
//  SelectCountryView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct SelectCountryView: View {
    
    @Binding var countryChosen: Country
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                TopBarView(backButtonAction: { dismiss() },
                           title: "Select Country",
                           backButtomIcon: "xmark")
                CountryList(countryChosen: $countryChosen)
            }
            .padding(.top)
        }.background(AnimatedRadialGradientView())
    }
}

private struct CountryList: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var countryChosen: Country
    var countries: [Country] = Country.allCountries
    
    var body: some View {
        VStack {
            ZStack {
                List {
                    Section {
                        ForEach(countries, id: \.isoCode) { country in
                            HStack {
                                Text("\(country.flag(country: country.isoCode)) \(country.localizedName) (+\(country.phoneCode))")
                                    .customFont(.regular, 12)
                                Spacer()
                                if country.isoCode == countryChosen.isoCode {
                                    Image(systemName: "checkmark.circle")
                                }
                            }
                            .onTapGesture {
                                countryChosen = country
                                dismiss()
                            }
                        }
                    } header: {
                        Text("Suggested")
                            .customFont(.bold, 12)
                            .foregroundColor(Color.pink)
                            .padding(.leading, -8)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
            }
        }
        .padding(.top)
    }
}

struct SelectCountryView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCountryView(countryChosen: .constant(Country(isoCode: "US")))
    }
}
