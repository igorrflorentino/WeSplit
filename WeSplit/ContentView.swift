//
//  ContentView.swift
//  WeSplit
//
//  Created by Igor Florentino on 06/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentageSelect: Int = 20
    
    @FocusState private var amountIsFocused: Bool
    
    var tipPercentageMath: Double {
        Double(tipPercentageSelect)/100
    }
    
    var tipValue: Double{
        checkAmount*(tipPercentageMath)
    }
    
    var grandTotal: Double {
        checkAmount+tipValue
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople+2)
        let amountPerPerson = grandTotal/peopleCount
        return amountPerPerson
    }
    
    
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentageSelect) {
                        ForEach(0..<101) {
                            Text($0,format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Amount per person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Total amount for the check"){
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done"){
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
