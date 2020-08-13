//
//  SubjectListView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 29/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct SubjectListView: View {
  // MARK: Properties
  
  @ObservedObject var subject: Subject
  
  // MARK: Body
  var body: some View {
    HStack {
      // ----- Average grade
      ZStack {
        subject.getColor().dark
        
        Text(subject.averageDisplay)
          .fontWeight(.heavy)
          .foregroundColor(.white)
      }
      .frame(width: 65, height: 65)
      .cornerRadius(15)
      .padding(.trailing, 5)
      
      // ----- About
      VStack {
        HStack {
          if subject.average < 10.0 {
            Image(systemName: "exclamationmark.circle")
              .font(.headline)
              .foregroundColor(.mgOrangeDark)
          }
          Text(subject.name)
            .font(.headline)
            .fontWeight(.medium)
            .foregroundColor(subject.average < 10.0 ? .mgOrangeDark : .black)
            
          Spacer()
        }
        .padding(.bottom, 6)
        
        HStack {
          Text(
            (subject.coefficient.rounded() == subject.coefficient)
              ? "coeff. \(Int(subject.coefficient))"
              : String(format: "coeff: %.2f", subject.coefficient)
          )
            .font(.callout)
            .fontWeight(.light)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(subject.getColor().light)
            .cornerRadius(7)
          Spacer()
        }
      }
      
      Spacer()
      
      // ----- Link to edit
      Image("ArrowRight")
        .resizable()
        .renderingMode(.template)
        .foregroundColor(subject.getColor().dark)
        .frame(width: 37, height: 37)
        .contrast(0.95)
        .brightness(0.01)
    }
    .padding(.horizontal, 15)
  }
}

struct SubjectListView_Previews: PreviewProvider {
  static var previews: some View {
    let subject = Subject(name: "Langages du Web", color: .purple, coefficient: 6)
    subject.addGrade(name: "Test", value: 5.5, coefficient: 1, date: Date())
    subject.computeAverage()
    
    return SubjectListView(subject:
      subject
    )
  }
}
