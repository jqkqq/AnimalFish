//
//  SeaFeatureDetailView.swift
//  AnimalSeaCreatures


import SwiftUI
import KingfisherSwiftUI
import Combine

struct FishDetailView: View {
    
    @State var selectAlert = false
    @ObservedObject var viewModel: FishDetailViewModel
    
    init(seaFeature: Value, hide: Bool) {
        self.viewModel = FishDetailViewModel(seaFeature: seaFeature)
        self.viewModel.hide = hide
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("\(viewModel.fish.name.nameTWzh)")
                    .font(.system(size: 25))
                    .padding()
                    .background(Color.white)
                    .rotationEffect(Angle(degrees: -10))
                KFImage(URL(string: viewModel.fish.imageURI))
                    .resizable()
                    .placeholder({
//                        ActivityIndicator()
//                        .frame(width: 30, height: 30, alignment: .center)
//                        .foregroundColor(Color.gray)
                        ProgressView("")
                            .frame(width: 30, height: 30, alignment: .center)
                            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    })
                    .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.width * 0.5, alignment: .center)

                Group {
                    Text("北半球")
                        .font(.system(size: 25))
                        .padding()
                    HStack {
                        ForEach(1..<5) { number in
                            MonthTextView(color: self.viewModel.checkNorthMonth(number), month: number)
                        }
                    }
                    HStack {
                        ForEach(5..<9) { number in
                            MonthTextView(color: self.viewModel.checkNorthMonth(number), month: number)
                        }
                    }
                    HStack {
                        ForEach(9..<13) { number in
                            MonthTextView(color: self.viewModel.checkNorthMonth(number), month: number)
                        }
                    }
                }
                Group {
                    Text("南半球")
                    .font(.system(size: 25))
                    .padding()
                    HStack {
                        ForEach(1..<5) { number in
                            MonthTextView(color: self.viewModel.checkSourthMonth(number), month: number)
                        }
                    }
                    HStack {
                        ForEach(5..<9) { number in
                            MonthTextView(color: self.viewModel.checkSourthMonth(number), month: number)
                        }
                    }
                    HStack {
                        ForEach(9..<13) { number in
                            MonthTextView(color: self.viewModel.checkSourthMonth(number), month: number)
                        }
                    }
                }
                
                Group {
                    Text("出現時間")
                        .font(.system(size: 25))
                        .padding()
                    HStack {
                        ForEach(0..<13) { number in
                            Text("\(number)")
                                .font(.system(size: 18))
                                .frame(minWidth: 0,maxWidth:
                                    .infinity, alignment: .center)
                                .background(self.viewModel.checkTime(number))
                                .border(Color.gray)
                        }
                    }.padding(.bottom, 10)
                    
                    HStack {
                        ForEach(13..<24) { number in
                            Text("\(number)")
                                .font(.system(size: 18))
                                .frame(minWidth: 0,maxWidth:
                                    .infinity, alignment: .center)
                                .background(self.viewModel.checkTime(number))
                                .border(Color.gray)
                        }
                    }
                }
                
                Group {
                    HStack {
                        Text("棲息地：")
                        Text("\(viewModel.fish.availability.location?.changeToChinese() ?? "")")
                        Spacer()
                    }
                    
                    HStack {
                        Text("陰影：")
                        Text("\(viewModel.fish.shadow)")
                        Spacer()
                    }
                    HStack {
                        Text("稀有度：")
                        Text("\(viewModel.fish.availability.rarity?.changeToChinese() ?? "")")
                        Spacer()
                    }

                    HStack {
                        Text("價錢：")
                        Text("\(viewModel.fish.price) 元")
                        Spacer()
                    }
                }
                .font(.system(size: 25))
                .padding([.top], 30)
                .padding(.leading, 10)

            }
            .padding([.top, .bottom], 30)
        }
        .background(Color.init(red: 187/255, green: 1, blue: 1))
        .navigationBarItems(trailing:
            Button(action: {
//                self.selectAlert = true
                self.viewModel.isLove ? self.viewModel.deleteLove(): self.viewModel.addLove()

//                print(RealmManager.shared.fetchAll())
            }) {
                Text(viewModel.isLove ? "❤️": "🤍")
            }
            .isHidden(viewModel.hide)
            .buttonStyle(PlainButtonStyle())
            .alert(isPresented: $selectAlert, content: {
                Alert(title: Text("提示"), message: Text("是否\(viewModel.isLove ? "刪除": "加入")我的最愛"), primaryButton: .default(Text("確認"), action: {
//                    self.viewModel.isLove ? self.viewModel.deleteLove(): self.viewModel.addLove()
//                    print(RealmManager.shared.fetchAll())
                }), secondaryButton: .cancel(Text("取消")))
            })
        ).onAppear(perform: {
            self.viewModel.checkIsLove()
        })
    }
}






