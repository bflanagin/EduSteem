function get_blog(account) {
    var url = "https://api.steemit.com/"
    var tosend = '{"jsonrpc":"2.0", "method":"follow_api.get_blog", "params":{"account":"'
            + account.split("@")[1] + '","start_entry_id":0,"limit":3}, "id":1}'

    var http = new XMLHttpRequest()
    gc()
    var pagedata = ""

    steemitposts.clear()

    http.onreadystatechange = function () {

        if (http.readyState == 4) {

            if (http.responseText == "100") {
                console.log("Incorrect DevID")
            } else if (http.responseText == "101") {
                console.log("Incorrect AppID")
            } else {
                pagedata = http.responseText

                var contents = pagedata.split('{"comment":')

                banner = "../img/steemit-vector-icon.png"
                var num = 1
                while (num < contents.length) {
                    var permlink = contents[num].split('"permlink":"')[1].split(
                                '","category":"')[0]
                    var parent = contents[num].split(
                                '"parent_permlink":"')[1].split(
                                '","title":"')[0]

                    steemitposts.append({
                                            posttitle: contents[num].split(
                                                '"title":"')[1].split(
                                                '","body":"')[0],
                                            post: contents[num].split(
                                                '"body":"')[1].slice(
                                                0, 2000) + "...",
                                            thelink: "https://steemit.com/" + parent
                                                     + "/@" + account.split(
                                                         "@")[1] + "/" + permlink
                                        })

                    num = num + 1
                }
            }
        }
    }
    http.open('POST', url.trim(), true)
    http.setRequestHeader("Content-type", "application/json")
    http.send(tosend)
}


function get_follow(account) {
    var url = "https://api.steemit.com/"
    var tosend = '{"jsonrpc":"2.0", "method":"follow_api.get_follow_count", "params":{"account":"'
            + account.split("@")[1] + '"}, "id":1}'

    var http = new XMLHttpRequest()
    gc()
    var pagedata = ""

    http.onreadystatechange = function () {

        if (http.readyState == 4) {

            if (http.responseText == "100") {
                console.log("Incorrect DevID")
            } else if (http.responseText == "101") {
                console.log("Incorrect AppID")
            } else {
                pagedata = http.responseText

                profileAbout = pagedata.split(",")

            }
        }
    }
    http.open('POST', url.trim(), true)
    http.setRequestHeader("Content-type", "application/json")
    http.send(tosend)
}

function get_info(account) {
    var url = "https://api.steemit.com/"
    var tosend = '{"jsonrpc":"2.0", "method":"condenser_api.get_accounts", "params":[[ \
            "'+ account.split("@")[1] +'"]], "id":1}'

    var http = new XMLHttpRequest()
    gc()
    var pagedata = ""

    http.onreadystatechange = function () {

        if (http.readyState == 4) {

            if (http.responseText == "100") {
                console.log("Incorrect DevID")
            } else if (http.responseText == "101") {
                console.log("Incorrect AppID")
            } else {
                pagedata = http.responseText

               var profile = pagedata.split('{\\"profile\\":{')[1].split('\\"}}"')[0]

                steemProfileInfo = profile.replace(/\\/g , "").split(",")
                //console.log(steemProfileInfo[4])

            }
        }
    }
    http.open('POST', url.trim(), true)
    http.setRequestHeader("Content-type", "application/json")
    http.send(tosend)
}


