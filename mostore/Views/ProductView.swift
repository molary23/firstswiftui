//
//  MainView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

struct ProductView: View {
    @EnvironmentObject var user: User
    @StateObject private var product = Product()

    @StateObject private var cartManager = CartManager()

    @StateObject var productController = ProductController()

    @State private var gotoDetails: Bool = false
    @State private var toSearch: Bool = false
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: nil),
        GridItem(.flexible(), spacing: 10, alignment: nil),
    ]

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        // UINavigationBar.appearance().backgroundColor = UIColor.green
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20, content: {
                    Button(action: {
                        toSearch = true
                    }, label: {
                        HStack(alignment: .center, spacing: 40, content: {
                            Image(systemName: "magnifyingglass")
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .font(.body)
                                .fontWeight(.bold)
                                .clipped()
                                .frame(maxWidth: 40)

                            Text("\(PAGE_TEXT["input"]![7])")
                                .fontWeight(.thin)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        })

                    })
                    .padding(8)
                    .padding(.horizontal, 40)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .accentColor(Color.gray.opacity(0.7))
                    .background(Color.white)
                    .navigationDestination(isPresented: $toSearch, destination: {
                        SearchView()
                    })

                    VStack(spacing: 20, content: {
                        VStack {
                            Text(PAGE_TEXT["text"]![16])
                                .font(.title3)
                                .fontWeight(.bold)
                            ScrollView(.horizontal, showsIndicators: false, content: {
                                LazyHStack(spacing: 20, content: {
                                    ForEach(productController.recommendedProducts) { product in
                                        VStack(content: {
                                            ProductLink(name: product.name, price: product.price, image: product.image, size: 150, shape: Circle(), action: { productController.viewProductDetails(content: product, section: "recommended") })
                                                .navigationDestination(isPresented: $productController.recommendedDetails) {
                                                    DetailsView(productDetails: productController.product)
                                                }
                                        })
                                    }

                                })
                            })
                        }

                        VStack {
                            Text(PAGE_TEXT["text"]![9])
                                .font(.title3)
                                .fontWeight(.bold)

                            ScrollView(.horizontal, showsIndicators: false, content: {
                                LazyHStack(spacing: 20, content: {
                                    ForEach(productController.bestProducts) { product in

                                        ProductLink(name: product.name, price: product.price, image: product.image, size: 350, shape: RoundedRectangle(cornerRadius: 8), action: { productController.viewProductDetails(content: product, section: "best") })
                                            .navigationDestination(isPresented: $productController.bestDetails) {
                                                DetailsView(productDetails: productController.product)
                                            }
                                    }

                                })

                            })
                        }

                        VStack {
                            Text(PAGE_TEXT["text"]![10])
                                .font(.title3)
                                .fontWeight(.bold)
                            LazyVGrid(columns: columns, alignment: .center, spacing: 20, pinnedViews: [], content: {
                                ForEach(productController.dealProducts) { product in
                                    HStack(spacing: 30, content: {
                                        ProductLink(name: product.name, price: product.price, image: product.image, size: 150, shape: RoundedRectangle(cornerRadius: 8), action: { productController.viewProductDetails(content: product, section: "deal") })
                                            .navigationDestination(isPresented: $productController.dealDetails) {
                                                DetailsView(productDetails: productController.product)
                                            }
                                    })
                                }
                            })
                        }
                        .padding()

                    })
                    .padding()

                })
            }

            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
            .background(
                Color.gray.opacity(0.1)
                    .ignoresSafeArea()
            )

            .navigationBarTitle(PAGE_TEXT["title"]![6], displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination:
                        CartView(), label: {
                        
                        CartButton(numberOfProduct: cartManager.products.count)

                        })
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView(), label: {
                        Image(systemName: "gear")
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .font(.body)
                            .fontWeight(.semibold)
                            .frame(alignment: .trailing)
                            .clipped()

                    })
                }
            }
        }
        .environmentObject(cartManager)
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
