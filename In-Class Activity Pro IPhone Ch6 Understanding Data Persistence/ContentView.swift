//
//  ContentView.swift
//  In-Class Activity Pro IPhone Ch6 Understanding Data Persistence
//
//  Created by Student Account on 11/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var myToggle = false
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.accent)
            Text("Hello, world!")
            Toggle(isOn: $myToggle, label: {
                Text("Dark Mode")
            })
        }
        .padding()
        .onChange(of: myToggle) {
            UserDefaults.standard.set(myToggle, forKey: "darkModeEnabled")
            myToggle = UserDefaults.standard.bool(forKey: "darkModeEnabled")
        }
        .preferredColorScheme(UserDefaults.standard.bool(forKey: "darkModeEnabled") ? .light : .dark)
    }
}

#Preview {
    ContentView()
}
