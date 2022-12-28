//
//  ContentView.swift
//  Steps
//
//  Created by Brittany Rima on 12/6/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: StepsViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                MountainView(viewModel: viewModel)
                    .edgesIgnoringSafeArea(.all)

              
            }
            .navigationTitle("🏃 Steps")
            .onAppear {
                viewModel.requestAuthorization { success in
                    if success {
                        viewModel.calculateSteps { statsCollection in
                            if let statsCollection = statsCollection {
                                viewModel.updateUIFromStats(statsCollection)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: StepsViewModel())
    }
}
