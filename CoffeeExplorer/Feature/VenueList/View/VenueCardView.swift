//
//  VenueListCardView.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct VenueCardView: View {
    
    // MARK: - Properties
    let venue: Venue
    
    // MARK: - View
    var body: some View {
        
        HStack(spacing: 16) {
            
            WebImage(url: venue.thumbnail)
                .placeholder(
                    Image(systemName: "photo")
                )
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 64, height: 64)
                .cornerRadius(64/2)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(venue.name)
                    .font(.poppins(size: 16.0))
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    
                HStack {
                    
                    Text(venue.distance)
                        .font(.poppins(size: 14.0))
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    Divider()
                        .frame(maxWidth: 2)
                    
                    HStack(spacing: 4) {
                        
                        Text("4.9")
                            .font(.poppins(size: 14.0))
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        
                        Image(systemName: "star.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12, height: 12)
                            .foregroundColor(.black)
                    }
                    
                }
                .frame(height: 20)
                
                Text(venue.category)
                    .font(.poppins(size: 14.0))
                    .lineLimit(1)
                
                HStack {
                    
                    Image(systemName: "location")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12, height: 12)
                    
                    Text(venue.address)
                        .font(.poppins(size: 12.0))
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }
            }
            
            Spacer()
        }
    }
}


struct VenueCardView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        VenueCardView(venue: PreviewData.shared.venueList.first!)
    }
}


class PreviewData {
    
    static let shared = PreviewData()
    
    let venueList: [Venue]
    
    private init() {
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let response = try! decoder.decode(Server.VenueListResponse.self, from: data)
        venueList = response.response.groups!.first!.items!.map { Venue(with: $0.venue) }
    }
}
