//
//  SettingsExchangeRateView.swift
//  dime
//
//  Created by savva on 12/21/24.
//

import Foundation
import SwiftUI

struct SettingsExchangeRateView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @AppStorage("exchangeRatesApiKey", store: UserDefaults(suiteName: "group.wtf.savva.dime"))
    var apiKey: String = ""

    var body: some View {
        VStack(spacing: 10) {
            Text("Exchange Rate API")
                .font(.system(.title3, design: .rounded).weight(.semibold))
                .foregroundColor(Color.PrimaryText)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        SettingsBackButton()
                    }
                }
                .padding(.bottom, 20)

            Text("API Key")
                .font(.system(.body, design: .rounded).weight(.medium))
                .foregroundColor(Color.SubtitleText)
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack {
                TextField("Enter API Key", text: $apiKey)
                    .font(.system(.body, design: .rounded))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            .background(Color.SettingsBackground, in: RoundedRectangle(cornerRadius: 9))

            Text("Get your API key at exchangerate-api.com")
                .font(.system(.caption, design: .rounded).weight(.medium))
                .foregroundColor(Color.SubtitleText)
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .modifier(SettingsSubviewModifier())
    }
}
