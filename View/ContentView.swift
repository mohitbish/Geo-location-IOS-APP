//
//  ContentView.swift
//  A2M1
//
//  Created by Mohit Bishnoi on 12/5/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var coords: CoordViewModel
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.name, ascending: true)],
        animation: .default)
    private var locations: FetchedResults<Location>
    var body: some View {
        NavigationView {
            List {
                ForEach(locations) { location in
                        NavigationLink {
                            LocationView(location: location,  coords: coords)
                                    .navigationBarItems(trailing: EditButton())
                        }label: {
                            LocationRowView(location: location)
                        }
                }
                .onDelete(perform: deleteLocations)
            }
            .navigationTitle("Favorite Places")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addLocation) {
                        Label("Add Location", systemImage: "plus")
                    }
                }
            }
            Text("Select an location")
        }
    }

    private func addLocation() {
        withAnimation {
            let newLocation = Location(context: viewContext)
            newLocation.name = "New Location"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteLocations(offsets: IndexSet) {
        withAnimation {
            offsets.map { locations[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let locationFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

