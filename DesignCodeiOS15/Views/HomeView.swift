//
//  Model.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/4/29.
//


import SwiftUI

struct HomeView: View {
    @State var hasScrolled = false
    @Namespace var namespace
    @State var show = false
    @State var showStatusBar = true
    @State var selectedID = UUID()
    @State var showCource = false
    @State var selectedIndex = 0
    @EnvironmentObject var model : Model
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                scrollDetection
                
                featured
                
                Text("Courses".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))])
                    {
                        if !show {
                            cards
                        }else{
                            placeholder
                        }
                    }
//                    .padding(20)
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay(
                NavigationBar(title: "Featured", hasScrolled: $hasScrolled)
            )
            
            if show {
                details
            }
        }
        .statusBar(hidden: !showStatusBar)
        .onChange(of: show) { newValue in
            withAnimation(.closeCard) {
                if newValue {
                    showStatusBar = false
                } else {
                    showStatusBar = true
                }
            }
        }
        .sheet(isPresented: $showCource){
            CourseView(namespace: namespace,course: courses[selectedIndex],show: $showCource)
                .background(.blue.opacity(0))
        }
    }
    
    var scrollDetection: some View {
        GeometryReader { proxy in
//                Text("\(proxy.frame(in: .named("scroll")).minY)")
            Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeInOut) {
                if value < 0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
        })
    }
    
    var featured: some View {
        TabView {
            ForEach(Array(featuredCourses.enumerated()), id:\.offset){index, course in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    
                    FeaturedItem(course: course)
                        .padding(.vertical, 40)
//                        .frame(width:350)
                        .frame(maxWidth: .infinity)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)
                        .blur(radius: abs(minX / 40))
                        .overlay(
                            Image(course.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 230)
                                .offset(x: 32, y: -80)
                                .offset(x: minX / 2)
                        )
                        .onTapGesture {
                            showCource = true
                            selectedIndex = index
                        }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 430)
        .background(
            Image("Blob 1")
                .offset(x: 250, y: -100)
        )
        
    }
    var cards:some View{
        ForEach(courses) { course in
            CourseItem(namespace: namespace, course: course, show: $show)
                .onTapGesture {
                    withAnimation(.openCard) {
                        show.toggle()
                        model.showDetail.toggle()
                        showStatusBar = false
                        selectedID = course.id
                    }
            }
        }
    }
    
    var placeholder :some View {
        ForEach(courses) { course in
            Rectangle()
                .fill(.white)
                .frame(height:300)
                .cornerRadius(30)
                .shadow(color:Color("Shadow"),radius: 20,x:0,y:10)
                .opacity(0)
            .padding(.horizontal,20)
        }
    }
    
    var details :some View{
        ForEach(courses) { course in
            if course.id == selectedID{
                CourseView(namespace: namespace, course: course, show: $show)
                    .zIndex(1)
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                        removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(Model())
        HomeView()
    }
}
