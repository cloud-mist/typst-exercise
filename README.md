将CSV题目列表用Typst排成刷题形式。

### 功能列表

- 支持单选/多选/判断
- 填写错题列表刷错题
- 显示/隐藏答案与解析
- 支持选项大于4个的题目

### 使用

#### 0. 前置

将excel导出为csv

#### 1.csv长什么样子

```
题型,内容,解析,答案,A,B,C,D,E,F
单选,1+1=?,答案应该是2,B,1,2,3,4,5,6
判断,1+1=2对吗,,对,对,错,,,,
多选,"下列地理现象中，主要由地球自转产生的是（ )","A：地球自转产生昼夜交替。B：地球自转使不同经度的地方时不同。C：地球自转产生地转偏向力，北半球水平运动物体向右偏转。D：四季更替主要由地球公转和地轴倾斜产生，不是自转直接造成的。",ABC,昼夜交替,经度不同导致地方时不同,北半球水平运动物体向右偏转,四季更替,,
```

#### 2.编译

`typst compile main.typ --font-path ./fonts/ exam.pdf`

如有需要，修改main.typ中各个配置

```typst
#set text(font: "霞鶩文楷") // 使用字体
#text(size: 26pt)[#align(center)[试题]]
#let SHOW-ANSWER = false// 是否显示答案和解析
#let err = () // 如果不为空，打印指定题号错题;如果为空，打印全部题目
#let data = csv("./test.csv") // 题目文件
```

#### 3.效果

可查看项目下[test.pdf](test.pdf) 和 [带答案版test-ans.pdf](test-ans.pdf)

### 致谢

- [Typst](https://typst.app)
- [霞鹜文楷 (LXGW WenKai)](https://github.com/lxgw/LxgwWenKai)

### 许可证

- 本项目代码以 [MIT License](LICENSE) 授权，Copyright (c) 2026 cloud-mist。
- `fonts/` 目录下的霞鹜文楷字体以 [SIL OFL 1.1](fonts/OFL.txt) 授权，版权归 lxgw 所有。
