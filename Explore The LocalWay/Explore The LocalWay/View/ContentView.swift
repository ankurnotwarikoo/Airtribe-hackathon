import Combine
import SwiftUI

struct EmbeddingsResponse: Decodable {
    let object: String
    let data: [EmbeddingData]
    let model: String
    let usage: Usage
    
}

struct Usage: Decodable {
    let total_tokens: Int
}

struct EmbeddingData: Decodable {
    let object: String
    let embedding: [Double]
    let index: Int
}

struct PineConeResponse: Decodable {
    let matches: [Match]
}

struct Match: Decodable {
    let metadata: Metadata
}

struct Metadata: Decodable {
    let test: String
}

struct PineCodePostData: Codable {
    let vector: [Double]
    let topK: Int
    let includeMetadata: Bool
}

struct UpsertData: Codable {
    let vectors: [Vector1]
}

struct Vector1: Codable {
    let id: String
    let values: [Double]
    let metadata: [Metadata1]
}

struct Metadata1: Codable {
    let test: String
}

struct ContentView: View {
    @State var messages = DataSource.messages
    @State var newMessage: String = ""
    @State var content: [String] = [
        "Shopping These Are the Best Places to Go Shopping in Bangalore: 1. Commercial Street One of the most famous markets of Bengaluru, Commercial Street is a paradise for street shopping in Bangalore. It is a one-stop destination for purchasing garments, imitation jewelry, sports goods, and footwear. You can also look for antiques at affordable prices as well as linens for your house. Timings: Though there is no time boundation, the shops generally open by 10:00 AM and get closed by 9:00 PM - 9:30 PM",
        "Chickpet Chickpet is one of the visited markets for shopping in Bangalore. It is one of the oldest commercial districts of the city which is famous for its silk sarees. Chickpet has a formidable history of 400 years, and Bangaloreans swear by the quality and variety of saris and wholesale dress materials in this famous market. It is also known for gold and silver jewelry especially in the Raja market. Head to the nearby Balepet to buy some of the most beautiful bangles and Nagarthapet to have a look at locally made musical instruments. Timings: The market remains open from 9:00 AM in the morning to around 9:00 PM in the night",
        "Jayanagar 4th Block Jayanagar shopping complex is situated opposite the main bus stand in Bengaluru and is a heaven for shoppers. The shopping complex is massive and even confusing for first-timers. Jayanagar is the best place to buy artwork, pottery, and sculptures at affordable rates. An assortment of dining options ensures that once you are done with shopping you can refresh yourself to delectable food items. Shopping Tip: You could indulge in South Indian snacks (Shenoy Stores), chaat and pani puri (Rakesh Kumar), sandwiches (Hari Super Sandwich) and desserts at Cool Point",
        "Brigade Road Located 3 kilometers from City Market, Brigade Road is located in between MG Road and Residency Road. Visitors should walk through the footpaths to explore branded showrooms selling garments, electronics, footwear, and jewelry. Apart from that, drop in any of the numerous garments shops that sell non-branded tops and dresses at an affordable rate. Make sure to visit Blossom's Book House which one of the oldest bookshops in the city and every bibliophile's favourite haunt. Timings: The timing of the market is from 10:00 AM to around 6:00 PM ",
        "Dubai Plaza Dubai Plaza is located on Rest House Road and is a massive shopping complex selling cosmetics, accessories, clothes, and footwear. Dubai Plaza is hub for budget shopping. The basement of Dubai Plaza houses the Tibetan Plaza where you can splurge on electronic gadgets, perfumes, lingerie, quirky scarves, belts, wallets, super-stylish bags, and purses. Timings: 10:00 AM to 9:00 PM approximately",
        "National Market National Market in Bangalore is situated near majestic. One can easily find clothes, accessories, phones, cameras, and tablets at affordable prices. It remains busy throughout the day being visited by the locals of the city to buy products of daily needs. An old market named Malleswaram old market that situated near the Ganesha temple, should definitely be visited. Timings: 8:00 AM to around 7:00 PM",
        "Malleswaram One of the most popular traditional markets of Bengaluru, Malleswaram is famous for its flower market, herbs, spices, and vegetables. It is also famous for the Kaadu Malleswara Temple located nearby, from which this market gets its name. The hustle-bustle of this market and its traditional items lend it an old-world charm. Treat yourself to street-food delicacies sold here ",
        "MG Road MG Road is one of the busiest commercial centers of shopping in Bangalore. MG Road is also the perfect place to shop for beautiful silk sarees, especially at Prasiddi and Deepam Silks. MG Road is also an excellent place to purchase handicrafts from places such as Cauvery Emporium. India's oldest bookstore founded in 1844, Higginbothams, is also located here and is a must-visit for any bibliophile.",
        "Avenue Road Dotted with heritage buildings, Avenue Road is best known for second-hand books. From textbooks to novels to cookbooks to books on architecture, the hawkers here are sure to give you the best deal. Most of the books are in excellent condition, and if you are lucky, you might even find some rare edition of your favorite novel here! It is also the place to buy school and college textbooks at cheap rates. Apart from books, you can shop for raw materials for decoration and gift packing, jewelry, garments and stationery. Timings: 9:00 AM to around 8:00 PM.",
        "Gandhi Bazar Located in Basavanagudi locality, this market is famous for traditional religious items, clothes, and trinkets. Gandhi Bazar is in its full glory during the festivals. You could visit Vittal dresses, Mysore Silk Emporium, and Indu fashion for sourcing garments. Greeting Gardens and National Novelties are other places that can be visited. Make sure to taste some of the most delicious street foods at Vidyarthi Bhawan. Timings: 10:00 AM to 7:00 PM",
        "KR Market KR Market or Krishna Rajendra Market or City Market is the largest wholesale market in Bangalore. Once a battlefield for the Anglo-Mysore wars, KR Market is now a bustling market that has everything from flowers to vegetables to fresh produce. Timings: 6:00 AM - 10:00 PM So which of these are your favorite markets for street shopping in Bangalore? Let us know in the comments below!",
        "Shopping on Commercial Street in Bangalore is an experience filled with diverse options, from clothing and jewelry to footwear and accessories. Trusted vendors and shops are key to a successful shopping spree here, offering quality products, good value for money, and reliable customer service. While the best can be subjective and vary over time, certain stores have built a reputation over the years for their authenticity and customer satisfaction. Here's a curated list of some trusted vendors on Commercial Street, known for their quality and service:",
        "Shopping on Commercial Street in Bangalore  Fazals & Sons Specialty: Leather goods Why Trust: A long-standing shop known for high-quality leather products such as bags, jackets, and wallets.",
        "Shopping on Commercial Street in Bangalore  Vashi’s House of Jeans Specialty: Denim wear Why Trust: Offers a vast selection of jeans for all ages, known for its wide range and fitting options.",
        "Shopping on Commercial Street in Bangalore  Deepam Silks Specialty: Silk sarees and ethnic wear Why Trust: Renowned for its exquisite collection of silk sarees, bridal wear, and ethnic garments, offering both traditional and contemporary designs.",
        "Shopping on Commercial Street in Bangalore  Kushal’s Fashion Jewellery Specialty: Fashion and traditional jewelry Why Trust: They have a reputation for quality and design in fashion jewelry, offering a wide range of options from casual to bridal pieces.",
        "Shopping on Commercial Street in Bangalore  Mysore Saree Udyog Specialty: Sarees and fabrics Why Trust: Known for a vast collection of sarees from across India, including silks, cottons, and designer sarees, they cater to a broad audience.",
        "Shopping on Commercial Street in Bangalore Sreeleathers Specialty: Footwear Why Trust: Offers durable and comfortable footwear for men, women, and children at reasonable prices, with a good variety of styles.",
        "Shopping on Commercial Street in Bangalore Woody’s Specialty: Furniture and home decor Why Trust: While primarily known as a restaurant, Woody’s also sells furniture and home decor items, known for their quality and craftsmanship.",
        "Shopping on Commercial Street in Bangalore Shopping Singapore Specialty: Electronics, toys, and gifts Why Trust: A go-to place for imported goods, offering a unique selection of items that are hard to find elsewhere on the street.",
        "Shopping on Commercial Street in Bangalore Shopping Tips on Commercial Street: Research and Compare: Before making a significant purchase, it's wise to compare prices and products in a few shops. Quality Check: Especially for clothing and jewelry, inspect the quality of materials and craftsmanship. Negotiate: While some fixed-price stores exist, bargaining is common in many shops. Don't hesitate to negotiate, especially if you're buying multiple items. Warranty and Returns: Ask about return policies and warranties, especially for higher-value items like electronics or leather goods.",
        "Sapna Book House is a  notable bookstores and dealers on Avenue Road where you can find a vast selection of books: Not directly on Avenue Road but nearby, it's one of the largest bookstores in Bangalore. They offer a wide range of books across various genres, including academic, literature, and competitive exam books.",
        "Gangarams Book Bureau  is a  notable bookstores and dealers on Avenue Road where you can find a vast selection of books: Another not exactly on Avenue Road but in the vicinity, Gangarams has been a landmark for book lovers, offering a diverse selection of books and stationery items.",
        "Bookworm is a  notable bookstores and dealers on Avenue Road where you can find a vast selection of books: This is one of the popular second-hand bookstores on Avenue Road, known for its vast collection of used books at affordable prices. You can find academic books, novels, and much more here.",
        "Mysore Book Houseis a  notable bookstores and dealers on Avenue Road where you can find a vast selection of books:  Known for its collection of academic and competitive exam books, Mysore Book House is a go-to place for students looking for textbooks and guides.",
        "Goobe’s Book Republic is a  notable bookstores and dealers on Avenue Road where you can find a vast selection of books: Not exactly on Avenue Road, but worth mentioning for its curated selection of books and a cozy reading space. They specialize in a variety of genres and often host book-related events.",
        "Tips for Shopping on Avenue Road: Bargaining is Key: Don't hesitate to bargain, especially in the smaller shops and street stalls. Check for Editions: If you're looking for academic books, ensure you're buying the correct edition as specified in your syllabus. Explore Small Alleys: Some of the best deals and rare finds are in smaller, less prominent shops off the main road. Verify Condition: When buying used books, check their condition to ensure you're getting a good deal. Remember, the joy of exploring Avenue Road's book market is as much in the hunt for books as it is in the finds. The area is always evolving, with new shops opening and old ones closing, so part of the adventure is discovering what's currently there. Whether you're a student, a bibliophile, or just someone looking for a good read, Avenue Road's book market is a delightful experience that encapsulates the charm of old Bangalore."
    ]

    
    var body: some View {
        
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(messages, id: \.self) { message in
                            MessageView(currentMessage: message)
                                .id(message)
                        }
                    }
                    .onReceive(Just(messages)) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.last, anchor: .bottom)
                        }
                        
                    }.onAppear {
                        withAnimation {
                            proxy.scrollTo(messages.last, anchor: .bottom)
                        }
                    }
                }
                
                // send new message
                HStack {
                    TextField("Send a message", text: $newMessage)
                        .textFieldStyle(.roundedBorder)
                    
                    Button {
                        Task {
                            do {
                                let embeddedLinks = try  await WebService().getEmbeddingsForText(inputString: newMessage)
                                let response = try  await WebService().fetchEmbeddingsFromPineCone(embeddedLinks: embeddedLinks)
                                print(response) // Log the response from the second request
                                if !newMessage.isEmpty{
                                    messages.append(Message(content: newMessage, isCurrentUser: true))
                                    messages.append(Message(content: "" + (response.matches.first?.metadata.test ?? newMessage) , isCurrentUser: false))
                                    newMessage = ""
                                }
                            } catch {
                                print("Error:", error)
                            }
                        }
                    } label: {
                        Image(systemName: "paperplane")
                    }
                    
                }
                .padding()
            }
        }
        
        
        
    }
    
    func sendMessage() async {
        let service = WebService()
        
                do {
                    let embeddedLinks = try await service.getEmbeddingsForText(inputString: newMessage)
                    let response = try await service.fetchEmbeddingsFromPineCone(embeddedLinks: embeddedLinks)
                    print(response) // Log the response from the second request
                } catch {
                    print("Error:", error)
                }
        
        if !newMessage.isEmpty{
            messages.append(Message(content: newMessage, isCurrentUser: true))
            messages.append(Message(content: "" + newMessage , isCurrentUser: false))
            newMessage = ""
        }
    }
}

