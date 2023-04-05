//
//  LangaugeDropdown.swift
//  ios-sdk
//

import SwiftUI

struct LangaugeDropdown: View {
    @State var isExpanded = false
    @Binding var selectedValue: String
    
    var options = [
        NSLocalizedString("english", comment: "english"),
        NSLocalizedString("german", comment: "german"),
        NSLocalizedString("french", comment: "french"),
    ]
    
    var body: some View {
        VStack {
            DisclosureGroup(selectedValue, isExpanded: self.$isExpanded) {
                VStack {
                    ForEach(options.indices, id: \.self) { index in
                        Button(action: {}, label: {
                            Text(options[index])
                                .padding(.bottom)
                                .font(.system(size: 22))
                        })
                        .onTapGesture {
                            self.selectedValue = options[index]
                            withAnimation {
                                self.isExpanded.toggle()
                            }
                        }
                        .foregroundColor(Color("textGray"))
                        .accessibility(identifier: "lang\(index)")
                    }
                }
                .padding(.top, 10)
            }
            .font(.system(size: 22))
            .accessibility(identifier: "langDropdown")
        }
    }
}
