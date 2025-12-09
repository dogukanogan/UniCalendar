
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Lesson.dayOfWeek) private var lessons: [Lesson]
    
    @State private var showingAddLesson = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(lessons) { lesson in
                    HStack {
                        // süs diye mavi çizgi
                        Rectangle()
                            .fill(.blue)
                            .frame(width: 4)
                            .cornerRadius(2)
                        
                        VStack(alignment: .leading) {
                            Text(lesson.name)
                                .font(.headline)
                                .bold()
                            
                            HStack {
                                Text("Gün: \(lesson.dayOfWeek)")
                                Text("•")
                                Text(formatTime(lesson.startTime))
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Ders Programım")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddLesson = true }) {
                        Label("Ekle", systemImage: "plus")
                    }
                }
            }
            // when showingAddLesson true, open up the page
            .sheet(isPresented: $showingAddLesson) {
                AddLessonView()
            }
        }
    }
    
    // slide left to delete
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(lessons[index])
            }
        }
    }
    
    //
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Lesson.self, inMemory: true)
}
