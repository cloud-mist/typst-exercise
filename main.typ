// 一个简单的excel题目列表转换为排版好的题目小模板,方便打印刷题
#set page(
  paper: "a4",
  binding: left,
  margin: (inside: 2.8cm, outside: 2cm, top: 2cm, bottom: 2cm),
  numbering: "1",
  footer: context text(size: 9pt)[#align(
    center,
  )[#counter(page).display("1") / #counter(page).final().first()]],
)

/// config
#set text(font: "霞鶩文楷") // 使用字体
#text(size: 26pt)[#align(center)[试题]]
#let SHOW-ANSWER = false// 是否显示答案和解析
#let err = () // 如果不为空，打印指定题号错题;如果为空，打印全部题目
#let data = csv("./test.csv") // 题目文件
///

#let ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

#let question(i, row) = {
  let type = row.at(0, default: "")
  let stem = row.at(1, default: "")
  let note = row.at(2, default: "")
  let ans = row.at(3, default: "")
  let options = if row.len() > 4 { row.slice(4) } else { () }
  options = options.filter(s => s.trim() != "")

  let is-judge = type.contains("判断")
  let is-multi = type.contains("多选")

  block(breakable: false)[
    *#(i + 1).* #if is-multi { text(fill: gray, size: 0.85em)[[多选]] } #stem
    #if is-judge {
      if SHOW-ANSWER {
        linebreak()
        text(fill: blue)[答案：#ans ]
      } else {
        [ (#h(1.5em)) ]
      }
    } else {
      if options.len() > 0 {
        for (idx, opt) in options.enumerate() {
          linebreak()
          [#h(1.5em)#ALPHA.at(idx). #opt]
        }
      }
      if SHOW-ANSWER {
        linebreak()
        text(fill: blue)[答案：#ans]
      }
    }
    #if SHOW-ANSWER and note != "" {
      linebreak()
      text(fill: gray)[解析: #note]
    }
    #v(0.8em)
  ]
}


#for (i, row) in data.slice(1).enumerate() {
  if err.len() != 0 {
    if err.contains(i + 1) {
      question(i, row)
    }
  } else {
    question(i, row)
  }
}
