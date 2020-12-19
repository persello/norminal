//
//  LaunchListTile.swift
//  Norminal
//
//  Created by Riccardo Persello on 09/10/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct LaunchListTile: View {
    @State var launch: Launch
    var showDetails: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                
                WebImage(url: launch.links?.patch?.large)
                    .resizable()
                    .placeholder {
                        if launch.links?.patch?.large == nil {
                            Image(systemName: "xmark.seal")
                                .foregroundColor(.gray)
                                .font(.system(size: 40, weight: .thin))
                                .frame(width: 70, height: 70)
                                .background(Circle().foregroundColor(Color(UIColor.systemGray6)))
                        }
                    }
                    .indicator(Indicator.activity)
                    .frame(width: 70, height: 70)
                    .padding(4)
                
                VStack(alignment: .leading) {
                    Text(launch.name)
                        .font(.headline)
                    Text(String(describing: launch.getNiceDate(usePrecision: true)))
                        .font(.caption)
                    HStack {
                        if let crew = launch.getCrew() {
                            ForEach(crew) { astronaut in
                                AstronautPicture(astronaut: astronaut)
                                    .frame(width: 40, height: 40)
                            }
                        }
                    }
                }
                .padding(.horizontal, 4.0)
                
                Spacer()
                
                // Show arrow in right place
                if(showDetails) {
                    Image(systemName: "chevron.forward")
                        .font(Font.caption.weight(.semibold))
                        .foregroundColor(Color(UIColor.tertiaryLabel))
                        .padding(.trailing, 0.5)
                }
            }
            
            if(showDetails) {
                LaunchCountdownView(launch: launch)
                    .shadow(color: Color.black.opacity(0.2), radius: 12)
                    .padding(.top, 16)
                    .padding(.bottom, 8)
            }
        }
    }
}

struct LaunchListTile_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListTile(launch: SpaceXData.shared.getNextLaunch() ?? FakeData.shared.crewDragon!, showDetails: true)
            .frame(width: 350, height: 150, alignment: .center)
            .previewLayout(.fixed(width: 350, height: 400))
    }
}

struct LaunchCountdownView: View {
    @State var launch: Launch
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .lastTextBaseline) {
                switch launch.datePrecision {
                case LaunchDatePrecision.year,
                     LaunchDatePrecision.halfYear,
                     LaunchDatePrecision.quarterYear:
                    let years =
                        abs(ceil(launch.dateUTC.timeIntervalSinceNow/(365*24*3600)))
                    
                    if(years != 0) {
                    Text("\(launch.dateUTC < Date() ? "" : "in")")
                        .lineLimit(1)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.gray)
                        Text("\(years, specifier: "%.0f")")
                            .lineLimit(1)
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .minimumScaleFactor(0.04)
                    }
                    Text("\(years == 0 ? "this " : "")year\(years > 1 ? "s": "") \(launch.dateUTC < Date() && years != 0 ? "ago" : "")")
                        .lineLimit(1)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.gray)
                case LaunchDatePrecision.month:
                    let months =
                        abs(ceil(launch.dateUTC.timeIntervalSinceNow/(30*24*3600)))
                    
                    if(months != 0) {
                    Text("\(launch.dateUTC < Date() ? "" : "in")")
                        .lineLimit(1)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.gray)
                        Text("\(months, specifier: "%.0f")")
                            .lineLimit(1)
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .minimumScaleFactor(0.04)
                    }
                    Text("\(months == 0 ? "this " : "")month\(months > 1 ? "s": "") \(launch.dateUTC < Date() && months != 0 ? "ago" : "")")
                        .lineLimit(1)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.gray)
                    
                case LaunchDatePrecision.day:
                    let days =
                        abs(ceil(launch.dateUTC.timeIntervalSinceNow/(24*3600)))
                    
                    if(days != 0) {
                    Text("\(launch.dateUTC < Date() ? "" : "in")")
                        .lineLimit(1)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.gray)
                        Text("\(days, specifier: "%.0f")")
                            .lineLimit(1)
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .minimumScaleFactor(0.04)
                    }
                    Text("\(days == 0 ? "to" : "")day\(days > 1 ? "s": "") \(launch.dateUTC < Date() && days != 0 ? "ago" : "")")
                        .lineLimit(1)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.gray)
                    
                case LaunchDatePrecision.hour:
                    Text("T\(launch.dateUTC < Date() ? "+" : "-")")
                        .lineLimit(1)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.gray)
                        .padding(.trailing, -8)
                    Text(launch.dateUTC, style: .timer)
                        .lineLimit(1)
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .minimumScaleFactor(0.04)
                    
                }
            }
            .padding([.bottom], -2)
            Divider()
            HStack {
                VStack {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 45, weight: .light))
                        .foregroundColor(.gray)
                        .padding([.bottom, .top], 8)
                    
                    Text(launch.getLaunchpad()?.name ?? "Unknown launchpad")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                    
                    Text(launch.getLaunchpad()?.locality ?? "Unknown location")
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
                Divider()
                VStack {
                    Image(systemName: "sun.min")
                        .font(.system(size: 45, weight: .light))
                        .foregroundColor(.gray)
                        .padding([.bottom, .top], 8)
                    
                    Text("Generic weather")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                    
                    Text("Wind and temperature")
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding([.top, .leading, .trailing], 24)
        .padding(.bottom, 16)
        .background(Color(UIColor.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 24.0, style: .continuous))
        .onAppear {
            launch.datePrecision = LaunchDatePrecision.year
        }
    }
}
