//  NQ Detect
//
//  Created by NULL on 10/9/22.
//

import SwiftUI

struct CameraView: View {
    @StateObject private var model = DataModel()
 
    private static let barHeightFactor = 0.10
    
    @State private var isImageTaken = false
    
    var body: some View {
        
        NavigationView {
            GeometryReader { geometry in
                ViewfinderView(image:  $model.viewfinderImage )
                    .overlay(alignment: .top) {
                        ZStack{
                            Image("logo32").frame(maxHeight:.zero,alignment: .center)
                            Color.black
                                .opacity(0.7)
                                .frame(height: geometry.size.height * Self.barHeightFactor)
                        }
                    }
                    .overlay(alignment: .bottom) {
                        buttonsView()
                            .frame(height: geometry.size.height * (Self.barHeightFactor+0.05))
                            .background(.black.opacity(0.7))
                    }
                    .overlay(alignment: .center)  {
                        Color.clear
                            .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                            .accessibilityElement()
                            .accessibilityLabel("View Finder")
                            .accessibilityAddTraits([.isImage])
                    }
                    .background(.black)
            }
            .task {
                await model.camera.start()
            }
            .navigationTitle("Camera")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .statusBar(hidden: true)
            .sheet(isPresented: self.$isImageTaken) {
                PhotoView(image: $model.thumbnailImage).onAppear(){
                    model.camera.isPreviewPaused = true
                }.onDisappear(){
                    model.camera.isPreviewPaused = false
                    model.thumbnailImage = nil
                    
                }
            }.onAppear(){
                UIApplication.shared.isIdleTimerDisabled = true
            }.onDisappear(){
                UIApplication.shared.isIdleTimerDisabled = false
            }
            
        }
    }
    
    private func buttonsView() -> some View {
        HStack() {
           
            Button {
                model.camera.takePhoto()
                self.isImageTaken.toggle()
            } label: {
                Label {
                    Text("Take Photo")
                } icon: {
                    ZStack {
                        Circle()
                            .strokeBorder(.pink, lineWidth: 3)
                            .frame(width: 62, height: 62)
                        Circle()
                            .fill(.white)
                            .frame(width: 50, height: 50)
                    }
                }
            }.frame(maxWidth: .infinity, alignment: .center)
            Button {
                model.camera.switchCaptureDevice()
            } label: {
                Label("Switch Camera", systemImage: "arrow.triangle.2.circlepath")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.pink)
            }.frame(maxWidth: .leastNormalMagnitude, alignment: .trailing)
            
            
        }
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
        .padding()
    }
    
}
