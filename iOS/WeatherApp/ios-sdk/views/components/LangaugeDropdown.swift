//
//  LangaugeDropdown.swift
//  ios-sdk
//

import SwiftUI

struct LangaugeDropdown: View {
    @State var isExpanded = false
    @Binding var selectedValue: String
    
    var options = [
        "English",
        "German",
        "French"
    ]
    
    var body: some View {
        VStack {
            DisclosureGroup(selectedValue, isExpanded: self.$isExpanded) {
                VStack {
                    ForEach(options, id: \.self) { value in
                        Text(value)
                            .padding(.bottom)
                            .font(.system(size: 22))
                            .onTapGesture {
                                self.selectedValue = value
                                withAnimation {
                                    self.isExpanded.toggle()
                                }
                            }
                    }
                }
                .padding(.top, 10)
            }
            .font(.system(size: 22))
        }
    }
}

struct LangaugeDropdown_Previews: PreviewProvider {
    static var previews: some View {
        LangaugeDropdown(selectedValue: .constant("English"))
    }
}
