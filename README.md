# Parameterized Asynchronous FIFO
## 简介
一个可以自定义深度宽度的异步fifo，由于作者实力较差，可能存在一些bug

## 开发环境
OS：MacOS 14.2.1
IDE：vscode
toolchain：sbt 1.8.0 + iverilog
chisel version: 3.5.4

## 目录简介
目录如下：
.
├── Makefile
├── README.md
├── build.sbt
├── gen
│   ├── fifo.anno.json
│   ├── fifo.fir
│   └── fifo.v
├── prj
├── project
├── src
│   ├── main
│   └── test
├── target
├── tb
│   ├── fifo_if.sv
│   └── fifo_tb.sv
└── user
    ├── data
    ├── sim
    └── src
`./src/main`:项目的源文件
`./src/test`:chiseltest文件。我没用chisel写testbench所以是空的。
`./gen:`:存放的是chisel编译出的verilog文件。
`./tb`:所有的`testbench`的文件。
`./user`:用` DigitalIDE`进行一键仿真的目录

## Makefile简介
`run`:用sbt编译工程，文件输出到`./gen:`
`test`:用iverilog进行仿真，不生成vcd文件
`wave`:用iverilog进行仿真，生成vcd文件
`git`:提交一个版本，用当前时间命名
`clean`:清理所有输出文件



