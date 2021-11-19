//
//  VenueDetailsView.swift
//  CoffeeExplorer
//
//  Created by ar on 19/11/2021.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI

struct VenueDetailsView: View {
    
    @ObservedObject private var viewModel: VenueDetailsViewModel
    
    init(venue: Venue) {
        viewModel = VenueDetailsViewModel(venue: venue)
    }
    
    var body: some View {
        LoadingView(isLoading: self.$viewModel.isLoading) {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VenueImageHeaderView(imageURL: viewModel.photoURL)
                        .frame(height: 400)
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading) {
                            
                            Text(viewModel.venueName)
                                .font(.poppins(size: 26))
                                .fontWeight(.semibold)
                            
                            Text(viewModel.venueDescription)
                                .font(.poppins(size: 12))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        SubtitleView(title: "KEY_VENUE_ADDRESS".localized, subTitle: viewModel.venueAddress)
                            .padding(.horizontal)
                        
                        Divider()
                        SubtitleView(title: "KEY_VENUE_HOURS".localized, subTitle: viewModel.venueOpenStatus)
                            .padding(.horizontal)
                        
                        Divider()
                        RecommendationView(recommendations: viewModel.recommendations)
                            .padding(.top, 8)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                }
                .onAppear(perform: {
                    viewModel.fetchVenueDetails()
                })
                .navigationTitle("")
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
}

private struct SubtitleView: View {
    
    let title: LocalizedStringKey
    let subTitle: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(title)
                .font(.poppins(size: 12))
                .foregroundColor(.gray)
            
            Text(subTitle)
                .font(.poppins(size: 12))
                .foregroundColor(.gray)
        }
    }
}
