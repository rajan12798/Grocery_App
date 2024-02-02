//
//  DropDownView.swift
//  E-Store App
//
//  Created by rajan kumar on 26/01/24.
//

import SwiftUI

struct DropDownView: View {
    @State var menuOption:[String]
    @State var selectedOption: String
    @State var showMenu: Bool = false
    var body: some View {
        VStack {
            Menu {
                ForEach(menuOption, id: \.self) { menu in
                    Button(action: {
                        select(option: menu)
                    }, label: {
                        Text(menu)
                    })
                                   
                               }
            } label: {
                VStack{
                    HStack{
                        Text(selectedOption)
                            .font(.system(size: 15))
                            .foregroundStyle(.black)
                        Spacer()
                        Image("down.arrow")
                            .resizable()
                            .frame(width: 20,height: 20)
                    }
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 1)
                        
                }

        }
        }.padding([.leading,.trailing])
        
    }
    
    func select(option: String){
        self.selectedOption = option
    }
}

#Preview {
    DropDownView(menuOption: ["Food","data"], selectedOption: "")
}
