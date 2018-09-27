
/* Incomplete but working MarkDown to qml connverter
  currently supports most of the things I have used in my own posts but I'm sure others will need to be added for maxium support */
function md2qml(text, log) {

    var splittext = ""
    if (text.search("<html>") !== -1) {
        splittext = text.split('</head>')[1].split("</html>")[0]
    } else {
        splittext = text
    }

    splittext = splittext.replace(/\r\n/g,
                                  "\r").replace(/\n\r/g,
                                                "\r").replace(/\n/g,
                                                              "\r").split(/\r/)

    var formatted = ""

    markdown.clear()

    for (var num = 0; num < splittext.length; num = num + 1) {

        var changeformat = ""

        /* here we search for code breaks I'd like to add color highlighting based on what kind of code is present but that will come later */
        if (splittext[num].search("```") !== -1) {
            changeformat = splittext[num].replace(/```/,
                                                  "<br><br>").replace(/\n/, "")

            markdown.append({
                                "type": "code",
                                "thepost": "--- CODE ---",
                                "img": ""
                            })
        } else if (splittext[num].search(/\!\[/) !== -1) {

            /* here we search for images */
            changeformat = splittext[num].split("](")[1].split(")")[0].replace(
                        /\\/g, "")

            markdown.append({
                                "type": "image",
                                "thepost": "",
                                "img": changeformat
                            })
        } else if (splittext[num].search(/\[/) !== -1) {

            /* here we search for images */
            changeformat = splittext[num].split("](")[1].split(")")[0].replace(
                        /\\/g, "")

            markdown.append({
                                "type": "url",
                                "thepost": changeformat,
                                "img": ""
                            })
        }else if (splittext[num].search("---") !== -1) {

            changeformat = splittext[num].replace(/---/,
                                                  "<br>").replace(/\n/, "")

            markdown.append({
                                "type": "seperator",
                                "thepost": "",
                                "img": ""
                            })
        } else {

            /* Main text converter */
            markdown.append({
                                "type": "text",
                                "thepost": replace_them(splittext[num]),
                                "img": ""
                            })
        }
    }
}

function replace_them(line) {
    var formatedline = []


    /* Here we take the information in the array and run it through the text that is given. The nested array is broken into three parts [What to lookfor, What to replace it with,
            and how to end the line] */
    var linestarters = [ ["### ", "<h3>", "</h3>"], ["## ", "<h2>", "</h2>"], ["# ", "<h1>", "</h1>"], ["- ", "<ul><li>", "</li></ul>"], [/\* /g, "<ul><li>", "</li></ul>"]]
    var incased = [[/\*\*/g, " <b>", "</b>"], [/~~/g, " <s>", "</s>"], [/_/g, " <i>", "</i>"]]
    var offset = 0
    var parts = line.split(" ")
    var wordnum = 0
    while (wordnum < parts.length) {
            var found = 0
        for (var rnum = 0; incased.length > rnum; rnum = rnum + 1) {
            if (parts[wordnum].search(incased[rnum][0]) !== -1) {
                found = 1
                var incasedWord = parts[wordnum].split(incased[rnum][0])

                switch (incasedWord.length) {
                case 3:
                    formatedline.push(
                                incased[rnum][1] + incasedWord[1] + incased[rnum][2])
                    break
                case 2:
                    if (parts[wordnum].split(
                                incased[rnum][0])[0].length === 0) {
                        formatedline.push(incased[rnum][1] + incasedWord[1])
                    } else {
                        formatedline.push(incasedWord[0] + incased[rnum][2])
                    }
                    break
                default:
                    break
                }
                break
            } else {
                found = 0
            }
        }

        if (found === 0) {
            formatedline.push(parts[wordnum])
        }

        wordnum = wordnum + 1
    }
        formatedline = formatedline.join(" ")
        for (var frnum = 0; linestarters.length > frnum; frnum = frnum + 1) {
                if(formatedline.search(linestarters[frnum][0]) !== -1 ) {
                   formatedline = formatedline.replace(linestarters[frnum][0],linestarters[frnum][1])+linestarters[frnum][2]
                    break
                }
        }

    return (formatedline.replace(/\\n/g,"<br>").replace(/\n/g, "<br>"))
}

function guide() {

    var text = "### Markdown guide: \n --- \n
eduSteem uses markdown to format the text within the application. The following formatting symbols are avaiable to you.

# # Heading 1
## ## Heading 2
### ### Heading 3
* '*,-,+' All create bulleted lists

Three '`' in a row creates a code block, adding three more at the end will end the block.

Three '-' in a row creates a seperator


"

    return text
}
