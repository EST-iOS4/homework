import Foundation

//두개 같은 것
//var gamesToPlay = Array<String>()
var gamesToPlay = [String]()

gamesToPlay.append("MapleStory")
gamesToPlay.append("Super Mario")
gamesToPlay.append("Starcraft")

print(gamesToPlay.count)

gamesToPlay.insert("League of Legend", at: 2)

print(gamesToPlay.count)
print(gamesToPlay)

let firstGameToPlay = gamesToPlay.first ?? ""
print(firstGameToPlay)
let lastGameToPlay = gamesToPlay.last ?? ""
print(lastGameToPlay)





