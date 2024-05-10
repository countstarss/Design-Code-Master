//
//  Model.swift
//  DesignCodeiOS15
//
//  Created by 王佩豪 on 2024/4/29.
//

import SwiftUI

struct CourseView: View {
    var namespace: Namespace.ID
    var course: Course = courses[0]
    @Binding var show: Bool
    @State var appear = [false, false, false]
    @EnvironmentObject var model : Model
    @State var viewState : CGSize = .zero
    @State var isDraggable = true
    @State var showSection = false
    @State var selectedIndex = 0
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                content
                    .offset(y: 120)
                    .padding(.bottom, 200)
                    .opacity(appear[2] ? 1 : 0)
            }
            .coordinateSpace(name: "scroll")
            .onAppear{ model.showDetail = true }
            .onDisappear{ model.showDetail = false }
            .background(Color(UIColor.systemBackground))
            .mask(RoundedRectangle(cornerRadius: 10  , style: .continuous))
            .shadow(color: .black.opacity(0.3) ,radius: 30, x:2 ,y:10)
            .scaleEffect(viewState.width / -500 + 1)
//            .background(.gray.opacity(viewState.width / 100))
            .background(Color(UIColor.systemBackground))
            .background(.ultraThinMaterial)
            .gesture(isDraggable ? drag : nil)
            .ignoresSafeArea()
            
            
            button
        }
        .onAppear {
            withAnimation {
                fadeIn()
            }
        }
        .onChange(of: show) { newValue in
            withAnimation {
                fadeOut()
            }
        }
    }
    
    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 500)
            .foregroundStyle(.black)
            .background(
                // 背景上层
                Image(course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(maxWidth:500)
                    .matchedGeometryEffect(id: "image\(course.id)", in: namespace)
                    .offset(y:  scrollY > 0 ? scrollY * -0.5 : 0)
                    .scaleEffect(scrollY > -300 ? scrollY / 1000 + 1 : -300 / 1000 + 1)
            )
            .background(
                // 背景下层
                Image(course.background)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background\(course.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
//                    .scaleEffect(scrollY / 500 + 1)
                    .scaleEffect(scrollY > 100 ? scrollY / 1000 + 1 : 100 / 1000 + 1)
                    .blur(radius: scrollY / 50)
            )
            .mask(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(course.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
//                    .scaleEffect(y: scrollY > -300 ? scrollY / 1000 + 1 : -300 / 1000 + 1)
//                    .scaleEffect(x: 1000)
            )
            .overlay(
                overlayContent
                    .offset(y: scrollY > 0 ? scrollY * -0.2 : 0)
        )
        }
        .frame(height:500)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 30) {
            ForEach(Array(courseSections.enumerated()),id: \.offset){ index,section in
//                if index != 0 { Divider() }
                SectionRow(section: section)
                    .onTapGesture {
                        selectedIndex = index
                        showSection = true
                    }
            }
        }
        .padding(20)
        .background(.ultraThinMaterial , in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .strokeStyle(cornerRadius: 10)
        .padding(20)
        .sheet(isPresented: $showSection) {
            SectionView(section: courseSections[selectedIndex])
        }

    }
    
    var button: some View {
        Button {
            withAnimation(.closeCard) {
                show.toggle()
                model.showDetail.toggle()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(30)
        .ignoresSafeArea()
    }
    
    var overlayContent:some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(course.title)
                .font(.largeTitle.weight(.bold))
                .matchedGeometryEffect(id: "title\(course.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(course.subtitle.uppercased())
                .font(.footnote.weight(.semibold))
                .matchedGeometryEffect(id: "subtitle\(course.id)", in: namespace)
            Text(course.text)
                .font(.footnote)
                .matchedGeometryEffect(id: "text\(course.id)", in: namespace)
            Divider()
                .opacity(appear[0] ? 1 : 0)
            HStack {
                Image("Avatar Default")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .cornerRadius(10)
                    .padding(8)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .strokeStyle(cornerRadius: 18)
                Text("Taught by Meng To")
                    .font(.footnote)
            }
            .opacity(appear[1] ? 1 : 0)
        }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .matchedGeometryEffect(id: "blur\(course.id)", in: namespace)
            )
            .offset(y: 250)
            .padding(20)
    }
    
    var drag :some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local).onChanged{ value in
            //添加守卫 滑动值必须为正,也就是右滑,否则不做反应
            guard value.translation.width > 0 else { return }
            
            if value.startLocation.x < 100{
                withAnimation(.closeCard) {
                    viewState = value.translation
                }
            }
            
            if viewState.width > 120 {
                close()
            }
        }
        .onEnded{value in
            if viewState.width > 80 {
                withAnimation(.closeCard.delay(0.3)) {
                    show.toggle()
                    model.showDetail.toggle()
                }
            }else{
                withAnimation(.closeCard) {
                    viewState = .zero
                }
            }
            
        }
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
    
    func close(){
        withAnimation(.closeCard.delay(0.3)) {
            show.toggle()
            model.showDetail.toggle()
        }

        withAnimation(.closeCard) {
            viewState = .zero
        }
        
        isDraggable = false
    }
}

struct CourseView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CourseView(namespace: namespace, show: .constant(true))
            .environmentObject(Model())
    }
}
