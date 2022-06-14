//
//  ContentView.swift
//  WeSplit
//
//  Created by Damian on 08/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [5, 10, 15, 20, 0]
    
    var totalPerPerson: Double {
        let numOfPeople = Double(numberOfPeople)
        let tipSelected = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipSelected
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / numOfPeople
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("What is the amount?"){
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    }
                
                Section("How many people?") {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2...20, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                Section("Tip Procentages"){
                    Picker("How much tip ?", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
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
