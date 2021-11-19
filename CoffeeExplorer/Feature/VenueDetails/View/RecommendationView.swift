//
//  RecommendationView.swift
//  CoffeeExplorer
//
//  Created by ar on 19/11/2021.
//

import SwiftUI

struct RecommendationView: View {
    
    var recommendations: [VenueModel.Recommendation] = []
    var body: some View {
        
        LazyVStack(alignment: .leading) {
            
            Text("KEY_VENUE_RECOMMENDATIONS".localized)
                .font(.poppins(size: 22))
                .fontWeight(.bold)
            
            Divider()
            
            ForEach(recommendations, id: \.id) { recommendation in
                
                VStack(alignment: .leading) {
                    
                    Text(recommendation.user.fullName)
                        .font(.poppins(size: 14))
                        .fontWeight(.bold)
                    
                    Text(recommendation.date)
                        .font(.poppins(size: 12))
                        .foregroundColor(.gray)
                    
                    Text(recommendation.comment)
                        .font(.poppins(size: 12))
                        .foregroundColor(.gray)
                        .padding(.top, 2)
                    
                }
                
                Divider()
            }
        }
    }
}
