//
//  SearchView.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/4/30.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var show = false
    @Namespace var namespace
    @State var selectedIndex = 0
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model : Model
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    content
                }
                .padding(20)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                .strokeStyle(cornerRadius: 30)
                .padding(20)
                //添加上面的模糊部分
                .background(
                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(height: 200)
                        .frame(maxHeight: .infinity,alignment:.top)
                        .blur(radius: 30)
                        .offset(y:-200)
                )
                .background(
                    Image("Blob 1").offset(x:-100 ,y:-200)
                )
                
            }
            .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always) ,prompt: Text("SwiftUI,React,UI,Design,Flutter")){
                //紧跟在searchable后面的内容是点击搜索框之后才会出现 是Suggestion
                ForEach(suggestions){ suggestion in
                    Button{
                        text = suggestion.text
                    }label:{
                        Text(suggestion.text)
                            .searchCompletion(suggestion.text)
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(trailing: Button{
                model.showDone = false
                //消除模态,也就是关掉这层页面
                presentationMode.wrappedValue.dismiss()
            }label: {
                model.showDone ? Text("Done") : Text("")
            })
            .sheet(isPresented: $show){
                CourseView(namespace: namespace,course: courses[selectedIndex], show: $show)
            }
        }
    }
    var content :some View{
        ForEach(Array(courses.enumerated()), id:\.offset){index, item in
            if item.title.contains(text) || text == "" {
                //添加Divider
                if index != 0 { Divider() }
                Button{
                    show = true
                    selectedIndex = index
                }label: {
                    HStack (alignment: .top,spacing:12){
                        Image(item.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:54,height: 54)
                            .background(Color("Background"))
                            .mask(RoundedRectangle(cornerRadius: 10, style: RoundedCornerStyle.continuous))
                        VStack (alignment:.leading){
                            Text(item.title).bold()
                                .foregroundColor(.primary)
                            Text(item.text)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity,alignment:.leading)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.vertical,4)
                    // 去除list的分隔线
                .listRowSeparator(.hidden)
            }
            }
            
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(Model())
}
