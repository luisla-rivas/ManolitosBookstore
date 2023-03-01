//
//  StateLoginView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 24/2/23.
//  Based on a development by Julio César Fernández Muñoz on 14/11/22.

import SwiftUI

enum Screens {
    case splash
    case welcome
//    case welcomeBack
    case login
    case access
}

struct StateLoginView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appVM:BooksViewModel
    
    @State var splashAnimation = false
    @State var screen:Screens = .splash
    
    @State var showLostPassword = false
    @State var showRegisterNewAccount = false
    
    @State var username = ""
    @State var password = ""
    @State var errorMsg = ""
    @State var forward = true
    
    var transEntrada:AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    var transSalida:AnyTransition = .asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
    
    @State var transicion:AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    var body: some View {
//        ZStack {
//            Color("launchBackgroundColor")
//                .ignoresSafeArea()
            Group {
                switch screen {
                case .splash:
                    splash
                        .transition(.move(edge: .leading))
                case .welcome:
                    welcome
                        .transition(.asymmetric(insertion: .move(edge: forward ? .trailing : .leading ),
                                                removal: .move(edge: .leading)))
                case .login:
                    login
                        .transition(.asymmetric(insertion: .move(edge: .trailing),
                                                removal: .move(edge: forward ? .trailing : .leading )))
                case .access:
                    access
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
            .background { //Necesario para mantener el color de fondo durante las transiciones
                Color("launchBackgroundColor")
                    .ignoresSafeArea()
            }
            .animation(.default, value: screen)
//        }
    }
    
    var splash: some View {
        ZStack {
            Color("launchBackgroundColor")
            Image("classicHeroe512")
            Text("Trantor Bookstore")
                .font(.custom("Futura", size: 32))
                .padding(.top, 225)
                .offset(y: splashAnimation ? 0.0 : 500)
                .ignoresSafeArea()
                .onAppear {
                    splashAnimation = true
                    appVM.tryAutomaticLogin()
                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                        if appVM.currentUser != nil {
                            screen = .access
                        } else {
                            screen = .welcome
                        }
                    }
                }
                .animation(.easeOut(duration: 1), value: splashAnimation)
        }
    }
    
    var welcome: some View {
        ZStack {
            Color("launchBackgroundColor")
            VStack(alignment: .center,spacing: 0) {
                VStack(spacing: 10) {
                    Image("classicHeroe512")
                    Text("Welcome to Trantor Bookstore!").font(.title)
                        .multilineTextAlignment(.center)
                    Text("You will need an account to place orders, save book's ratings or your reading list and much more!")
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                    
                }.padding([.horizontal],40)
                   
                    
                HStack(spacing: 50) {
                    Button {
                        forward = true
                        screen = .access
                    } label: {
                        Text("Just watch!")
                            .multilineTextAlignment(.center)
                    }
                    Button {
                        forward = true
                        screen = .login
                    } label: {
                        Text("Login")
                            .multilineTextAlignment(.center)
                    }
                }.padding()
            }
        }
        .background {
            Color("launchBackgroundColor")
        }
        .ignoresSafeArea()
        .alert("Network alert!",
               isPresented: $appVM.showError) {
            Button {
                appVM.errorMsg = ""
            } label: {
                Text("OK")
            }
        } message: {
            Text(appVM.errorMsg)
        }
    }
    
    var login: some View {
        ZStack {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                GroupBox {
                    Text("User")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Image(systemName: "person.fill").font(.headline)
                        TextField(" Write your email", text: $username)
                            .textContentType(.username)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                    }
//                    Text("Password")
//                        .font(.headline)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    HStack {
//                        Image(systemName: "lock.fill").font(.headline)
//                        SecureField("Write your password", text: $password)
//                            .textContentType(.password)
//                    }
                    
                    HStack {
                        Button {
                            //                        transicion = transSalida
                            forward = false
                            screen = .welcome
                        } label: {
                            Text("Cancel").foregroundColor(.gray).frame(width: 80)
                        }
                        .buttonStyle(.bordered)
                        Button {
                            if username == "paco" && password == "12345" {
                                password = ""
                                //                            transicion = transEntrada
                                screen = .access
                            } else {
                                errorMsg = "User/password not found. Try again!"
                            }
                        } label: {
                            Text("Login").frame(width: 80)
                        }
                        .buttonStyle(.borderedProminent)
                        
                    }.padding(.top)
                    
                    HStack {
                        Button {
                            showLostPassword.toggle()
                        } label: {
                            Text("Forgot password?")
                        }
                        Spacer()
                        Button {
                            showRegisterNewAccount.toggle()
                        } label: {
                            Text("Register new account")
                        }

                    }.padding(.top)
                    
             
                    
                } label: {
                    Text("Access to Trantor Bookstore")
                        .bold()
                        .padding(.bottom)
                }
                .textFieldStyle(.roundedBorder)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding()

            
            if !errorMsg.isEmpty {
                Text(errorMsg)
                    .bold()
                    .foregroundColor(.red)
                    .padding(.top, 400)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                                errorMsg = ""
                        }
                    }

                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.red)
                    }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showLostPassword) {
            lostPassword
        }
        .sheet(isPresented: $showRegisterNewAccount) {
            registerAccount
        }
        .alert("Network alert!",
               isPresented: $appVM.showError) {
            Button {
                appVM.errorMsg = ""
            } label: {
                Text("OK")
            }
        } message: {
            Text(appVM.errorMsg)
        }
    }
    
    var lostPassword: some View {
        VStack {
             HStack {
                Spacer()
                Button() {
                    showLostPassword.toggle()
                } label: {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        Text("Done")
                    } else {
                        Circle()
                            .fill(Color(uiColor: .lightGray))
                            .frame(width: 20)
                            .overlay(alignment: .center) {
                                Text("X")
                            }
                    }
                }
            }
            
            Spacer()
            Text("Forgot Password")
                .font(.largeTitle)
                .bold()
            GroupBox {
                Text("User")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Insert user email", text: $username)
                    .textContentType(.username)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                Button {
                    showLostPassword.toggle()
                } label: {
                    Text("Recover password")
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
            .textFieldStyle(.roundedBorder)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
        .ignoresSafeArea()
        .background {
            Color("launchBackgroundColor")
        }
    }
    
    
    var registerAccount: some View {
        VStack {
             HStack {
                Spacer()
                Button() {
                    showRegisterNewAccount.toggle()
                } label: {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        Text("Done")
                    } else {
                        Circle()
                            .fill(Color(uiColor: .lightGray))
                            .frame(width: 20)
                            .overlay(alignment: .center) {
                                Text("X")
                            }
                    }
                }
            }
            
            Spacer()
            RegisterAccountView()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
        .ignoresSafeArea()
        .background {
            Color("launchBackgroundColor")
        }
    }
    
    
    var access: some View {
        ZStack {
            Color("launchBackgroundColor").ignoresSafeArea()
            if UIDevice.current.userInterfaceIdiom == .pad {
                ContentView() // ContentPadView()
            } else {
                ContentView()
            }
        }
        
        
        
//        ZStack {
//            Color("launchBackgroundColor")
//            VStack {
//                Text("Acceso al sistema concedido")
//                Button {
//                    transicion = transSalida
//                    screen = .login
//                } label: {
//                    Text("Salir")
//                }
//                .buttonStyle(.borderedProminent)
//            }
//        }
//        .ignoresSafeArea()
    }
}

struct StateLoginView_Previews: PreviewProvider {
    static var previews: some View {
        StateLoginView()
    }
}

struct RegisterAccountView: View {
    var body: some View {
        VStack {
            Text("Register new account")
                .font(.largeTitle)
                .bold()
//            GroupBox {
//                Text("Name")
//                    .font(.headline)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                TextField("Insert your first and last name", text: $username)
//                    .textContentType(.username)
//                    .autocorrectionDisabled()
//                    .textInputAutocapitalization(.never)
//                    .keyboardType(.default)
//                Text("Email")
//                    .font(.headline)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                TextField("Insert your email", text: $username)
//                    .textContentType(.username)
//                    .autocorrectionDisabled()
//                    .textInputAutocapitalization(.never)
//                    .keyboardType(.emailAddress)
//                Text("Address")
//                    .font(.headline)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                TextField("Insert your address", text: $username)
//                    .textContentType(.username)
//                    .autocorrectionDisabled()
//                    .textInputAutocapitalization(.never)
//                    .keyboardType(.emailAddress)
//                Button {
//                    
//                    showRegisterNewAccount.toggle()
//                } label: {
//                    Text("Register Account")
//                }
//                .buttonStyle(.borderedProminent)
//                .padding(.top)
//            }
        }
        .textFieldStyle(.roundedBorder)
    }
}
