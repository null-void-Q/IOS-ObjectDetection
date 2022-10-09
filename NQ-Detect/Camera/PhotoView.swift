//  NQ Detect
//
//  Created by NULL on 10/9/22.
//

import SwiftUI
import Photos

struct PhotoView: View {
    @Binding  var image: Image?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Group {
            if let image = image {
                VStack{
                    image
                        .resizable()
                        .scaledToFit()
                    
                    Text("Image Saved to your Photo Library.")
                        .font(.title2)
                        .foregroundColor(Color.white)
                    
                    Button(action:{dismiss()} , label: {
                        Image(systemName: "arrow.backward")
                    }).padding(25)
                        .foregroundColor(.pink)
                        .background(Color.black)
                        .cornerRadius(20).frame(width: 350)
                }
            } else {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.pink)
        .navigationTitle("Photo")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
}
