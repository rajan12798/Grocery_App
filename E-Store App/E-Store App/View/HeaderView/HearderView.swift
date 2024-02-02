//
//  HearderView.swift
//  E-Store App
//
//  Created by rajan kumar on 26/01/24.
//

import SwiftUI

struct HearderView: View {
    var favouritiesCount = 0
    var cartCount = 0
    @Binding var onClickOfCart:Bool
    @Binding var onClickOfFav:Bool
    var body: some View {
        VStack{
            HStack{
                //MARK: - Menu Button
                Button(action: {
                    
                }, label: {
                    Image("menu")
                        .resizable()
                        .frame(width: 20,height: 20)
                })
                //MARK: - Title
                Text("My Store")
                    .font(.system(size: 20,weight: .bold))
                    .padding(.leading,15)
               
                Spacer()
                Group{
                    //MARK: - Favourite
                    Button(action: {
                        onClickOfFav.toggle()
                    }, label: {
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 20,height: 20)
                            .tint(.black)
                    })
                    .overlay(HStack(alignment: .top) {
                        if favouritiesCount > 0{
                            Image(systemName: "\(favouritiesCount)").foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                        
                            .frame(maxHeight: .infinity)
                            .symbolVariant(.fill)
                            .symbolVariant(.circle)
                            .allowsHitTesting(false)
                            .offset(x: 15, y: -12)
                        }
                    }
                    )
                    //MARK: - Cart
                    Button(action: {
                        onClickOfCart.toggle()
                    }, label: {
                        Image(systemName: "cart")
                            .resizable()
                            .frame(width: 20,height: 20)
                            .tint(.black)
                            
                    })
                    .padding(.leading,15)
                    .overlay(HStack(alignment: .top) {
                        if cartCount > 0{
                            Image(systemName: "\(cartCount)").foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                            
                                .frame(maxHeight: .infinity)
                                .symbolVariant(.fill)
                                .symbolVariant(.circle)
                                .allowsHitTesting(false)
                                .offset(x: 15, y: -15)
                        }
                    }
                    )
                    
                }
            }.padding(.top,50)
        }
        .padding([.leading,.trailing])
        .frame(height: 150)
        .background(LinearGradient(colors: [.yellow,.orange.opacity(0.9)], startPoint: .bottom, endPoint: .top))
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 30, height: 30)))
    }
}

#Preview {
    HearderView(onClickOfCart: .constant(false), onClickOfFav: .constant(false))
}
