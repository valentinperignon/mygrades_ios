//
//  ContentView.swift
//  MyGrades
//
//  Created by Valentin Perignon on 25/07/2020.
//  Copyright © 2020 Valentin Perignon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  // MARK: Properties
  
  @EnvironmentObject var allSubjects: SubjectStore
  
  @State private var showNewSubjectSheet = false
  
  // MARK: Body
  
  var body: some View {
    
    NavigationView {
      
      if allSubjects.subjects.isEmpty {
        
        VStack {
          Spacer()
          
          Image("NothingToPrint")
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 40)
            .foregroundColor(.mgPurpleLight)
          
          Text("No Subject")
            .font(.title)
            .fontWeight(.bold)
          Text("You need to add at least one subject")
            .foregroundColor(.mgPurpleDark)
            .multilineTextAlignment(.center)
          
          Spacer()
          
          ButtonFullWidth(type: .primary, title: "New Subject", iconSysName: "plus") {
            let feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator.selectionChanged()
            
            self.showNewSubjectSheet.toggle()
          }
          .padding(.bottom, 30)
        }
        .padding(.horizontal, 15)
        .modifier(ContentViewNavigationModifier(displaySheet: $showNewSubjectSheet))
        
      } else {
        
        ScrollView {
          // ----- Average Grade -----
          ZStack {
            Rectangle()
              .fill(Color.mgPurpleLight)
              .clipShape(RoundedRectangle(radius: 20))
            
            AverageView(average: allSubjects.averageDisplay)
              .padding(.top, 5)
              .padding(.bottom, 18)
          }
          .padding(.bottom, 4)
          
          // ----- New Subject -----
          
          ButtonFullWidth(type: .primary, title: "New Subject", iconSysName: "plus") {
            let feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator.selectionChanged()
            
            self.showNewSubjectSheet.toggle()
          }
          
          // ----- Subjects -----
          ForEach(allSubjects.subjects) { subject in
            NavigationLink(destination: GradesView(subject: subject).environmentObject(self.allSubjects)) {
              SubjectListView(subject: subject)
                .environmentObject(self.allSubjects)
                .contextMenu(
                  ContextMenu {
                    Button(action: {
                      let feedbackGenerator = UINotificationFeedbackGenerator()
                      feedbackGenerator.notificationOccurred(.success)
                      
                      self.allSubjects.subjects.remove(at:
                        self.allSubjects.subjects.firstIndex(of: subject)!
                      )
                      self.allSubjects.computeAverage()
                    }) {
                      Text("Remove")
                      Image(systemName: "trash")
                    }
                  }
                )
            }
            .accentColor(Color.black)
            .padding(.horizontal, 15)
          }
          
          Spacer(minLength: 15)
        }
        .modifier(ContentViewNavigationModifier(displaySheet: $showNewSubjectSheet))
      }
        
    }
    .sheet(isPresented: $showNewSubjectSheet) {
      NewSubjectView()
        .environmentObject(self.allSubjects)
    }
    
  }
}

struct ContentViewNavigationModifier: ViewModifier {
  @Binding var displaySheet: Bool
  
  func body(content: Content) -> some View {
    content
      .navigationBarTitle(
        Text("My Subjects")
      )
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(SubjectStore())
  }
}