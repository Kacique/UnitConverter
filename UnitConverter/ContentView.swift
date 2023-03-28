//
//  ContentView.swift
//  UnitConverter
//
//  Created by William on 3/22/23.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var convertFrom = "Fahrenheit"
    @State private var convertTo = "Fahrenheit"
    @State private var temperature = 0.0
    @State private var symbol = "°F"
    @FocusState private var numIsFocused: Bool
    
    let units = ["Fahrenheit", "Celsius", "Kelvin"]
    
    
    var result: Double{
        if convertFrom == "Fahrenheit" && convertTo == "Celsius"{
            return (temperature - 32.0) * 5.0 / 9.0
        } else if convertFrom == "Fahrenheit" && convertTo == "Kelvin"{
            return (temperature - 32.0) * 5.0 / 9.0 + 273.15
        } else if convertFrom == "Celsius" && convertTo == "Fahrenheit"{
            return (temperature * 9/5) + 32
        } else if convertFrom == "Celsius" && convertTo == "Kelvin"{
            return temperature + 273.15
        } else if convertFrom == "Kelvin" && convertTo == "Fahrenheit"{
            return (temperature - 273.15) * 9/5 + 32
        } else if convertFrom == "Kelvin" && convertTo == "Celsius"{
            return temperature - 273.15
        }
        else {
            return temperature
        }
    }
    
    var tempSymbol: String {
        
        var tempS = symbol
        
        if convertTo == "Kelvin"{
            tempS = "K"
        } else if convertTo == "Celsius"{
           tempS = "°C"
        } else{
            tempS = "°F"
        }
        
        return tempS
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    
                    Picker("From: ", selection: $convertFrom){
                        Text("From: ")
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Picker("To: ", selection: $convertTo){
                        Text("To: ")
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                Section{
                    TextField("Convert", value: $temperature, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($numIsFocused)
                } header: {
                    Text("Enter Temperature: ")
                }
                
                Section{
                    Text("\(String(format: "%.2f", result)) \(tempSymbol)"
                )
                    
                } header: {
                    Text("Temperature is:")
                }
            }
            
            .navigationTitle("Temp Conversion")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        numIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
