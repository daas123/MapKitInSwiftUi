//
//  ContentViewmodel.swift
//  MapKitInSwiftUi
//
//  Created by Neosoft on 21/11/23.
//
// Model for weather data

import Foundation
import Combine

struct Weather{
    var currentTemprature : Double
    var forecast : [Double]
}

class ContentViewModel:ObservableObject{
    @Published var weather : Weather?
    private var cancellables : Set<AnyCancellable> = []
    init(){
        fetchData()
    }
    
    func fetchData(){
        let currentTemprature = Just(23.5)
            .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        
        
        let forecastPublisher = Just([24.0,25.5,23.0,22.5])
            .delay(for: .seconds(3), scheduler: DispatchQueue.main)
        
        
        //use of combine latest
        Publishers.CombineLatest(currentTemprature,forecastPublisher)
            .sink { [weak self] currentTemp , forecasted in
                self?.weather = Weather(currentTemprature: currentTemp, forecast: forecasted)
            }
            .store(in: &cancellables)

    }
    
    func cancelSubscription() {
            cancellables.forEach { cancellable in
                cancellable.cancel()
            }
            cancellables.removeAll()
        }
}
