//
//  DisplayedDaysDropdown.swift
//  ios-sdk
//

import SwiftUI

struct DisplayedDaysDropdown: View {
    
    @State var isExpanded = false
    @Binding var selectedValue: Int
    
    var options = [5, 4, 3, 2, 1]
    
    var body: some View {
        VStack {
            DisclosureGroup("\(self.selectedValue)", isExpanded: self.$isExpanded) {
                VStack {
                    ForEach(options, id: \.self) { value in
                        Text("\(value)")
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
        .onAppear {
            self.selectedValue = AppSettings().getDisplayedDays()!
        }
    }
}
