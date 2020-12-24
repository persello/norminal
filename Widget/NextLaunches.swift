//
//  NorminalWidget.swift
//  NorminalWidget
//
//  Created by Riccardo Persello on 19/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI
import os
import WidgetKit

struct Provider: TimelineProvider {
  /*
   Refresh: usually 1 hour,
   1 minute in the half hour before a launch,
   5 minutes in the two hours before and after a launch
   20 minutes otherwise
   
   Relevance: TBD
   
   Interesting launch:
   If the past launch is more than a day and a half away, the interesting launch is the next one.
   If two launches are less than 48 hours apart, the interesting launch will be the past one for 2/5 of the time interval, then the next one will take its place.
   Otherwise, the interesting launch will be active for a day and a half.
   */
  
  private var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Widget provider")
  
  func minimumDateDistance(date: Date, dateList: [Date]) -> Double? {
    var min: Double?
    var am: Double?
    
    for d in dateList {
      let m = min ?? .infinity
      let difference = date.timeIntervalSince(d)
      if difference < m {
        min = abs(difference)
        am = difference
      }
    }
    
    return am
  }
  
  func generateRefreshDates() -> [Date] {
    
    // Generate two days of entries
    let numberOfMinutes = 60 * 48
    let upcomingLaunchDates = SpaceXData.shared.launches.filter({$0.upcoming && $0.dateUTC < Date() + Double(numberOfMinutes) * 60.0}).map({return $0.dateUTC})
    
    logger.debug("Generating refresh dates: \(upcomingLaunchDates.count) upcoming launch dates found in the next \(numberOfMinutes / 60) hours.")
    
    var refreshDates: [Date] = []
    
    for minute in 0..<numberOfMinutes {
      let d = Date() + (Double(minute) * 60.0)
      
      if (-30 * 60)...0 ~= minimumDateDistance(date: d, dateList: upcomingLaunchDates) ?? .infinity {
        
        // Half hour before a launch
        refreshDates.append(d)
        
      } else if (-120 * 60)...(120 * 60) ~= minimumDateDistance(date: d, dateList: upcomingLaunchDates) ?? .infinity {
        
        // Two hours before/after a launch
        if minute % 5 == 0 {
          // Append every five minutes
          refreshDates.append(d)
        }
        
      } else {
        
        // Always
        if minute % 20 == 0 {
          // Append a minute every 20
          refreshDates.append(d)
        }
      }
    }
    
    logger.debug("Successfully generated \(refreshDates.count) refresh dates.")
    
    return refreshDates
  }
  
  func generateEntry(_ date: Date) -> SimpleEntry {
    
    logger.debug("Generating entry @ \(date).")
    
    var interestingLaunch: Launch?
    
    // MARK: Get two launches
    let nextLaunch = SpaceXData.shared.getNextLaunch()
    var launchBefore: Launch?
    
    if nextLaunch == nil {
      // No next: before is last
      launchBefore = SpaceXData.shared.launches.last
    } else {
      if let nlindex = SpaceXData.shared.launches.lastIndex(of: nextLaunch!) {
        // The real before
        let lbindex = SpaceXData.shared.launches.index(before: nlindex)
        launchBefore = SpaceXData.shared.launches[lbindex]
      } else {
        // No next: before is last
        launchBefore = SpaceXData.shared.launches.last
      }
    }
    
    logger.debug("Next launch is \(String(describing: nextLaunch)), last launch was \(String(describing: launchBefore)).")
    
    // MARK: Get interesting launch
    if nextLaunch?.dateUTC != nil && launchBefore?.dateUTC != nil {
      let delta = nextLaunch!.dateUTC.timeIntervalSince(launchBefore!.dateUTC)
      var discriminator: Double = 36 * 3600
      
      if delta < 48 * 3600 {
        // Less than two days between launches
        discriminator = delta * 2 / 5
      }
      
      if date < (launchBefore?.dateUTC)! + discriminator {
        // This launch is interesting
        interestingLaunch = launchBefore
      } else {
        interestingLaunch = nextLaunch
      }
    }
    
    logger.debug("Interesting launch is \(String(describing: interestingLaunch)).")
    
    // MARK: Getting bg and patch
    var bg: UIImage?
    var patch: UIImage?
    
    let group = DispatchGroup()
    
    group.enter()
    interestingLaunch?.getPatch { image in
      patch = image
      group.leave()
      logger.debug("Got patch for \(interestingLaunch!): \(String(describing: image)).")
    }
    
    group.enter()
    interestingLaunch?.getImage(atIndex: 0) { image in
      bg = image
      group.leave()
      logger.debug("Got image for \(interestingLaunch!): \(String(describing: image)).")
    }
    
    let result = group.wait(timeout: DispatchTime.now() + 10.0)
    logger.debug("Dispatch group wait result is \(String(describing: result)).")
    
    return SimpleEntry(date: date, interestingLaunch: interestingLaunch, backgroundImage: bg, missionPatch: patch)
  }
  
