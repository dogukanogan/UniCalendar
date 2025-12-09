
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Lesson.dayOfWeek) private var lessons: [Lesson]
    
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
                    Button(action: addTestLesson) {
                        Label("Ekle", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    // for test
    private func addTestLesson() {
        let ornekDersler = ["Matematik", "Fizik", "101", "102", "psikoloji"]
        
        let yeniDers = Lesson(
            name: ornekDersler.randomElement()!,
            classroom: "NA02\(Int.random(in: 1...9))",
            dayOfWeek: Int.random(in: 1...5),
            startTime: Date(),
            endTime: Date().addingTimeInterval(3600) // 1 hour later
        )
        
        // save
        modelContext.insert(yeniDers)
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
