/* Incomplete but working MarkDown to qml connverter
  currently supports most of the things I have used in my own posts but I'm sure others will need to be added for maxium support */
function md2qml(text) {

    var splittext = text.split("\\n")
    var formatted = ""

    for (var num = 0; num < splittext.length; num = num + 1) {

        var changeformat = ""

        /* here we search for code breaks I'd like to add color highlighting based on what kind of code is present but that will come later */
        if (splittext[num].search("```") !== -1) {
            changeformat = splittext[num].replace(/```/,
                                                  "<br><br>").replace(/\\n/, "")

            markdown.append({
                                type: "code",
                                thepost: "--- CODE ---",
                                img: ""
                            })
        } else if (splittext[num].search(/\!\[/) !== -1) {

            /* here we search for images */
            changeformat = splittext[num].split("](")[1].split(")")[0].replace(
                        /\\/g, "")

            markdown.append({
                                type: "image",
                                thepost: "",
                                img: changeformat
                            })
        } else {

            /* Main text converter */
            markdown.append({
                                type: "text",
                                thepost: replace_linestarters(splittext[num]),
                                img: ""
                            })
        }
    }
}

function replace_linestarters(line) {
    var formatedline = ""

    /* Here we take the information in the array and run it through the text that is given. The nested array is broken into three parts [What to lookfor, What to replace it with,
            and how to end the line] */
    var linestarters = [["#### ", "<h4>", "</h4>"], ["### ", "<h3>", "</h3>"], ["## ", "<h2>", "</h2>"], ["# ", "<h1>", "</h1>"], ["- ", "<ul><li>", "</li></ul>"], [/ \*\*/g, "<b>", ""], [/\*\*/g, "<b>", ""], [/\*\* /g, "</b>", ""], ["\\+ ", "<ul><li>", "</li></ul>"]]

    for (var rnum = 0; linestarters.length > rnum; rnum = rnum + 1) {

        if (line.search(linestarters[rnum][0]) !== -1) {
            formatedline = line.replace(linestarters[rnum][0],
                                        linestarters[rnum][1]).replace(
                        /\\/g, "").replace(/\"/g, '"') + linestarters[rnum][2]
            break
        } else {
            formatedline = line.replace(/\\/g, "")
        }
    }

    return formatedline.replace(/\\n/, "<br>")
}
