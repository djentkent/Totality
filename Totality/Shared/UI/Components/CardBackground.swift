//
//  CardBackground.swift
//  Totality
//
//  Created by Kent Wilson on 11/24/25.
//

import SwiftUI

struct CardBackground: View {
    var cornerRadius: CGFloat = 20

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(Color(
                red: 34/255,
                green: 34/255,
                blue: 34/255
            ))
    }
}

struct CardBackground_Previews: PreviewProvider {
    static var previews: some View {
        CardBackground()
            .frame(width: 300, height: 160)
            .padding()
            .background(Color(
                red: 23/255,
                green: 23/255,
                blue: 23/255
            ))
    }
}
