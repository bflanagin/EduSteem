function checkspelling(string) {
    var num = 0
    var returned = ""
    var words = string.trim().split(" ")
    var checked = []

    while (words.length > num) {
        var newWord = words[num].toUpperCase()

        var url = ""
        var letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
            var firstletter = words[num].split("")[0]


            if (words[num] !== " " && letters.indexOf(firstletter.toUpperCase()) !== -1) {
                url = "./Dictionary in csv/" + firstletter.toUpperCase() + ".csv"
            }



        if (url === "") {
            checked.push(words[num])
        } else {

            var spellinglist = new XMLHttpRequest()

            spellinglist.onreadystatechange = function () {

                if (spellinglist.readyState === XMLHttpRequest.DONE) {

                    var fulllist = spellinglist.responseText
                    var wordlist = fulllist.split("\n")
                    var foundAt = -1
                    for (var findword = 0; findword < wordlist.length; findword++) {
                        var inspelling = wordlist[findword].split("(")[0].trim(
                                    ).toUpperCase().replace(/"/g, '')
                        if (newWord === inspelling) {
                            foundAt = findword
                            break
                        } else if (newWord === inspelling + "S") {
                            foundAt = findword
                            break
                        } else if (newWord === inspelling + ".") {
                            foundAt = findword
                            break
                        } else if (newWord === inspelling + ":") {
                            foundAt = findword
                            break
                        } else if (newWord === inspelling + ";") {
                            foundAt = findword
                            break
                        } else if (newWord === inspelling + ",") {
                            foundAt = findword
                            break
                        } else if (newWord === inspelling + "?") {
                            foundAt = findword
                            break
                        } else if (newWord === inspelling + "!") {
                            foundAt = findword
                            break
                        } else if (newWord === inspelling + "N'T") {
                            foundAt = findword
                            break
                        }
                    }
                    if (foundAt !== -1) {
                        checked.push(words[num])
                    } else {
                        checked.push("<font color='red'>" + words[num] + "</font>")
                    }
                }
            }

            spellinglist.open('GET', url.trim(), false)
            spellinglist.send()
        }

        num = num + 1
    }
    returned = checked.join(" ")

    return returned
}
