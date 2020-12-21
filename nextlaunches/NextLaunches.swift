//
//  NextLaunches.swift
//  NextLaunches
//
//  Created by Riccardo Persello on 19/12/2020.
//

import WidgetKit
import SwiftUI
import SDWebImageSwiftUI
import Alamofire
import AlamofireImage

struct Provider: TimelineProvider {
  /*
   Refresh: usually 1 hour,
   1 minute in the half hour before a launch,
   5 minutes in the two hours before and after a launch
   15 minutes in the 24 hours after a launch, or until a background image is found
   
   Relevance: TBD
   
   Interesting launch:
   If the past launch is more than a day and a half away, the interesting launch is the next one.
   If two launches are less than 48 hours apart, the interesting launch will be the past one for 2/5 of the time interval, then the next one will take its place.
   Otherwise, the interesting launch will be active for a day and a half.
   */
  
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), interestingLaunch: SampleData.shared.launch, backgroundImage: nil, missionPatch: nil)
  }
  
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), interestingLaunch: SampleData.shared.launch, backgroundImage: SampleData.shared.bg, missionPatch: SampleData.shared.patch)
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = [SimpleEntry(date: Date(), interestingLaunch: SampleData.shared.launch, backgroundImage: SampleData.shared.bg, missionPatch: SampleData.shared.patch)]
    
    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for hourOffset in 0 ..< 5 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = SimpleEntry(date: entryDate, interestingLaunch: SampleData.shared.launch, backgroundImage: SampleData.shared.bg, missionPatch: SampleData.shared.patch)
      entries.append(entry)
    }
    
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let interestingLaunch: Launch?
  let backgroundImage: UIImage?
  let missionPatch: UIImage?
}

struct NextLaunchesEntryView: View {
  var entry: Provider.Entry
  @Environment(\.widgetFamily) var family
  
  @ViewBuilder
  var body: some View {
    //    switch family {
    //      case .systemSmall:
    NextLaunchesSmallWidget(entry: entry)
    //      case .systemMedium:
    //        EmptyView()
    //      case .systemLarge:
    //        EmptyView()
    //      @unknown default:
    //        EmptyView()
    //    }
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
    .supportedFamilies([.systemSmall])
  }
}

class SampleData {
  var bg: UIImage?
  var patch: UIImage?
  let launch = FakeData.shared.crewDragon!
  
  static var shared = SampleData()
  
  init() {
    launch.getPatch { image in
      self.patch = image
    }
    
    launch.getImage(atIndex: 0) { image in
      self.bg = image
    }
  }
}

struct NextLaunches_Previews: PreviewProvider {
  static var previews: some View {
    
    
    Group {
      NextLaunchesEntryView(entry: SimpleEntry(date: Date(), interestingLaunch: SampleData.shared.launch, backgroundImage: SampleData.shared.bg, missionPatch: SampleData.shared.patch))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
      
      NextLaunchesEntryView(entry: SimpleEntry(date: Date(), interestingLaunch: SampleData.shared.launch, backgroundImage: SampleData.shared.bg, missionPatch: SampleData.shared.patch))        .previewContext(WidgetPreviewContext(family: .systemSmall))
        .colorScheme(.dark)
      
      NextLaunchesEntryView(entry: SimpleEntry(date: Date(), interestingLaunch: SampleData.shared.launch, backgroundImage: nil, missionPatch: SampleData.shared.patch))        .previewContext(WidgetPreviewContext(family: .systemSmall))
      
      NextLaunchesEntryView(entry: SimpleEntry(date: Date(), interestingLaunch: SampleData.shared.launch, backgroundImage: SampleData.shared.bg, missionPatch: SampleData.shared.patch))        .previewContext(WidgetPreviewContext(family: .systemSmall))
        .redacted(reason: .placeholder)
    }
  }
}

// MARK: - Subviews
struct NextLaunchesSmallWidget: View {
  var entry: Provider.Entry
  
  var body: some View {
    
    // Show the "before and during" widget for up to an hour after the launch.
    // Countdown and normal date display are automatically managed in the `ClockCountdownView`.
    if let interestingLaunch = entry.interestingLaunch {
      if Date() < interestingLaunch.dateUTC + 3600 {
        SmallBeforeDuringLaunchContent(entry: entry)
      } else {
        // Show the "after" widget otherwise
        SmallAfterLaunchContent(entry: entry)
      }
    } else {
      // No launches
      Text("No available launches")
        .fontWeight(.semibold)
        .font(.callout)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGray6))
    }
  }
}

struct SmallAfterLaunchContent: View {
  var entry: Provider.Entry
  
