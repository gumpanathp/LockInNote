import SwiftUI

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationStack {
            TextField("Input text",
                      text: self.$📱.widgetsModel.rectangular.text)
            .onSubmit {
                self.📱.saveAndReloadWidgetAndUpdateWCContext()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}