//
//  NextLaunches.swift
//  NextLaunches
//
//  Created by Riccardo Persello on 19/12/2020.
//

import WidgetKit
import SwiftUI
import SDWebImageSwiftUI

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), launches: [FakeData.shared.crewDragon!])
  }
  
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), launches: [FakeData.shared.crewDragon!])
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []
    
    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for hourOffset in 0 ..< 5 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = SimpleEntry(date: entryDate, launches: [])
      entries.append(entry)
    }
    
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let launches: [Launch]
}

struct NextLaunchesEntryView: View {
  var entry: Provider.Entry
  @Environment(\.widgetFamily) var family
  
  @ViewBuilder
  var body: some View {
//    switch family {
//      case .systemSmall:
        NextLaunchesSmallWidget(launches: entry.launches)
//      case .systemMedium:
//        EmptyView()
//      case .systemLarge:
//        EmptyView()
//      @unknown default:
//        EmptyView()
//    }
  }
}

struct NextLaunchesSmallWidget: View {
  var launches: [Launch]
  
  var body: some View {
    let nextLaunch = launches.first!
    
    VStack(alignment: .leading) {
      Text("Next".uppercased())
        .font(.caption)
        .fontWeight(.bold)
        .foregroundColor(.gray)
      
      Text(nextLaunch.name)
        .font(.footnote)
        .lineLimit(1)
      
      HStack(alignment: .top) {
        WebImage(url: nextLaunch.links?.patch?.large)
          .resizable()
          .frame(width: 48, height: 48)
        VStack(alignment: .leading) {
          // Show crew or launchpad
          if let crew = nextLaunch.getCrew() {
            // There is crew
            if crew.count > 3 {
              ForEach(0..<3) { index in
                Text(crew[index].)
              }
            } else if crew.count > 0 {
              Text("More than zero")
            }
          }
        }
        Spacer()
      }
  
      Spacer()
      Text(nextLaunch.dateUTC, style: .timer)
    }
    .padding(.all, 12)
  }
}

struct PlaceholderView: View {
  var body: some View {
    NextLaunchesEntryView(entry: SimpleEntry(date: Date(), launches: [FakeData.shared.crewDragon!]))
      .redacted(reason: .placeholder)
  }
}

@main
struct NextLaunches: Widget {
  let kind: String = "NextLaunches"
  
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      NextLaunchesEntryView(entry: entry)
    }
    .configurationDisplayName("Launches")
    .description("Shows recent and upcoming rocket launches.")
  }
}

struct NextLaunches_Previews: PreviewProvider {
  static var previews: some View {
    NextLaunchesEntryView(entry: SimpleEntry(date: Date(), launches: [FakeData.shared.crewDragon!]))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
    
    PlaceholderView()
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
