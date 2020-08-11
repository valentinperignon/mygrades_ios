//
//  SheetHeaderView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 10/08/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct SheetHeaderView: View {
  // MARK: Properties
  
  var title: String
  var subtitle: String
  
  // MARK: Body
  
  var body: some View {
    VStack {
      HStack {
        Text(title)
          .font(.largeTitle)
          .fontWeight(.bold)
        Spacer()
      }
      HStack {
        Text(subtitle)
          .font(.callout)
        Spacer()
      }
    }
    .padding([.horizontal, .bottom])
    .padding(.top, 60)
    .background(Color.mgPurpleLight)
    .padding(.bottom, 22)
  }
}

struct SheetHeaderView_Previews: PreviewProvider {
  static var previews: some View {
    SheetHeaderView(title: "My Title", subtitle: "My subtitle")
  }
}
