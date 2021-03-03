//
//  LaunchCountdownView.swift
//  Norminal
//
//  Created by Riccardo Persello on 02/03/21.
//

import SwiftUI

struct LaunchCountdownView: View {
    @State var launch: Launch
    @State var forecastIcon: String?
    @State var hourlyForecast: WeatherAPIResponse.WeatherAPIForecastHour?
    
    func buildWindTempView() -> some View {
        if let wind = hourlyForecast?.windkph,
           let direction = hourlyForecast?.windDirection,
           let degrees = hourlyForecast?.windDegree,
           let temperature = hourlyForecast?.tempC {
            let windSpeed = Measurement(value: wind, unit: UnitSpeed.kilometersPerHour)
            let temperature = Measurement(value: temperature, unit: UnitTemperature.celsius)
            
            let formatter = MeasurementFormatter()
            formatter.numberFormatter.maximumFractionDigits = 0
            
            var view: some View {
                HStack {
                    Image(systemName: "location.north.fill")
                        .rotationEffect(Angle(degrees: degrees))
                    Text(formatter.string(from: windSpeed) + " " + direction)
                        .padding(.leading, -4)
                    
                    Image(systemName: "thermometer")
                    Text(formatter.string(from:temperature))
                        .padding(.leading, -4)
                }
                .foregroundColor(.gray)
                .font(.footnote)
            }
            
            return AnyView(view)
            
        } else {
            var view: some View {
                Text("Wind and temperature not available")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
            }
            
            return AnyView(view)
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .lastTextBaseline) {
                switch launch.datePrecision {
                    case LaunchDatePrecision.year,
                         LaunchDatePrecision.halfYear,
                         LaunchDatePrecision.quarterYear:
                        let years =
                            abs(ceil(launch.dateUTC.timeIntervalSinceNow/(365*24*3600)))
                        
                        if years != 0 {
                            Text("\(launch.dateUTC < Date() ? "" : "in")")
                                .lineLimit(1)
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.gray)
                            Text("\(years, specifier: "%.0f")")
                                .lineLimit(1)
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .minimumScaleFactor(0.04)
                        }
                        Text("\(years == 0 ? "this " : "")year\(years > 1 ? "s": "") \(launch.dateUTC < Date() && years != 0 ? "ago" : "")")
                            .lineLimit(1)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.gray)
                    case LaunchDatePrecision.month:
                        let months =
                            abs(ceil(launch.dateUTC.timeIntervalSinceNow/(30*24*3600)))
                        
                        if months != 0 {
                            Text("\(launch.dateUTC < Date() ? "" : "in")")
                                .lineLimit(1)
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.gray)
                            Text("\(months, specifier: "%.0f")")
                                .lineLimit(1)
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .minimumScaleFactor(0.04)
                        }
                        Text("\(months == 0 ? "this " : "")month\(months > 1 ? "s": "") \(launch.dateUTC < Date() && months != 0 ? "ago" : "")")
                            .lineLimit(1)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.gray)
                        
                    case LaunchDatePrecision.day:
                        let days =
                            abs(ceil(launch.dateUTC.timeIntervalSinceNow/(24*3600)))
                        
                        if days != 0 {
                            Text("\(launch.dateUTC < Date() ? "" : "in")")
                                .lineLimit(1)
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.gray)
                            Text("\(days, specifier: "%.0f")")
                                .lineLimit(1)
                                .font(.system(size: 36, weight: .bold, design: .rounded))
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
                            .font(.system(size: 36, weight: .bold, design: .rounded))
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
                    Image(systemName: forecastIcon ?? "questionmark")
                        .font(.system(size: 45, weight: .light))
                        .foregroundColor(.gray)
                        .padding([.bottom, .top], 8)
                    
                    Text(hourlyForecast?.condition.text ?? "Unknown weather")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                    

                    buildWindTempView()
                }
            }
            .onAppear {
                if self.hourlyForecast != nil {
                    return
                }
                
                if let launchpadLocation = launch.getLaunchpad()?.location {
                    WeatherAPI.shared.forecast(forLocation: launchpadLocation, at: launch.dateUTC) { forecastResponse in
                        if let hourlyForecast = forecastResponse?.getForecastForHourOfLaunch(/*unixDateTime: launch.dateUNIX - (3600*24*10)*/) {
                            forecastIcon = hourlyForecast.getIcon()
                            self.hourlyForecast = hourlyForecast
                        }
                    }
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
            LaunchCountdownView(launch: SpaceXData.shared.getNextLaunch() ?? FakeData.shared.crewDragon!)
                .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/400.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/))
            LaunchCountdownView(launch: SpaceXData.shared.getNextLaunch() ?? FakeData.shared.crewDragon!)
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/400.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/))
        }
    }
}
