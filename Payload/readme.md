# Payload 示例

使用方法：选择一个 `.inf` 文件，重命名为 `autorun.inf` 后复制到 USBAirborne 根目录。

- `BadUSB.inf`：基础BadUSB演示，模拟键盘输入，打开记事本输入文字并播放一个视频。
- `AutorunDemo.inf`：AutoRun演示，USBAirborne开启CD-ROM模式以绕过Windows的AutoRun安全限制，双击U盘盘符时即执行Payload。
- `AutorunAndBadUSB.inf`：BadUSB + AutoRun 组合，同时执行键盘输入和AutoRun攻击。此时USBAirborne同样开启CD-ROM模式。
- `EraseFlash.inf`：擦除数据示例，执行BadUSB之后使用`[Format]`快速格式化USBAirborne。
- `GrabWLAN.inf`：导出 WLAN 配置和密码并保存到USBAirborne，请将`USB.AIRBORNE`文件放置在USBAirborne根目录下以便于定位盘符。
- `OpenFile.inf`：打开 U 盘根目录下的演示文件 `telescreen.png`。
- `USB.AIRBORNE`：盘符定位标记文件，配合 `GrabWLAN.inf` 使用。
- `telescreen.png`：`OpenFile.inf` 使用的示例图片。

提示：执行需要写入文件的Payload时，不能使用AutoRun攻击，因其会将USBAirborne的磁盘设为只读。
提示：payload中的`[BypassChineseIME]`用于智能绕过中文输入法，无需手动切换输入法或大小写锁定。

# Payload Demo

Usage: choose one `.inf` file, rename it to `autorun.inf`, and copy it to the USBAirborne root directory.

- `BadUSB.inf`: basic BadUSB demo. Simulates keyboard input, opens Notepad, types text, and plays a video.
- `AutorunDemo.inf`: AutoRun demo. USBAirborne enters CD-ROM mode to bypass Windows AutoRun restrictions, and the payload runs when the USB drive is double-clicked.
- `AutorunAndBadUSB.inf`: combined BadUSB + AutoRun demo. Runs keyboard input and the AutoRun attack together. USBAirborne also enters CD-ROM mode in this demo.
- `EraseFlash.inf`: Erase flash demo. Runs BadUSB, then uses `[Format]` to quick-format USBAirborne.
- `GrabWLAN.inf`: exports WLAN configuration and passwords, then saves them to USBAirborne. Place `USB.AIRBORNE` in the USBAirborne root directory so the payload can locate the drive letter.
- `OpenFile.inf`: opens the demo file `telescreen.png` from the USB drive root.
- `USB.AIRBORNE`: drive-letter marker file used by `GrabWLAN.inf`.
- `telescreen.png`: sample image used by `OpenFile.inf`.

Note: payloads that need to write files cannot use the AutoRun attack, because AutoRun makes the USBAirborne disk read-only.
