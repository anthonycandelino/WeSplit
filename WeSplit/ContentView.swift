/*
 ContentView.swift
 WeSplit Check Splitting App
 Created by Anthony Candelino on 2024-06-08.
*/

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0 // index of array of number of people
    @State private var tipPercentage = 15
    @FocusState private var amountIsFocused: Bool
    
    var totalCheckAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2) // +2 because array starts at 2 ppl
        return totalCheckAmount / peopleCount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Bill Amount") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<11) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0)%")
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section("Total check amount:") {
                    Text(totalCheckAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).foregroundStyle(tipPercentage == 0 ? .red : .black)
                }
                
                Section("Amount per person:") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit Check ")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
