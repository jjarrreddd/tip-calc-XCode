//
//  ContentView.swift
//  tip-calc
//
//  This is my iOS app: EZ Gratuity, you input the subtotal of the bill, 
//  enter the tax, and select a tip option! Selecting either between 15%,
//  18%, and 20%, users can also input custom tips of any percentage!
//  EZ Gratuity is an app that helps with calculating the tip and simply makes
//  matters easier!
//
//
//  Created by Jarred Siriban on 5/6/24.
//  CWID: 886875178

import SwiftUI

struct ContentView: View {
    
    @State private var subTotal = ""
    @State private var taxAmt = ""
    @State private var customTipStr = ""
    @State private var percentage: Double?
        
    let percentages = [15.0, 18.0, 20.0]
    
    var finalTotal: Double {
        let subtotal = Double(subTotal) ?? 0
        let custom = Double(customTipStr) ?? 0
        let tax = Double(taxAmt) ?? 0
        
        let tipOption = percentage ?? custom
        let tip = subtotal * (tipOption / 100)
        return subtotal + tip + tax
    }
    
    var tipAmt: Double {
        let subtotal = Double(subTotal) ?? 0
        let custom = Double(customTipStr) ?? 0
        let tipOption = percentage ?? custom
        
        return subtotal * (tipOption / 100)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Text("Welcome to EZ Gratuity!")
                        .font(.system(.title, design: .monospaced))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding()
                    
                    Section(header: Text("Enter subtotal below:")
                        .font(.system(.body, design: .serif))) {
                        TextField("$", text: $subTotal)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Section(header: Text("Enter tax amount below:")
                            .font(.system(.body, design: .serif))) {
                            TextField("$", text: $taxAmt)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            Section(header: Text("Select a tip option below:")
                                .font(.system(.body, design: .serif))) {
                                HStack {
                                    ForEach(percentages, id: \.self) {
                                        percent in Button(action: {
                                            self.percentage = percent }) {
                                                Text("\(Int(percent))%")
                                                    .font(.system(.body, design: .serif))
                                                    .padding()
                                                    .background(self.percentage == percent ? Color.blue : Color.gray)
                                                    .foregroundColor(.white)
                                                    .cornerRadius(8)
                                            }
                                            .controlSize(.mini)
                                    }
                                    Button(action: {
                                        self.percentage = nil
                                    }) {
                                        Text("Custom")
                                            .padding()
                                            .background(self.percentage == nil ? Color.blue : Color.gray)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                }
                                
                                if percentage == nil {
                                    TextField("%", text: $customTipStr)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.decimalPad)
                                        .padding()
                                }
                            }
                        }
                    }
                    
                    Text("Tip Amount: $\(tipAmt, specifier: "%.2f")")
                        .font(.system(.subheadline, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    Text("Grand Total: $\(finalTotal, specifier: "%.2f")")
                        .font(.system(.title, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
