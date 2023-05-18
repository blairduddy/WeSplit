//
//  ContentView.swift
//  WeSplit
//
//  Created by Blair Duddy on 2023-05-08.
//

import SwiftUI

struct ContentView: View {
    
    @FocusState private var amountIsFocused: Bool
    @State private var chequeAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 15
    
    let tipPercentages = [0, 10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = chequeAmount / 100 * tipSelection
        let grandTotal = tipValue + chequeAmount
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalCheque: Double {
        let tipTotal = chequeAmount / 100 * Double(tipPercentage)
        let totalCheque = chequeAmount + tipTotal
        return totalCheque
    }
    
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", value: $chequeAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Enter Total:")
                }
                
                Section {
                    Text(totalCheque, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total with Tip:")
                }
                .foregroundColor(tipPercentage == 0 ? .red : .primary)
                
                Section {
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount per person:")
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
