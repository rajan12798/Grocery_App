//
//  ItemView.swift
//  E-Store App
//
//  Created by rajan kumar on 26/01/24.
//

import SwiftUI
import SwiftData
struct ItemView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \cartItem.addTime)
    var cartData: [cartItem]
    @Query(sort: \Favourite.addTime)
    var favourite: [Favourite]
    @State var imageURL: String
    @State var name: String
    @State var price: String
    @State var like: Bool = false
    var Item: CategoriesItem
    var body: some View {
        
                VStack(alignment:.leading,spacing: 0){
                    AsyncImage(url: URL(string: Item.icon)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 90,height: 50,alignment: .center)
                    .padding(.top,30)
                    Text(Item.name)
                        .font(.system(size: 12))
                        .padding(.top,5)
                        .frame(width: 100, height: 50)
                    
                    HStack{
                        Text("\u{20B9}\(Item.price.removeZerosFromEnd())")
                            .font(.system(size: 10,weight: .bold))
                            .padding(.top,5)
                        Spacer()
                        Button(action: {
                            addItemToCart()
                        }, label: {
                            Image(systemName:  isItemAddTocart() ? "arrow.right":"plus")
                                .tint(.white)
                                
                        })
                        .disabled(isItemAddTocart())
                        .frame(width: 30,height: 30)
                        .background(isItemAddTocart() ? Color("addCart").opacity(0.5): Color("addCart"))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                       
                    }
                        
                }.overlay(alignment: .topTrailing) {
                    VStack{
                        Button(action: {
                            
                            addRemoveFavourite()
                        
                        }, label: {
                            Image(systemName: Item.isLike ? "heart.fill": "heart")
                                .tint( Item.isLike ? .red :.gray)
                        })
                    }
               

                }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
    }
    
    
    func addItemToCart(){
       
        modelContext.insert(cartItem(item: Item, Qty: 1))
        
       print( cartData.count)

    }
    
    func addRemoveFavourite(){
        Item.isLike = !Item.isLike
        
        if !Item.isLike{
       
            let deleteItem = favourite.filter { $0.item.id == Item.id
            }
            if deleteItem.count == 1{
                withAnimation {
                    modelContext.delete(deleteItem[0])
                }
               
                print( favourite.count)
            }
        }else{
            withAnimation {
                modelContext.insert(Favourite(item: Item))
            }
         
            print( favourite.count)

        }
    }
    
    func isItemAddTocart()-> Bool{
        let item = cartData.filter { $0.Item.id == Item.id
        }
        
        return item.count>0 ? true : false
    }
    
    
}

#Preview {
    ItemView(imageURL:  "https://cdn-icons-png.flaticon.com/128/2405/2405479.png",name:"Carrot" ,price: "00",like: false, Item: CategoriesItem(id: 10, name: "", icon: "https://cdn-icons-png.flaticon.com/128/2405/2405479.png", price: 0))
}
