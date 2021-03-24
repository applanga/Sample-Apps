//
//  UnitsRadio.swift
//  ios-sdk
//

import SwiftUI

struct UnitsRadio: View {
    
    @Binding var units: String
    
    var body: some View {
        
        VStack {

            Button(action: {}, label: {
                HStack {
                    Image(systemName: self.units == "Metric" ? "largecircle.fill.circle" : "circle")
                        .resizable()
                        .frame(width: 21, height: 21)

                    Text(NSLocalizedString("metric", comment: ""))
                        .font(.system(size: 22))
                        .foregroundColor(Color("textGray"))
                    
                    Spacer()
                }
            }).onTapGesture {
                self.units = "Metric"
            }
            .padding(.bottom, 3)

            Button(action: {}, label: {
                HStack {
                    Image(systemName: self.units == "Imperial" ? "largecircle.fill.circle" : "circle")
                        .resizable()
                        .frame(width: 21, height: 21)

                    Text(NSLocalizedString("imperial", comment: ""))
                        .font(.system(size: 22))
                        .foregroundColor(Color("textGray"))
                    
                    Spacer()
                }
            }).onTapGesture {
                self.units = "Imperial"
            }

        }
        .padding(.top, 10)
        .padding(.bottom, 10)
    }
}

//struct UnitsRadio_Previews: PreviewProvider {
//    static var previews: some View {
//        UnitsRadio()
//    }
//}
