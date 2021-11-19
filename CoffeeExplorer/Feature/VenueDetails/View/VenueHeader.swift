//
//  VenueHeader.swift
//  CoffeeExplorer
//
//  Created by ar on 19/11/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct VenueImageHeaderView: View {
    let imageURL: URL?
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                if geometry.frame(in: .global).minY <= 0 {
                    WebImage(url: imageURL)
                        .placeholder(
                            Image(systemName: "coffee-default")
                        )
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(y: geometry.frame(in: .global).minY/9)
                    .clipped()
                } else {
                    WebImage(url: imageURL)
                        .placeholder(
                            Image(systemName: "coffee-default")
                        )
                    .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                        .clipped()
                        .offset(y: -geometry.frame(in: .global).minY)
                }
            }
        }
    }
}

struct VenueImageHeaderView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        VenueImageHeaderView(imageURL: nil)
    }
}


