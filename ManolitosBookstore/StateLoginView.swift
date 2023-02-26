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
    case login
    case access
}

struct StateLoginView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appVM:BooksViewModel
    
    @State var splashAnimation = false
    @State var screen:Screens = .splash
    
    @State var showLostPassword = false
    
    @State var username = ""
    @State var password = ""
    @State var errorMsg = ""
    
    var transEntrada:AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    var transSalida:AnyTransition = .asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
    
    @State var transicion:AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    var body: some View {
//        ZStack {
//            Color("launchBackgroundColor")
//                    .ignoresSafeArea()
            Group {
                switch screen {
                case .splash:
                    splash
                        .transition(.move(edge: .leading))
                case .welcome:
                    welcome
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case .login:
                    login
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case .access:
                    access
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
            //        .background {
            //            Color("launchBackgroundColor")
            //                .ignoresSafeArea()
            //        }
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
        }
        .ignoresSafeArea()
        .onAppear {
            splashAnimation = true
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                if let user = UserDefaults.standard.string(forKey: .kUserMail) {
                    appVM.userMail = user
                    screen = .access
                } else {
                    screen = .welcome
                }
            }
        }
        .animation(.easeOut(duration: 1), value: splashAnimation)
    }
    
    var welcome: some View {
        ZStack {
            Color("launchBackgroundColor")
            VStack(alignment: .center,spacing: 0) {
                VStack(spacing: 10) {
                    Image("classicHeroe512")
                    Text("Welcome to Trantor Bookstore!").font(.title)
                        .multilineTextAlignment(.center)
                    Text("You will need an account to place orders, and ... anda much more!")
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                    
                }.padding([.horizontal],40)
                   
                    
                HStack(spacing: 50) {
                    Button {
                        screen = .access
                    } label: {
                        Text("Just watch!")
                            .multilineTextAlignment(.center)
                    }
//                    .buttonStyle(.borderedProminent)
//                    Spacer()
                    Button {
                        screen = .login
                    } label: {
                        Text("Login")
                            .multilineTextAlignment(.center)
                    }
                    
//                    .buttonStyle(.borderedProminent)
                }.padding()
            }
        }
        .ignoresSafeArea()
    }
    
    var login: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .bold()
            GroupBox {
                Text("Usuario")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Introduzca el usuario", text: $username)
                    .textContentType(.username)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                Text("Password")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                SecureField("Introduzca el password", text: $password)
                    .textContentType(.password)
                HStack {
                    Button {
                        transicion = transSalida
                        screen = .welcome
                    } label: {
                        Text("Cancel").foregroundColor(.gray)
                    }
                    .buttonStyle(.bordered)
                    .padding(.top)
                    Button {
                        if username == "paco" && password == "12345" {
                            password = ""
                            transicion = transEntrada
                            screen = .access
                        } else {
                            errorMsg = "El usuario/clave no existe."
                        }
                    } label: {
                        Text("Acceso")
                    }
                    .buttonStyle(.borderedProminent)
                .padding(.top)
                    
 
                }
                Button {
                    showLostPassword.toggle()
                } label: {
                    Text("¿Has perdido la clave?")
                }
            } label: {
                Text("Acceso al sistema")
                    .bold()
                    .padding(.bottom)
            }
            .textFieldStyle(.roundedBorder)
            
            if !errorMsg.isEmpty {
                Text(errorMsg)
                    .foregroundColor(.white)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.red)
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
        .ignoresSafeArea()
        .sheet(isPresented: $showLostPassword) {
            lostPassword
        }
    }
    
    var lostPassword: some View {
        VStack {
            Text("Lost Password")
                .font(.largeTitle)
                .bold()
            GroupBox {
                Text("Usuario a recuperar")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Introduzca el usuario", text: $username)
                    .textContentType(.username)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                Button {
                    showLostPassword.toggle()
                } label: {
                    Text("Recuperar clave")
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
            .textFieldStyle(.roundedBorder)
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
            ContentView()
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
