//
//  BasicDetails.swift
//  Explore The LocalWay
//
//  Created by sangamesh on 30/03/24.
//

import SwiftUI

struct BasicDetails: View {
    
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var country: String = ""
    
    var body: some View {
            NavigationView {
                VStack(spacing: 28) {
                    InfoText().padding(.top, 44)
                    
                    VStack(alignment: .leading, spacing: 11) {
                        Text("User Name")
                            .font(.system(size: 13, weight: .light))
                            .foregroundColor(.secondary)
                            .frame(height: 15, alignment: .leading)
                        
                        TextField("", text: $login)
                            .font(.system(size: 17, weight: .thin))
                            .foregroundColor(.primary)
                            .frame(height: 44)
                            .padding(.horizontal, 12)
                            .background(Color.white)
                            .cornerRadius(4.0)
                    }
                    
                    VStack(alignment: .leading, spacing: 11) {
                        Text("Password")
                            .font(.system(size: 13, weight: .light))
                            .foregroundColor(.secondary)
                            .frame(height: 15, alignment: .leading)
                        
                        SecureField("", text: $password)
                            .font(.system(size: 17, weight: .thin))
                            .foregroundColor(.primary)
                            .frame(height: 44)
                            .padding(.horizontal, 12)
                            .background(Color.white)
                            .cornerRadius(4.0)
                    }
                    
                    VStack(alignment: .leading, spacing: 11) {
                        Text("Country")
                            .font(.system(size: 13, weight: .light))
                            .foregroundColor(.secondary)
                            .frame(height: 15, alignment: .leading)
                        
                        TextField("", text: $country)
                            .font(.system(size: 17, weight: .thin))
                            .foregroundColor(.primary)
                            .frame(height: 44)
                            .padding(.horizontal, 12)
                            .background(Color.white)
                            .cornerRadius(4.0)
                    }
                    
                    Spacer()
                }
                .padding()
                .background(.secondary.opacity(0.1))
                .navigationBarTitle("Help with your details", displayMode: .automatic)
            }
        }}

struct InfoText: View {
    var body: some View {
        Text("Enter your login and password")
        
            .font(.system(size: 16, weight: .light))
            .foregroundColor(.primary)
    }
}

#Preview {
    BasicDetails()
}
