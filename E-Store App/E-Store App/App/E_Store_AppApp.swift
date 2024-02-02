//
//  E_Store_AppApp.swift
//  E-Store App
//
//  Created by rajan kumar on 26/01/24.
//

import SwiftUI
import SwiftData

@main
struct E_Store_App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ShoppingDataModel.self,cartItem.self,Favourite.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
 
    
   
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(sharedModelContainer)
    }
    
}