#Preview {
    ContentView()
}


class WebService {
    
    func getEmbeddingsForText(inputString: String) async throws -> EmbeddingsResponse {
        let token = "pa-YNGUDS6qdw3a-dHbgbQ1gvxkViUrvh-3f4igAxecc0w"
        let postData: [String: Any] = [
            "input": inputString,
            "model": "voyage-2"
        ]
        let jsonData = try JSONSerialization.data(withJSONObject: postData)
        let url = URL(string: "https://api.voyageai.com/v1/embeddings")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedData = try JSONDecoder().decode(EmbeddingsResponse.self, from: data)
        return decodedData
    }

    func fetchEmbeddingsFromPineCone(embeddedLinks: EmbeddingsResponse) async throws -> PineConeResponse {
        let apiKey = "3a8fddeb-7ccf-4dac-9296-d51149ee7d32"
        let pineConePostaData = PineCodePostData(vector: embeddedLinks.data.first?.embedding ?? [0.00012], topK: 1, includeMetadata: true)
        let postData = try JSONEncoder().encode(pineConePostaData)
        let url = URL(string: "https://test-index-nzzsi05.svc.gcp-starter.pinecone.io/query")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "Api-Key")
        request.httpBody = postData

        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedData = try JSONDecoder().decode(PineConeResponse.self, from: data)
        return decodedData
    }
    
//    func upsertEmbeddingsToPineCone(embeddedLinks: EmbeddingsResponse) async throws -> PineConeResponse {
//        let apiKey = "3a8fddeb-7ccf-4dac-9296-d51149ee7d32"
//        let randomKey = UUID().uuidString
//        let
//        let pineConePostaData = UpsertData(vectors: <#T##[Vector1]#>)
//        let postData = try JSONEncoder().encode(pineConePostaData)
//        let url = URL(string: "https://test-index-nzzsi05.svc.gcp-starter.pinecone.io/vectors/upsert")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue(apiKey, forHTTPHeaderField: "Api-Key")
//        request.httpBody = postData
//
//        let (data, _) = try await URLSession.shared.data(for: request)
//        let decodedData = try JSONDecoder().decode(PineConeResponse.self, from: data)
//        return decodedData
//    }
    
}



