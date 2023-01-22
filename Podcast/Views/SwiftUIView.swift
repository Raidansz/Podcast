//
//  SwiftUIView.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 22..
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        
        CustomRefreshView(showsIndicator: false) {
            // MARK: Sample VIEW
            VStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.red.gradient)
                    .frame(height: 100)
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.blue.gradient)
                    .frame(height: 100)
            }
            .padding(15)
        } onRefresh: {
            // MARK: Your Action
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
