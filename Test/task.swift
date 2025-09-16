import SwiftUI

// MARK: - Model
struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isDone: Bool = false
}

// MARK: - ViewModel
class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
    func addTask(title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        tasks.append(Task(title: trimmed))
    }
    
    func toggleTask(_ task: Task) {
        if let i = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[i].isDone.toggle()
            
            // Auto-remove if finished
            if tasks[i].isDone {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.tasks.remove(at: i)
                }
            }
        }
    }

    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    /// Helper for previews
    static func preview() -> TaskViewModel {
        let vm = TaskViewModel()
        vm.tasks = [
            Task(title: "Do ur homework"),
        ]
        return vm
    }
}

// MARK: - View
struct TodoListView: View {
    @StateObject private var viewModel: TaskViewModel
    @State private var newTaskTitle = ""
    
    init(viewModel: TaskViewModel = TaskViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.indigo.opacity(0.7)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                // Input bar
                HStack {
                    TextField("Add a new task...", text: $newTaskTitle)
                        .padding(10)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                    
                    Button(action: {
                        viewModel.addTask(title: newTaskTitle)
                        newTaskTitle = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .shadow(radius: 2)
                    }
                    .disabled(newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Task list
                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isDone ? .blue : .gray)
                                .onTapGesture {
                                    viewModel.toggleTask(task)
                                }
                            
                            Text(task.title)
                                .font(.body)
                                .strikethrough(task.isDone, color: .black)
                                .foregroundColor(task.isDone ? .gray : .primary)
                        }
                        .padding(.vertical, 5)
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
                .scrollContentBackground(.hidden) // makes List transparent
                .background(Color.clear)
            }
            .navigationTitle("📝 To-Do List")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        TodoListView(viewModel: TaskViewModel.preview())
    }
}
