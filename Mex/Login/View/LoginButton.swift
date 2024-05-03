//
//  LoginButton.swift
//  Mex
//
//  Created by islam metwally on 02.05.24.
//

import SwiftUI

struct LoginButton: View {
    var body: some View {
        Text(LocalizedStringKey("LoginView.CTA"))
            .frame(maxWidth: .infinity, maxHeight: 80)
            .font(Font.title)
            .bold(true)
            .foregroundColor(.white)
            .background {
                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                    .foregroundColor(.coolDark)
            }
            .padding(DesignDirectory.FontSizes.padding)
    }
}
