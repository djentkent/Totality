//
//  TotalityApp.swift
//  Totality
//
//  Created by Kent Wilson on 11/21/25.
//

import SwiftUI
import SwiftData

@main
struct TotalityApp: App {
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .modelContainer(for: ModelRegistry.models)
        }
    }
}

#Preview("App Root") {
    RootTabView()
        .modelContainer(for: ModelRegistry.models)
}
