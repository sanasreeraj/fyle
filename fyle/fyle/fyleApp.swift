//
//  fyleApp.swift
//  fyle
//
//  Created by Sana Sreeraj on 18/10/24.
//

import SwiftUI

@main
struct fyleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
