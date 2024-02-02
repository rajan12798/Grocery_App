//
//  ContentView.swift
//  E-Store App
//
//  Created by rajan kumar on 26/01/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ShoppingDataModel.startdate)
    var items: [ShoppingDataModel]
    @Query(sort: \cartItem.addTime)
    var cartData: [cartItem]
    @Query(sort: \Favourite.addTime)
    var favouriteData: [Favourite]
    @State private var menOption: String = "Food"
    @State private var onClickOfCart: Bool = false
    @State private var onClickOfFav: Bool = false
    @State private var path:Envobj = Envobj()
    var body: some View {
        NavigationStack(path: $path.navigationPath){
            ZStack{
                VStack(spacing:0){
                    //MARK: - HeaderView
                    HearderView(favouritiesCount: favouriteData.count, cartCount: cartData.count, onClickOfCart: $onClickOfCart, onClickOfFav: $onClickOfFav)
                        .ignoresSafeArea()
                    ScrollView(.vertical,showsIndicators: false){
                        ForEach(items){ item in
                            ForEach(item.categories){data in
                                //MARK: - DropDown View
                                DropDownView(menuOption: getcategories(), selectedOption: data.name)
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack(spacing:10){
                                        ForEach(data.items){ product in
                                            //MARK: - Item View
                                            ItemView(imageURL: product.icon,name: product.name,price: "\(product.price)", like: product.isLike,Item: product)
                                        }
                                    }.padding()
                                }
                                
                            }
                        }
                    }.padding(.top,-50)
                }
                
            }.modelContext(modelContext)
                .onChange(of: onClickOfCart) {
                    path.navigationPath.append(.cart)
                }
                .onChange(of: onClickOfFav) {
                    path.navigationPath.append(.favourite)
                }
                .navigationDestination(for: Route.self) { route in
                    
                    switch route{
                    case .cart:
                        CartView()
                    case .favourite:
                        Favourities()
                    }
                }
        }
        .onAppear(){
            if items.count == 0{
                do{
                    let data  = try JSONDecoder().decode(ShoppingDataModel.self, from: shoppingData!)
                    modelContext.insert(data)
                    print(data.categories[0].name)
                    
                }catch{
                    
                }

            }else{
              
            }
            
        }
    }
    
    func getcategories()-> [String]{
        items[0].categories.map({$0.name})
    }
}

#Preview {
    HomeView()
        .modelContainer(for: ShoppingDataModel.self, inMemory: true)
}


struct Envobj{
    var navigationPath: [Route] = []
}


enum Route: Hashable {
    case cart
    case favourite
}
