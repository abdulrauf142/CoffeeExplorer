//
//  VenueListView.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct VenueListView: View {
    // MARK: - Properties
    @StateObject private var viewModel = VenueListViewModel()
    let coordinate: Coordinate
    // MARK: - View
    var body: some View {
        LoadingView(isLoading: self.$viewModel.isLoading) {
            NavigationView {
                List {
                    ForEach(viewModel.venues, id: \.id) { venue in
                        NavigationLink(destination: VenueDetailsView(venue: venue)) {
                            VenueCardView(venue: venue)
                        }
                        .padding()
                        .modifier(PrimaryCardViewStyle(radius: 24))
                    }
                    
                    if viewModel.hasMoreRows {
                        
                        HStack(spacing: 16) {
                            ProgressView()
                            Text("KEY_VENUE_LIST_Loading")
                                .font(.poppins(size: 18))
                            Spacer()
                        }
                        .padding()
                        .onAppear {
                           viewModel.fetchVenue(coordinate: coordinate)
                        }
                        .modifier(PrimaryCardViewStyle(radius: 8))
                        
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle(Text("KEY_VENUE_LIST_TITLE"), displayMode: .large)
                .ignoresSafeArea()
                .alert(isPresented: $viewModel.showError) {
                    print(viewModel.errorMessage)
                    return Alert(title: Text("KEY_ERROR".localized), message: Text(viewModel.errorMessage.localized))
                }
                .onAppear {
                    if viewModel.venues.isEmpty {
                        viewModel.fetchVenue(coordinate: coordinate)
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct VenueListView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        VenueListView(coordinate: Coordinate(lat: 1, lng: 2))
    }
}
