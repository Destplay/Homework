//
//  MainView.swift
//  HLApp
//
//  Created by Роман on 15.03.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import SwiftUI
import MyLibraryUI

enum CategoryType: String {
    case business = "business"
    case sports = "sports" 
    case technology = "technology"
}

struct NewsView: View {
    @EnvironmentObject var viewModel: NewsViewModel
    
    var body: some View {
        NavControllerView(transition: .custom(.opacity)) {
            VStack {
                Text("News").font(.headline).padding(.top)
                Picker("", selection: self.$viewModel.category) {
                    ForEach(self.viewModel.categories) { category in
                        Text(category.name).tag(category.type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                LoadingView(isShowing: .constant(self.viewModel.isAllUpdate)) {
                    List(self.viewModel.content) { item in
                        ItemNewsView(news: item).environmentObject(self.viewModel)
                    }
                }
            }
        }
    }
}

struct ItemNewsView: View {
    
    @EnvironmentObject var viewModel: NewsViewModel
    let news: NewsModelUI
    
    var body: some View {
        VStack(alignment: .leading) {
            NavPushButton(destination: DetailNewsView(news: self.news)) {
                Group {
                    Text(self.news.title)
                        .font(.headline)
                    Text(self.news.description)
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                }
                .onAppear() {
                    if self.viewModel.content.isLast(self.news) {
                        self.viewModel.pageLoading()
                    }
                }
                if self.viewModel.isPaginationUpdate && self.viewModel.content.isLast(self.news) {
                    Divider()
                    Text("Loading...")
                }
            }
        }
    }
}

struct DetailNewsView: View {
    let news: NewsModelUI
    
    var body: some View {
        VStack(alignment: .leading) {
            NavPopButton(destination: .previous) {
                Text("Cancel").foregroundColor(.blue).bold().padding([.leading, .top])
            }
            
            NavPushButton(destination: ImageNewsView(image: self.news.image)) {
                DetailImageView(withURL: self.news.image)
            }
            Text(self.news.title)
                .font(.headline)
                .padding(5)
            Text(self.news.content)
                .font(.system(size: 12))
                .foregroundColor(Color.gray)
                .padding(5)
            Spacer()
        }
    }
}

struct ImageNewsView: View {
    let image: String
    
    var body: some View {
        VStack(alignment: .leading) {
            NavPopButton(destination: .previous) {
                Text("Cancel").foregroundColor(.blue).bold().padding([.leading, .top])
            }
            Spacer()
            ZoomImageView(withURL: self.image)
            Spacer()
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView().environmentObject(NewsViewModel())
    }
}

extension RandomAccessCollection where Self.Element: Identifiable {
    public func isLast(_ item: Element) -> Bool {
        guard isEmpty == false else {
            
            return false
        }
        guard let itemIndex = lastIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            
            return false
        }
        
        return distance(from: itemIndex, to: endIndex) == 1
    }
}
