/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

extension Room {
    struct SlidersView {
        init(room: Room) {
            self.room = room
        }
        
        @ObservedObject private var room: Room
    }
}

//creating the sliders
private struct Slider {
    private static let defaultSymbolName = "lightbulb.fill"
    
    init(
        _ value: Binding<Lightbulb.NormalizedValue>,
        minimumLabelColor: Color? = nil,
        lineColor: (Lightbulb.NormalizedValue) -> Color,
        maximumLabelColor: Color? = nil
    ) {
        
        self.value = value
        self.minimumLabelColor = minimumLabelColor ?? lineColor(0)
        self.lineColor = lineColor(value.wrappedValue)
        self.maximumLabelColor = maximumLabelColor ?? lineColor(1)
}

private let value: Binding<Lightbulb.NormalizedValue>
private let minimumLabelColor: Color
private let lineColor: Color
private let maximumLabelColor: Color

}

extension Room.SlidersView: View {
    var body: some View {
        VStack {
            Slider($room.saturation) {
                .init(hue: room.hue, saturation: $0, brightness: 1)
            }
            
        }
        .navigationTitle(room.name)
    }
}

extension Slider: View {
    var body: some View {
        SwiftUI.Slider(value: value,
                       minimumValueLabel: Image(systemName: Slider.defaultSymbolName)
                        .foregroundColor(minimumLabelColor),
                       maximumValueLabel: Image(systemName: Slider.defaultSymbolName)
                        .foregroundColor(maximumLabelColor),
                       label: EmptyView.init)
            .accentColor(lineColor)
    }
}

struct SlidersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Room.SlidersView(room: .init(name: "Room"))
            
        }
    }
}
