//
//  LoadingOverlay.swift
//  Mex
//
//  Created by islam metwally on 02.05.24.
//

import SwiftUI

struct LoadingOverlay: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.5) // Semi-transparent background
                .edgesIgnoringSafeArea(.all)

            ProgressView() // Loading indicator
                .progressViewStyle(CircularProgressViewStyle())
        }
    }
}
