//
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/15/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Text("Hello world")
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
