//
//  FeedbackView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-03-31.
//

import SwiftUI

struct FeedbackView: View {

    @State private var text = ""

    var body: some View {
        VStack {
            Text("Send Feedback").font(.title)

            TextEditor(text: $text)
                .border(Color.gray)

            Button("Submit") {
                print("Feedback:", text)
                text = ""
            }
        }
        .padding()
    }
}
