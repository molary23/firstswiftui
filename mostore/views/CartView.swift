//
//  CartView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-20.
//

import SwiftUI

func updateQty(action: String, count: Int) -> Int {
    var qty = count
    if action == "plus" {
        if qty < 10 {
            qty += 1
        }
    } else if action == "minus" {
        if qty > 0 {
            qty -= 1
        }
    }

    return qty
}

struct CartView: View {
    @State var carts = [CartData]()
    @State var isCartEmpty: Bool = false
    @State var quantity: Int = 0

    var body: some View {
        NavigationStack {
            ZStack {
                if isCartEmpty && carts.isEmpty {
                    NoItemLayout
                }
                ScrollView {
                    VStack(spacing: 20, content: {
                        ForEach(carts, id: \.self) { item in
                            CartItem(cart: item, carts: $carts, isCartEmpty: $isCartEmpty)
                        }
                    })
                    .padding(12)
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                    .onAppear {
                        CartApi().loadData(orderId: "64f2a35e89ece621daa0a330") { carts in
                            self.carts = carts
                        }
                    }
                }.overlay(
                    FloatingButton(action: {
                        //  product.removeAll()
                    }, icon: "chevron.right", fg: Color.white, bg: Color.blue, label: "Proceed to Checkout"))
            }
            .navigationBarTitle(PAGE_TEXT["text"]![11], displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        carts.removeAll()
                        isCartEmpty = true
                    }, label: {
                        Text(PAGE_TEXT["button"]![4])
                            .foregroundColor(Color.red)
                            .fontWeight(.bold)

                    })
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}

struct CartItem: View {
    var cart: CartData
    @Binding var carts: [CartData]
    @Binding var isCartEmpty: Bool
    var body: some View {
       var itemQty = carts.first(where: {$0.product.id == cart.product.id})!.quantity
        HStack(spacing: 8, content: {
            ExtAsyncImage(imageURL: cart.product.image.components(separatedBy: "|")[0], size: 100, shape: RoundedRectangle(cornerRadius: 8))

            VStack {
                HStack(spacing: 8, content: {
                    Text("\(cart.product.name)")
                        .font(.body)
                        .fontWeight(.bold)

                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Button(action: {
                        carts = carts.filter({ $0.product.id != cart.product.id })
                        if carts.isEmpty {
                            isCartEmpty = true
                        }

                    }) {
                        Image(systemName: "trash")
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .font(.body)
                            .foregroundColor(Color.orange)
                            .frame(alignment: .trailing)
                            .clipped()
                    }
                }).frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topLeading)
                HStack {
                    Image(systemName: cart.product.rating > 4 ? "star.fill" : "star")
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .font(.body)
                        .frame(alignment: .leading)
                        .clipped()

                    Text("\(cart.product.rating, specifier: "%.1f")")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.indigo)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxHeight: .greatestFiniteMagnitude, alignment: .leading)

                HStack {
                    HStack {
                        Button("-") {
                            //  getQty(quantity: cart.quantity, opt: "-")
                          //  var item = carts.first(where: {$0.product.id == cart.product.id})
                            itemQty -= 1
                        }
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(Color.red)
                        .fontWeight(.bold)

                        Text("\(itemQty)")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .center)

                        Button("+") {
                            //   getQty(quantity: cart.quantity, opt: "+")
                           // var item = carts.first(where: {$0.product.id == cart.product.id})
                            itemQty += 1
                        }
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(Color.blue)
                        .fontWeight(.bold)
                    }
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                    Text("$\(cart.product.price, specifier: "%.2f")")
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                }.frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .bottomLeading)
            }
            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .leading)

        })
        .padding(8)
        .background(Color("off-white"))
        .cornerRadius(8)
    }

    /*   func getQty(quantity: Int, opt: String) -> Void{
         qty = quantity
         if(opt == "+"){
             qty = quantity + 1
         }else if(opt == "-"){
             qty = quantity - 1
         }
     }*/
}

/*
 struct ExtQuantityView: View {
     var cart: CartData
     var qty: Int
     var carts: [CartData]
     var qt: Int = carts.first(where: {$0.product.id == cart.product.id})!.quantity
     var body: some View {
         HStack {
             Button("-") {
                 //   self.allProductData[i].qty = updateQty(action: "minus", count: self.allProductData[i].qty)
               //  cart.quantity - 1
             }
             .padding(.vertical, 4)
             .frame(maxWidth: .infinity)
             .background(Color.white)
             .foregroundColor(Color.red)
             .fontWeight(.bold)

             Text("\(qt)")
                 .font(.headline)
                 .fontWeight(.semibold)
                 .frame(maxWidth: .infinity, alignment: .center)

             Button("+") {
                 print(456)
             }
             .padding(.vertical, 4)
             .frame(maxWidth: .infinity)
             .background(Color.white)
             .foregroundColor(Color.blue)
             .fontWeight(.bold)
         }
         .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
     }
 }
 */
