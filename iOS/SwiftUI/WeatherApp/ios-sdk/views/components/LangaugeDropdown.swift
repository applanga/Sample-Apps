//
//  LangaugeDropdown.swift
//  ios-sdk
//

import SwiftUI

struct LangaugeDropdown: View {
    @State var isExpanded = false
    @Binding var selectedValue: AppSettings.Language
    
    var body: some View {
        VStack {
            DisclosureGroup(LocalizedStringKey(localizationkeyForLanguage(selectedValue)), isExpanded: self.$isExpanded) {
                VStack {
                    ForEach(AppSettings.Language.allCases, id: \.self) { language in
                        Button(action: {}, label: {
                            Text(LocalizedStringKey(localizationkeyForLanguage(language)))
                                .padding(.bottom)
                                .font(.system(size: 22))
                        })
                        .onTapGesture {
                            self.selectedValue = language
                            withAnimation {
                                self.isExpanded.toggle()
                            }
                        }
                        .foregroundColor(Color("textGray"))
                        .accessibility(identifier: "lang\(language)")
                    }
                }
                .padding(.top, 10)
            }
            .font(.system(size: 22))
            .accessibility(identifier: "langDropdown")
        }
    }
}
