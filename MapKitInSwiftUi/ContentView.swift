//
//  ContentView.swift
//  MapKitInSwiftUi
//
//  Created by Neosoft on 20/11/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        VStack{
            Button("Subscribe") {
                            viewModel.fetchData()
                        }
            if let weather = viewModel.weather{
                Text("Current Temprature : \(weather.currentTemprature)")
                ForEach(weather.forecast , id: \.self){
                    temp in
                    Text("ForeCasted: \(temp)")
                }
            }else{
                Text("Loding data")
            }
            
            Button("Cancel Subscription") {
                            viewModel.cancelSubscription()
                        }
        }
    }
}


// Preview the ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
