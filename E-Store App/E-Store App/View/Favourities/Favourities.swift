//
//  Favourities.swift
//  E-Store App
//
//  Created by rajan kumar on 27/01/24.
//

import SwiftUI
import SwiftData
struct Favourities: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Favourite.addTime)
    var favourite: [Favourite]
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    ForEach(favourite){ data in
                        favouriteCell(data: data)
                    }
                }.padding()
            }
        }
        .navigationTitle("Favouritie")
    }
    //MARK: - favourite cell
    
    @ViewBuilder func favouriteCell(data: Favourite)-> some View{
        HStack{
            
            VStack{
                AsyncImage(url: URL(string: data.item.icon)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50,height: 50,alignment: .center)
            }.padding([.leading,.top,.bottom], 5)
            
            VStack {
                HStack{
                    Text(data.item.name)
                        .font(.system(size: 12,weight: .bold))
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    
                    Button(action: {
                        
                        addRemoveFavourite(add: data)
                    
                    }, label: {
                        Image(systemName: data.item.isLike ? "heart.fill": "heart")
                            .tint( data.item.isLike ? .red :.gray)
                    })
                }
                
                HStack{
                    Text("\u{20B9} \(data.item.price.removeZerosFromEnd())")
                        .font(.system(size: 12))
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus")
                            .tint(.white)
                        
                    })
                    
                    .frame(width: 30,height: 30)
                    .background(Color("addCart"))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                }
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 5)
    }
    
    func addRemoveFavourite(add: Favourite){
        add.item.isLike = !add.item.isLike
        
        if !add.item.isLike{
       
            let deleteItem = favourite.filter { $0.item.id == add.item.id
            }
            if favourite.count == 1{
                withAnimation {
                    do {
                        try modelContext.delete(model: Favourite.self)
                    } catch {
                        print("Failed to delete all Cart.")
                    }
                }
            }else if deleteItem.count > 0{
                withAnimation {
                    modelContext.delete(deleteItem[0])
                }
            }
        }else{

        }
    }
    
}

#Preview {
    Favourities()
}
