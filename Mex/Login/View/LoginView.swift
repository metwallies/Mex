//
//  ContentView.swift
//  Mex
//
//  Created by islam metwally on 30.04.24.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @StateObject var loginViewVM: LoginViewVM
    @EnvironmentObject var appVM: MexAppViewModel

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Spacer()
                LogoView()
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                Text(LocalizedStringKey("LoginView.Slogan"))
                    .frame(maxWidth: .infinity)
                    .font(.subheadline)
                    .foregroundColor(.coolDark)
                    .tracking(10)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))

                Spacer()
                Spacer()
                Spacer()
                Button {
                    Task {
                        await loginViewVM.onDidTouchDownCTA(app: appVM)
                    }
                } label: {
                    LoginButton()
                }

                Spacer()
            }
            .overlay {
                if loginViewVM.isLoading {
                    LoadingOverlay()
                }
            }
        }
    }

//        private func addItem() {
//            withAnimation {
//                let newItem = Item(context: viewContext)
//                newItem.timestamp = Date()
//
//                do {
//                    try viewContext.save()
//                } catch {
//                    // Replace this implementation with code to handle the error appropriately.
//                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                    let nsError = error as NSError
//                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//                }
//            }
//        }
//
//        private func deleteItems(offsets: IndexSet) {
//            withAnimation {
//                offsets.map { items[$0] }.forEach(viewContext.delete)
//
//                do {
//                    try viewContext.save()
//                } catch {
//                    // Replace this implementation with code to handle the error appropriately.
//                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                    let nsError = error as NSError
//                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//                }
//            }
//        }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewVM: LoginViewVMFactory().loginViewVM()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
