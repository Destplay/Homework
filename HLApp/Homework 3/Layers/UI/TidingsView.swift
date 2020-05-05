//
//  TidingsView.swift
//  HLApp
//
//  Created by Роман on 05.04.2020.
//  Copyright © 2020 destplay. All rights reserved.
//
import SwiftUI
import MyLibraryUI

struct TidingsView: View {
    @EnvironmentObject var viewModel: TidingsViewModel
    
    var body: some View {
        NavControllerView(transition: .custom(.opacity)) {
            VStack {
                Text("News").font(.headline).padding(.top)
                Picker("", selection: self.$viewModel.category) {
                    ForEach(self.$viewModel.categories.wrappedValue) { category in
                        Text(category.name).tag(category.type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                LoadingView(isShowing: .constant(self.viewModel.isAllUpdate)) {
                    List(self.viewModel.content) { item in
                        ItemTidingsView(news: item).environmentObject(self.viewModel)
                    }
                }
            }.onAppear {
                self.viewModel.fetch()
            }
        }
    }
}

struct ItemTidingsView: View {
    
    @EnvironmentObject var viewModel: TidingsViewModel
    let news: TidingsModelUI
    
    var body: some View {
        VStack(alignment: .leading) {
            NavPushButton(destination: DetailTidingsView(news: self.news)) {
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

struct DetailTidingsView: View {
    let news: TidingsModelUI
    
    var body: some View {
        VStack(alignment: .leading) {
            NavPopButton(destination: .previous) {
                Text("Cancel").foregroundColor(.blue).bold().padding([.leading, .top])
            }
            
            NavPushButton(destination: ImageTidingsView(image: self.news.image)) {
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

struct ImageTidingsView: View {
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

struct TidingsView_Previews: PreviewProvider {
    static var previews: some View {
        TidingsView().environmentObject(ServiceLocator.shared.getTidingsViewModel())
    }
}
