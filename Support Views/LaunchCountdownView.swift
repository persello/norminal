//
//  LaunchCountdownView.swift
//  Norminal
//
//  Created by Riccardo Persello on 02/03/21.
//

import SwiftUI

struct LaunchCountdownView: View {
    @EnvironmentObject var launch: Launch
    
    var body: some View {
        VStack(alignment: .center) {
            LaunchCountdownText(precision: launch.datePrecision, dateUTC: launch.dateUTC)
            Divider()
            HStack {
                LaunchLocationView(launchpad: launch.getLaunchpad())
                Divider()
                WeatherView()
            }
            if let sfDate = launch.staticFireDateUTC {
                Divider()
                HStack {
                    Text("Static fire:")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    Text(DateFormatter.localizedString(from: sfDate, dateStyle: .short, timeStyle: .short))
                }
            }
        }
        .padding([.top, .leading, .trailing], 24)
        .padding(.bottom, 16)
        .background(Color(UIColor.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 24.0, style: .continuous))
    }
}


struct LaunchCountdownView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LaunchCountdownView()
                .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/400.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/))
            LaunchCountdownView()
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/400.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/))
        }
        .environmentObject(SpaceXData.shared.getNextLaunch() ?? FakeData.shared.crewDragon!)
    }
}

struct LaunchCountdownText: View {
    var precision: LaunchDatePrecision
    var dateUTC: Date
    
    // TODO: Use RelativeDateTimeFormatter() ! ----------------------------------------------------------
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            switch precision {
                case LaunchDatePrecision.year,
                     LaunchDatePrecision.halfYear,
                     LaunchDatePrecision.quarterYear:
                    let years =
                        abs(ceil(dateUTC.timeIntervalSinceNow/(365*24*3600)))
                    
                    if years != 0 {
                        Text("\(dateUTC < Date() ? "" : "in")")
                            .lineLimit(1)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.gray)
                        Text("\(years, specifier: "%.0f")")
                            .lineLimit(1)
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .minimumScaleFactor(0.04)
                    }
                    Text("\(years == 0 ? "this " : "")year\(years > 1 ? "s": "") \(dateUTC < Date() && years != 0 ? "ago" : "")")
                        .lineLimit(1)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.gray)
                case LaunchDatePrecision.month:
                    let months =
                        abs(ceil(dateUTC.timeIntervalSinceNow/(30*24*3600)))
                    
                    if months != 0 {
                        Text("\(dateUTC < Date() ? "" : "in")")
                            .lineLimit(1)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.gray)
                        Text("\(months, specifier: "%.0f")")
                            .lineLimit(1)
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .minimumScaleFactor(0.04)
                    }
                    Text("\(months == 0 ? "this " : "")month\(months > 1 ? "s": "") \(dateUTC < Date() && months != 0 ? "ago" : "")")
                        .lineLimit(1)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.gray)
                    
                case LaunchDatePrecision.day:
                    let days =
                        abs(ceil(dateUTC.timeIntervalSinceNow/(24*3600)))
                    
                    if days != 0 {
                        Text("\(dateUTC < Date() ? "" : "in")")
                            .lineLimit(1)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.gray)
                        Text("\(days, specifier: "%.0f")")
                            .lineLimit(1)
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .minimumScaleFactor(0.04)
                    }
                    Text("\(days == 0 ? "to" : "")day\(days > 1 ? "s": "") \(dateUTC < Date() && days != 0 ? "ago" : "")")
                        .lineLimit(1)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.gray)
                    
                case LaunchDatePrecision.hour:
                    Text("T\(dateUTC < Date() ? "+" : "-")")
                        .lineLimit(1)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.gray)
                        .padding(.trailing, -8)
                    Text(dateUTC, style: .timer)
                        .lineLimit(1)
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .minimumScaleFactor(0.04)
                    
            }
        }
        .padding([.bottom], -2)
    }
}

struct LaunchLocationView: View {
    var launchpad: Launchpad?
    var body: some View {
        VStack {
            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: 45, weight: .light))
                .foregroundColor(.gray)
                .padding([.bottom, .top], 8)
            
            Text(launchpad?.name ?? "Unknown launchpad")
                .multilineTextAlignment(.center)
                .font(.headline)
                .frame(maxWidth: .infinity)
            
            Text(launchpad?.locality ?? "Unknown location")
                .multilineTextAlignment(.center)
                .font(.footnote)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)
        }
    }
}

struct WeatherView: View {
    @EnvironmentObject var launch: Launch
    
    @State var forecastIcon: String?
    @State var forecastText: String?
    @State var windTempConfiguration: WindTemperatureView.Configuration?
    
    var body: some View {
        VStack {
            Image(systemName: forecastIcon ?? "questionmark")
                .font(.system(size: 45, weight: .light))
                .foregroundColor(.gray)
                .padding([.bottom, .top], 8)
            
            Text(forecastText ?? "Unknown weather")
                .multilineTextAlignment(.center)
                .font(.headline)
                .frame(maxWidth: .infinity)
            
            WindTemperatureView(configuration: self.windTempConfiguration)
                .onAppear {
                    launch.getLaunchpad()?.getForecast(for: launch.dateUTC) { result in
                        switch result {
                            case .success(let forecast):
                                forecastIcon = forecast.getIcon()
                                forecastText = forecast.condition.text
                                windTempConfiguration = WindTemperatureView.Configuration(
                                    windDirection: Angle(degrees: forecast.windDegree),
                                    windSpeed: Measurement(value: forecast.windkph,
                                                           unit: UnitSpeed.kilometersPerHour),
                                    textualWindDirection: forecast.windDirection,
                                    temperature: Measurement(value: forecast.tempC,
                                                             unit: UnitTemperature.celsius)
                                )
                        }
                    }
                }
        }
    }
    
    struct WindTemperatureView: View {
        struct Configuration {
            init(windDirection: Angle, windSpeed: Measurement<UnitSpeed>, textualWindDirection: String, temperature: Measurement<UnitTemperature>) {
                self.formatter = MeasurementFormatter()
                formatter.numberFormatter.maximumFractionDigits = 0
                
                self.windDirection = windDirection
                self.windSpeed = windSpeed
                self.textualWindDirection = textualWindDirection
                self.temperature = temperature
            }
            
            let formatter: MeasurementFormatter
            let windDirection: Angle
            let windSpeed: Measurement<UnitSpeed>
            let textualWindDirection: String
            let temperature: Measurement<UnitTemperature>
        }
        
        var configuration: WindTemperatureView.Configuration?
        
        var body: some View {
            if let configuration = self.configuration {
                VStack {
                    HStack {
                        Image(systemName: "location.north.fill")
                            .rotationEffect(configuration.windDirection)
                        Text(configuration.formatter.string(from: configuration.windSpeed) + " " + configuration.textualWindDirection)
                            .padding(.leading, -4)
                    }
                    
                    HStack {
                        Image(systemName: "thermometer")
                        Text(configuration.formatter.string(from: configuration.temperature))
                            .padding(.leading, -4)
                    }
                }
                .foregroundColor(.gray)
                .font(.footnote)
            } else {
                ProgressView()
            }
        }
    }
}
