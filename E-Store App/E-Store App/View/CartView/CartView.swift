//
//  CartView.swift
//  E-Store App
//
//  Created by rajan kumar on 27/01/24.
//

import SwiftUI
import SwiftData

struct CartView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \cartItem.addTime)
    var cartData: [cartItem]
    var discount: Double = 20.0
    var body: some View {
        ZStack{
            ZStack{
                ScrollView{
                    VStack{
                        ForEach(cartData){ data in
                            cartCell(cart: data)
                        }
                    }
                    .padding()
                    
                }
            }
            
            ZStack{
                VStack{
                    Spacer()
                    TotalView()
                }
            }
        }
        .navigationTitle("Cart")
        .tint(.black)
            }
    
    @ViewBuilder func cartCell(cart: cartItem)-> some View{
        HStack{
            
            VStack{
                AsyncImage(url: URL(string: cart.Item.icon)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50,height: 50,alignment: .center)
            }.padding()
            
            VStack {
                HStack{
                    Text(cart.Item.name)
                        .font(.system(size: 12,weight: .bold))
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    
                    Button(action: {
                        cart.qty = cart.qty - 1
                        if cart.qty == 0{
                            removeFromCart(remove: cart)
                        }
                    }, label: {
                        Image(systemName: "minus")
                            .tint(.white)
                        
                    })
                    .frame(width: 30,height: 30)
                    .background(Color("addCart"))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    Text("\(cart.qty)")
                        .font(.system(size: 15,weight: .bold))
                    Button(action: {
                        cart.qty = cart.qty + 1
                    }, label: {
                        Image(systemName: "plus")
                            .tint(.white)
                        
                    })
                    
                    .frame(width: 30,height: 30)
                    .background(Color("addCart"))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                
                HStack{
                    Spacer()
                    
                    Text("\u{20B9} \((Double(cart.qty)*cart.Item.price).removeZerosFromEnd())")
                        .font(.system(size: 12))
                }.padding()
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 5)
    }
    
    //MARK: - SubTotal View
    
    @ViewBuilder func TotalView()-> some View{
        
        VStack {
            VStack{
                HStack{
                    Text("Sub Total")
                        .font(.system(size: 15))
                    Spacer()
                    Text("\u{20B9} \(total().removeZerosFromEnd())")
                        .font(.system(size: 12))
                }
                .padding([.leading,.trailing,.top])
                
                HStack{
                    Text("Discount")
                        .font(.system(size: 15))
                    Spacer()
                    Text("-\u{20B9} \(discount.removeZerosFromEnd())")
                        .font(.system(size: 12))
                }
                .padding([.leading,.trailing,.top])
                Rectangle()
                    .fill(.gray)
                    .frame(height: 1)
                
                
                HStack{
                    Text("Total")
                        .font(.system(size: 15,weight: .bold))
                    Spacer()
                    Text("\u{20B9} \((total() - discount).removeZerosFromEnd())")
                        .font(.system(size: 12,weight: .bold))
                }
                .padding()

            }
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding([.leading,.trailing,.top])
            Button(action: {
                
            }, label: {
                HStack{
                    Spacer()
                    Text("Checkout")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white)
                        .padding()
                    Spacer()
                }
            })
            .background(Color("addCart"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
            
        }.background(.white)
    }
    
    //MARK: - Remove from cart
    
    func removeFromCart(remove: cartItem){
        let deleteItem = cartData.filter { $0.Item.id == remove.Item.id
        }
        if cartData.count == 1{
            do {
                try modelContext.delete(model: cartItem.self)
            } catch {
                print("Failed to delete all Cart.")
            }
        }
       else if deleteItem.count > 0{
            withAnimation {
                modelContext.delete(deleteItem[0])
            }
        }
    }
    
    //MARK: - Calculate Total
    
    func total()-> Double{
        var total = 0.0
         let _ = cartData.map { cart in
             total = total + (Double(cart.qty)*(cart.Item.price))
        }
        return total
    }
}

#Preview {
    CartView()
}
