//
//  LogoTextView.swift
//  Mex
//
//  Created by islam metwally on 02.05.24.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Text("MeX")
            .font(.system(size: DesignDirectory.FontSizes.logoLargeFontSize))
            .minimumScaleFactor(0.5)
            .foregroundColor(.clear)
            .overlay {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.celticBlue,
                        Color.dark
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .mask {
                    Text("MeX")
                        .font(.system(size: DesignDirectory.FontSizes.logoLargeFontSize))
                        .minimumScaleFactor(0.5)
                        .foregroundColor(.white)
                }
            }
    }
}