  func placeholder(in context: Context) -> SimpleEntry {
    logger.debug("Generating placeholder.")
    return SimpleEntry(date: Date(), interestingLaunch: SampleData.shared.launch, backgroundImage: nil, missionPatch: nil)
  }
  
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    logger.debug("Generating snapshot.")
    
    var entry: Provider.Entry
    if context.isPreview {
      entry = SimpleEntry(date: SampleData.shared.launch.dateUTC.addingTimeInterval(-2400), interestingLaunch: SampleData.shared.launch, backgroundImage: SampleData.shared.bg, missionPatch: SampleData.shared.patch)
    } else {
     entry = generateEntry(Date())
    }
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    logger.debug("Generating timeline.")
    
    var entries: [SimpleEntry] = []
    
//    let queue = OperationQueue()
//    queue.name = "com.persello.norminal.widget.concurrentTimelineGeneration"
//    queue.qualityOfService = .background
//    queue.maxConcurrentOperationCount = 48
    
    // Generate entries accordingly with generated dates
    for date in generateRefreshDates() {
      // queue.addOperation {
        entries.append(generateEntry(date))
      // }
    }
    
    // queue.waitUntilAllOperationsAreFinished()
    
//    logger.debug("Timeline queue finished.")
    
    // Generate timeline every four hours
    let timeline = Timeline(entries: entries, policy: .after(Date().addingTimeInterval(3600 * 6)))
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let interestingLaunch: Launch?
  let backgroundImage: UIImage?
  let missionPatch: UIImage?
}

struct NorminalWidgetEntryView: View {
  var entry: Provider.Entry
  @Environment(\.widgetFamily) var family
  
  @ViewBuilder
  var body: some View {
    //    switch family {
    //      case .systemSmall:
    NorminalWidgetSmallWidget(entry: entry)
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
struct NorminalWidget: Widget {
  let kind: String = "NorminalWidget"
  
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      NorminalWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Launches")
    .description("Shows recent and upcoming rocket launches.")
    .supportedFamilies([.systemSmall])
  }
}

class SampleData {
  
  private var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Widget sample data")

  var bg: UIImage?
  var patch: UIImage?
  let launch = FakeData.shared.crewDragon!
  
  static var shared = SampleData()
  
  init() {
    let group = DispatchGroup()
    
    group.enter()
    launch.getPatch { [self] image in
      self.patch = image
      group.leave()
      logger.debug("Got patch for \(launch): \(String(describing: image)).")
    }
    
    group.enter()
    launch.getImage(atIndex: 0) { [self] image in
      self.bg = image
      group.leave()
      logger.debug("Got image for \(launch): \(String(describing: image)).")
    }
    
    let result = group.wait(timeout: DispatchTime.now() + 10.0)
    logger.debug("Dispatch group wait result is \(String(describing: result)).")
  }
}

struct NorminalWidget_Previews: PreviewProvider {
  static var previews: some View {
    
    
    Group {
      NorminalWidgetEntryView(entry: SimpleEntry(date: Date(), interestingLaunch: SampleData.shared.launch, backgroundImage: SampleData.shared.bg, missionPatch: SampleData.shared.patch))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
      
      NorminalWidgetEntryView(entry: SimpleEntry(date: Date(), interestingLaunch: SampleData.shared.launch, backgroundImage: SampleData.shared.bg, missionPatch: SampleData.shared.patch))        .previewContext(WidgetPreviewContext(family: .systemSmall))
        .colorScheme(.dark)
      
      NorminalWidgetEntryView(entry: SimpleEntry(date: Date(), interestingLaunch: SampleData.shared.launch, backgroundImage: nil, missionPatch: SampleData.shared.patch))        .previewContext(WidgetPreviewContext(family: .systemSmall))
      
      NorminalWidgetEntryView(entry: SimpleEntry(date: Date(), interestingLaunch: SampleData.shared.launch, backgroundImage: SampleData.shared.bg, missionPatch: SampleData.shared.patch))        .previewContext(WidgetPreviewContext(family: .systemSmall))
        .redacted(reason: .placeholder)
    }
  }
}

// MARK: - Subviews
struct NorminalWidgetSmallWidget: View {
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
        
        ClockCountdownView(launch: launch)
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
        Image(systemName: "xmark.seal")
          .foregroundColor(.gray)
          .font(.system(size: 40, weight: .thin))
          .frame(width: 52, height: 52)
          .background(Circle().foregroundColor(Color(UIColor.systemGray5)))
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
  var launch: Launch
  
  var body: some View {
    let launchDate = launch.dateUTC
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
      Text(launch.getNiceDate(usePrecision: true))
        .font(.system(size: 18, weight: .semibold, design: .rounded))
        .minimumScaleFactor(0.3)
    }
  }
}