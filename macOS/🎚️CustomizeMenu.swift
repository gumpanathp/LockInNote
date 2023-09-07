import SwiftUI

struct 🎚️CustomizeMenu: View {
    @EnvironmentObject var note: 📝NoteModel
    @State private var index: Int = 0
    var body: some View {
        NavigationSplitView {
            List(selection: self.$index) {
                Self.SystemWidgetMenuLink()
                    .tag(0)
                Self.EmptyIconMenuLink()
                    .tag(1)
                Divider()
                Self.WidgetTitleMenuLink()
                    .tag(2)
            }
            .frame(minWidth: 160)
        } detail: {
            EmptyView()
        }
        .modifier(🎚️SaveValues())
    }
}

private extension 🎚️CustomizeMenu {
    private struct SystemWidgetMenuLink: View {
        @EnvironmentObject var note: 📝NoteModel
        var body: some View {
            NavigationLink {
                Form {
                    Section { 🎚AppearanceModePicker() }
                    🎚️SystemWidgetPreview()
                    Section {
                        🎚️FontSizeStepper(value: self.$note.system_fontSize)
                        🎚FontWeightPicker()
                        🎚FontDesignPicker()
                        🎚ItalicToggle()
                        🎚MultilineTextAlignmentPicker()
                        🎚️PaddingStepper()
                        🎚️ContentAlignmentPicker()
                        Divider()
                        switch self.note.system_appearanceMode {
                            case .standard:
                                🎚HierarchicalPicker(value: self.$note.system_hierarchical)
                            case .color:
                                🎚️TextColorPicker()
                                🎚️BackgroundColorPicker()
                                🎚️BackgroundGradientToggle()
                        }
                    }
                    Divider()
                    🎚️DoubleSizeOnLargeWidgetToggle()
                }
                .padding(32)
                .navigationTitle("Customize \"\(self.note.title)\"")
                .navigationSubtitle("Desktop, Notification center, Home screen, StandBy, Lock screen(iPad)")
                .animation(.default, value: self.note.system_appearanceMode)
                .frame(minWidth: 620)
            } label: {
                Label("Widget", systemImage: "app")
            }
        }
    }
    private struct EmptyIconMenuLink: View {
        @EnvironmentObject var note: 📝NoteModel
        var body: some View {
            NavigationLink {
                Form {
                    🎚️EmptyIconPreview()
                    Section {
                        🎚️EmptyTypePicker()
                        if self.note.empty_type == .userText {
                            🎚️EmptyTextField()
                        }
                    }
                    if self.note.empty_type != .nothing {
                        Section { 🎚️EmptyIconSizePicker() }
                    }
                }
                .padding(32)
                .navigationTitle("Customize \"\(self.note.title)\" - Empty icon")
                .navigationSubtitle("No text situation")
                .animation(.default, value: self.note.empty_type)
            } label: {
                Label("Empty icon", systemImage: "square.dotted")
            }
        }
    }
    private struct WidgetTitleMenuLink: View {
        @EnvironmentObject var note: 📝NoteModel
        var body: some View {
            NavigationLink {
                Form {
                    🎚️TitleTextField()
                        .font(.title2)
                        .padding(32)
                }
                .navigationTitle("Customize \"\(self.note.title)\" - Widget title")
            } label: {
                Label("Widget title", systemImage: "tag")
            }
        }
    }
}