  var body: some View {
    if let launch = entry.interestingLaunch {
      GeometryReader { gr in
        ZStack(alignment: .top) {
          if let i = entry.backgroundImage {
            // With backgound
            
            Image(uiImage: i)
              .resizable()
              .scaledToFill()
              .frame(width: gr.size.width, height: gr.size.height)
            
            Color(.black)
              .opacity(0.4)
            
            VStack(alignment: .leading) {
              HStack {
                Text("Last launch".uppercased())
                  .font(.caption)
                  .fontWeight(.black)
                  .foregroundColor(.white)
                  .opacity(0.6)
                
                Spacer()
              }
              
              Text(launch.name)
                .font(.footnote)
                .lineLimit(1)
                .foregroundColor(.white)
              
              Spacer()
              
              if let s = launch.success {
                Text(s ? "\(Image(systemName: "checkmark.seal.fill")) Success" : "\(Image(systemName: "xmark.seal.fill")) Failure")
                  .fontWeight(.semibold)
                  .foregroundColor(s ? .green : .red)
              }
              
              Spacer()
              
              PatchAndDetailsView(launch: launch, patch: entry.missionPatch)
                .foregroundColor(.white)
            }
            .padding(.all, 12)
          } else {
            // Without background
            
            Color(UIColor.systemGray6)
            
            VStack(alignment: .leading) {
              HStack {
                Text("Last launch".uppercased())
                  .font(.caption)
                  .fontWeight(.black)
                  .opacity(0.6)
                
                Spacer()
              }
              
              Text(launch.name)
                .font(.footnote)
                .lineLimit(1)
              
              Spacer()
              
              if let s = launch.success {
                Text(s ? "\(Image(systemName: "checkmark.seal.fill")) Success" : "\(Image(systemName: "xmark.seal.fill")) Failure")
                  .fontWeight(.semibold)
                  .foregroundColor(s ? .green : .red)
              }
              
              Spacer()
              
              PatchAndDetailsView(launch: launch, patch: entry.missionPatch)
            }
            .padding(.all, 12)
          }
        }
      }
    }
  }
}

struct SmallBeforeDuringLaunchContent: View {
  var entry: Provider.Entry
  
  var body: some View {
    if let launch = entry.interestingLaunch {
      VStack(alignment: .leading) {
        Text("Next".uppercased())
          .font(.caption)
          .fontWeight(.black)
          .foregroundColor(.gray)
        
        Text(launch.name)
          .font(.footnote)
          .lineLimit(1)
        
        Spacer()
        
        PatchAndDetailsView(launch: launch, patch: entry.missionPatch)
        
        Spacer()
        
        ClockCountdownView(launchDate: launch.dateUTC)
      }
      .padding(.all, 12)
      .background(Color(UIColor.systemGray6))
    }
  }
}

struct PatchAndDetailsView: View {
  var launch: Launch
  var patch: UIImage?
  
  var body: some View {
    HStack(alignment: .center) {
      if let p = patch {
        Image(uiImage: p)
          .resizable()
          .frame(width: 52, height: 52)
      } else {
        Circle()
          .foregroundColor(Color(UIColor.systemGray5))
          .redacted(reason: .placeholder)
          .frame(width: 52, height: 52)
      }
      
      VStack(alignment: .leading) {
        // Show crew or launchpad
        if let crew = launch.getCrew() {
          if crew.count > 3 {
            // Show two names and additional members
            ForEach(0..<2) { index in
              Text(crew[index].name.components(separatedBy: " ").last ?? "")
                .font(.system(size: 13, weight: .semibold, design: .monospaced))
                .lineLimit(1)
            }
            
            Text("+\(crew.count - 2)")
              .font(.system(size: 13, weight: .regular, design: .monospaced))
              .lineLimit(1)
              .foregroundColor(.gray)
            
          } else if crew.count > 0 {
            // Show all names
            ForEach(crew) { astronaut in
              Text(astronaut.name.components(separatedBy: " ").last ?? "")
                .font(.system(size: 13, weight: .semibold, design: .monospaced))
                .lineLimit(1)
            }
          }
        } else {
          // No crew
          VStack {
            Text(launch.getLaunchpad()?.name ?? "")
              .font(.system(size: 13, weight: .semibold, design: .monospaced))
              .lineLimit(1)
            Text(launch.getLaunchpad()?.locality ?? "")
              .font(.system(size: 13, weight: .regular, design: .monospaced))
              .lineLimit(1)
              .foregroundColor(.gray)
          }
        }
      }
      Spacer()
    }
  }
}

struct ClockCountdownView: View {
  var launchDate: Date
  
  var body: some View {
    if(launchDate > Date() - 48*3600 && launchDate < Date() + 3600) {
      // Show countdown two days before and an hour after
      HStack(alignment: .lastTextBaseline) {
        Text("T\(Date() < launchDate ? "-" : "+")")
          .font(.system(size: 11, weight: .semibold, design: .rounded))
          .foregroundColor(.gray)
          .padding(.trailing, -8)
        
        Text(launchDate, style: .timer)
          .font(.system(size: 18, weight: .semibold, design: .rounded))
      }
    } else {
      Text(launchDate, style: .date)
        .font(.system(size: 18, weight: .semibold, design: .rounded))
        .minimumScaleFactor(0.3)
    }
  }
}
