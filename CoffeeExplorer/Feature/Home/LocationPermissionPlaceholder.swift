//
//  LocationPermissionPlaceholder.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import SwiftUI

struct LocationPermissionPlaceholder: View {
    // MARK: - Properties
    @StateObject var locationManager = LocationManager()
    
    // MARK: - View
    var body: some View {
        
        VStack(alignment: .center, spacing: 16.0)  {
            
            Spacer()
            
            Image("unknown-location")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            VStack(alignment: .center, spacing: 4) {
                
                Text("KEY_VENUE_LIST_PLACEHOLDER_TITLE".localized)
                    .font(.poppins(size: 28))
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .scaledToFit()
                
                Text("KEY_VENUE_LIST_PLACEHOLDER_DESCRIPTION".localized)
                    .font(.poppins(size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.gray)
                    .font(.headline)
                
                VStack(spacing: 16) {
                    
                    Button(action: {
                        if let status = locationManager.status, status == .notDetermined {
                            locationManager.requestForAuthorization()
                        } else {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                        }
                    }) {
                        Text("KEY_ONBOARD_ALLOW".localized)
                            .font(.poppins(size: 18))
                            .fontWeight(.bold)
                    }
                    .padding(.top, 40)
                    .buttonStyle(PrimaryButtonStyle(height: 48, cornerRadius: 48/2))
                    
                }
            }
            .padding(.horizontal, 48)
            
            Spacer()
        }
    }
}
