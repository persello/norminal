//
//  MissionRecapCard.swift
//  Norminal
//
//  Created by Riccardo Persello on 11/10/2020.
//

import SwiftUI
import SDWebImageSwiftUI
import VisualEffects

struct MissionRecapCard: View {
  @State var launch: Launch
  
  var body: some View {
    ZStack {
      VisualEffectBlur(blurStyle: .systemThinMaterial, vibrancyStyle: .label) {
        
        MissionRecapView(launch:launch, showCrewWhenAvailable: false)
      }
      .frame(height: 100)
      .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
  }
}

struct MissionRecapCard_Previews: PreviewProvider {
  static var previews: some View {
    MissionRecapCard(launch: FakeData.shared.crewDragon!)
      .previewLayout(.sizeThatFits)
      .padding()
    
  }
}

struct MissionRecapView: View {
  var launch: Launch
  var showCrewWhenAvailable: Bool
  
  var body: some View {
    HStack(alignment: .center, spacing: 8) {
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
      
      VStack(alignment: .leading, spacing: 2) {
        Text(launch.name)
          .multilineTextAlignment(.leading)
          .font(.headline)
        
        HStack(alignment: .center, spacing: 6) {
          
          // Number
          Text("#\(launch.flightNumber)")
            .font(.system(.caption, design: .monospaced))
            .opacity(0.8)
          
          // Success
          // == true/false is for excluding nil
          if launch.success == true {
            Text("\(Image(systemName: "checkmark.seal.fill")) Success")
              .foregroundColor(.green)
          } else if launch.success == false {
            Text("\(Image(systemName: "xmark.seal.fill")) Failure")
              .foregroundColor(.red)
          }
          
          // Cores
          if !launch.upcoming {
            switch launch.coresToRecover {
              case 0:
                EmptyView()
              case 1:
                Text("\(Image(systemName: "arrow.3.trianglepath"))")
                  .foregroundColor(launch.coresRecovered > 0 ? .blue : .red)
              default:
                Text("\(Image(systemName: "arrow.3.trianglepath")) \(launch.coresRecovered)/\(launch.coresToRecover)")
                  .foregroundColor(launch.coresRecovered == launch.coresToRecover ? .blue : .red)
            }
            
            // Fairings
            if launch.fairings?.recoveryAttempt ?? false {
              Image(systemName: (launch.fairings?.recovered ?? false) ? "checkmark.shield" : "xmark.shield")
                .foregroundColor((launch.fairings?.recovered ?? false) ? .blue : .red)
            }
          }
        }
        .font(.caption)
        
        Text(launch.getNiceDate(usePrecision: true) + (launch.NET ? "NET" : ""))
          .font(.caption)
        
        
        // Crew
        if let crew = launch.getCrew(), showCrewWhenAvailable {
          HStack {
            ForEach(crew) { astronaut in
              AstronautPicture(astronaut: astronaut)
                .frame(width: 40, height: 40)
            }
          }
          .padding(.top, 4)
        }
      }
      .padding(8)
    }
  }
}

struct MissionRecapView_Previews: PreviewProvider {
  static var previews: some View {
    MissionRecapView(launch: FakeData.shared.crewDragon!, showCrewWhenAvailable: true)
      .previewLayout(.sizeThatFits)
  }
}
