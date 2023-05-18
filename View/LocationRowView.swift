//
//  LocationRowView.swift
//  A2M1
//
//  Created by Mohit Bishnoi on 12/5/2022.
//

import SwiftUI

struct LocationRowView: View {
    @ObservedObject var location: Location
    @State var image = Image(systemName: "photo").resizable()
    var body: some View {
        HStack {
            image.aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 25, alignment: .center)
            Text(location.locationname)
        }.task {
            image = await location.getImage()
        }
    }
}

