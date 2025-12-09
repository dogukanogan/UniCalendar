
import SwiftUI
import SwiftData

struct AddLessonView: View {
    // database access and close window
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    //form spaces variables
    @State private var name = ""
    @State private var classroom = ""
    @State private var selectedDay = 1
    @State private var startTime = Date()
    @State private var endTime = Date().addingTimeInterval(3600)
    @State private var notes = ""
    
    // change numbers to days
    let days = ["Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi", "Pazar"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Ders bilgileri")) {
                    TextField("Ders Adı (ex: Matematik)", text: $name)
                    TextField("Derslik (ex: MA02)", text: $classroom)
                }
                
                Section(header: Text("Zamanlama")) {
                    Picker("Gün", selection: $selectedDay) {
                        ForEach(1...7, id: \.self) { index in
                            Text(days[index - 1]).tag(index)
                        }
                    }
                    
                    DatePicker("Başlangıç", selection: $startTime, displayedComponents: .hourAndMinute)
                    DatePicker("Bitiş", selection: $endTime, displayedComponents: .hourAndMinute)
                }
                
                Section(header: Text("Notlar")) {
                    TextField("Ek notlar...", text: $notes, axis: .vertical)
                        .lineLimit(3...5)
                }
            }
            .navigationTitle("Yeni ders ekle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // cancel button
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") {
                        dismiss()
                    }
                }
                
                // save button
                ToolbarItem(placement: .confirmationAction) {
                    Button("Kaydet") {
                        saveLesson()
                    }
                    .disabled(name.isEmpty) // if name empty, cannot print
                }
            }
        }
    }
            
            
    private func saveLesson() {
        let newLesson = Lesson(
            name: name,
            classroom: classroom,
            dayOfWeek: selectedDay,
            startTime: startTime,
            endTime: endTime,
            notes: notes
        )
            
    modelContext.insert(newLesson)
    dismiss()
                
    }
}
        
        
#Preview {
    AddLessonView()
}
