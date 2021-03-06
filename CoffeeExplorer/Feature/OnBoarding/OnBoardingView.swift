//
//  OnBoardingView.swift
//  CoffeeExplorer
//
//  Created by ar on 17/11/2021.
//

import SwiftUI

struct OnBoardingView: View {
    
    // MARK: - Properties
    @EnvironmentObject var appState: AppState
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
                
                Text("KEY_ONBOARD_LOCATION_PERMISSION_TITLE".localized)
                    .font(.poppins(size: 28))
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .scaledToFit()
                
                Text("KEY_ONBOARD_LOCATION_PERMISSION_DESCRIPTION".localized)
                    .font(.poppins(size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.gray)
                    .font(.headline)
                
                VStack(spacing: 16) {
                    
                    Button(action: {
                        locationManager.requestForAuthorization()
                    }) {
                        Text("KEY_ONBOARD_ALLOW".localized)
                            .font(.poppins(size: 18))
                            .fontWeight(.bold)
                    }
                    .padding(.top, 40)
                    .buttonStyle(PrimaryButtonStyle(height: 48, cornerRadius: 48/2))
                    
                    
                    Button(action: {
                        appState.hasSeenAppOnBoarding = true
                    }, label: {
                        Text("KEY_ONBOARD_SKIP".localized)
                            .font(.poppins(size: 18))
                            .foregroundColor(ColorPalette.primary.color)
                    })
                }
            }
            .padding(.horizontal, 48)
            
            Spacer()
        }
        .onReceive(locationManager.$status) { status in
            appState.hasSeenAppOnBoarding = status != nil && status != .notDetermined
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
