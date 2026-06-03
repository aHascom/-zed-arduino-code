# Arduino Upload - Zed Extension

Zed extension for Arduino development. No Rust compilation is needed.

## Features

- Syntax highlighting for `.ino` and `.pde` files via the C++ grammar
- Arduino snippets such as `arduino`, `pm`, `dw`, `dr`, `aw`, `ar`, `sp`, `for`
- Example Zed tasks for compile, upload, serial monitor, boards, cores, and libraries via `arduino-cli`

Important: Zed Vim mode is only for Vim-style editing. Arduino upload works through Zed tasks and `arduino-cli`.

## Install arduino-cli

Install `arduino-cli` first, then check that Zed can run it:

```sh
arduino-cli version
arduino-cli board list
```

Install the board core for Uno, Nano, and Mega:

```sh
arduino-cli core install arduino:avr
```

## Install in Zed

1. Open Zed.
2. Open the Command Palette with `Ctrl+Shift+P` or `Cmd+Shift+P`.
3. Run `zed: extensions`.
4. Click `Install Dev Extension`.
5. Select this extension folder.

The extension provides language support and snippets. To get upload tasks in an Arduino sketch, put a `.zed/tasks.json` file in that sketch/project folder. You can copy the `.zed/tasks.json` from this repository.

## Arduino IDE-like Controls

Zed extensions cannot add custom toolbar buttons like the Arduino IDE's top bar. The closest supported workflow is to use Zed tasks as command-palette buttons.

Open the task picker:

```text
Ctrl+Shift+R
```

Or open the Command Palette and run:

```text
task: spawn
```

| Task | What it does |
| --- | --- |
| `Arduino IDE: Verify` | Like the Arduino IDE checkmark button |
| `Arduino IDE: Upload` | Like the Arduino IDE arrow/upload button |
| `Arduino IDE: Verify + Upload` | Compiles and uploads in one step |
| `Arduino IDE: Serial Monitor` | Opens the serial monitor, default `115200` baud |
| `Arduino IDE: Boards & Ports` | Shows connected boards and serial ports |
| `Arduino IDE: Installed Cores` | Shows installed board cores |
| `Arduino IDE: Install AVR Core` | Installs Uno/Nano/Mega support |
| `Arduino IDE: Search Library` | Searches for a library |
| `Arduino IDE: Install Library` | Installs a library |

## First Use Checklist

If nothing seems to happen after installing the extension, go through this checklist.

1. Install this folder as a dev extension in Zed.
2. Open an actual Arduino sketch folder in Zed, not only this extension folder.
3. Make sure your sketch file has the `.ino` extension.
4. Copy this repository's `.zed/tasks.json` into your Arduino sketch folder.
5. Install `arduino-cli` and make sure this command works in a Zed terminal:

```sh
arduino-cli version
```

6. Connect your Arduino board by USB.
7. Find the port:

```sh
arduino-cli board list
```

8. Open your `.ino` file in Zed before running the task.
9. Edit your sketch folder's `.zed/tasks.json` and set `ARDUINO_PORT`, for example `COM3` or `COM4`.
10. Open the Command Palette and run `task: spawn`.
11. Choose `Arduino IDE: Verify + Upload`.

Installing the extension will not add an Upload button to the Zed toolbar. This extension gives Arduino file support and snippets. Uploading is done by tasks.

## Example Arduino Project Layout

Your Arduino project should look like this:

```text
Blink/
  Blink.ino
  .zed/
    tasks.json
```

The folder name and `.ino` file name should match for classic Arduino sketches. For example, `Blink/Blink.ino`.

When using global tasks, always open the `.ino` file first. The tasks use the current file's folder as the sketch folder.

Example sketch:

```cpp
void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
```

## Change Board and Port

Edit `.zed/tasks.json` in your Arduino project:

```json
"env": {
  "ARDUINO_FQBN": "arduino:avr:nano",
  "ARDUINO_PORT": "COM3"
}
```

Common FQBN values:

- `arduino:avr:uno` - Arduino Uno
- `arduino:avr:nano` - Arduino Nano
- `arduino:avr:mega` - Arduino Mega

Find your port:

```sh
arduino-cli board list
```

On Windows the port is usually `COM3`, `COM4`, or similar. On Linux/macOS it is often `/dev/ttyUSB0`, `/dev/ttyACM0`, or `/dev/cu.usbmodem...`.

## Install Libraries

Use the Zed tasks by changing `ARDUINO_LIBRARY` in `.zed/tasks.json`, or run commands in the terminal:

```sh
arduino-cli lib search "Adafruit NeoPixel"
arduino-cli lib install "Adafruit NeoPixel"
```

Then include the library in your sketch:

```cpp
#include <Adafruit_NeoPixel.h>
```

## Use Vim Mode

You can write Arduino code in Zed with Vim mode enabled. Open the Command Palette and run:

```text
workspace: toggle vim mode
```

Or add this to your Zed settings:

```json
{
  "vim_mode": true
}
```

## Troubleshooting

### I installed the extension but nothing changed

Open a `.ino` file and check whether it has Arduino/C++ syntax highlighting. This extension does not open a panel or add visible buttons.

### I do not see Arduino tasks

Reinstalling the extension will not fix missing upload tasks. Tasks are loaded from a tasks file, not from the extension install screen.

Use one of these options:

Project-only tasks:

1. Open your Arduino sketch folder in Zed.
2. Run `zed: open project tasks`.
3. Paste the contents of this repository's `.zed/tasks.json`.
4. Save the file.
5. Run `task: spawn`.
6. Search for `Upload`.

Global tasks for every project:

1. Run `zed: open tasks`.
2. Paste the contents of this repository's `.zed/tasks.json`.
3. Save the file.
4. Run `task: spawn`.
5. Search for `Upload`.

Do not search directly for `Arduino Upload` in the Command Palette. First run `task: spawn`; then search for `Arduino IDE: Upload` inside the task picker.

### Upload says arduino-cli was not found

Install `arduino-cli`, then restart Zed. In Zed's terminal, `arduino-cli version` must work.

### Language server says arduino-cli config not found

Use one of these fixes.

Recommended project setting:

```json
{
  "lsp": {
    "arduino-language-server": {
      "settings": {
        "autoCreateConfig": true
      }
    }
  }
}
```

This repository already includes that setting in `.zed/settings.json`.

Alternative terminal fix:

```sh
arduino-cli config init
```

Then restart the Arduino language server or restart Zed.

### Upload says no board or no port

Run:

```sh
arduino-cli board list
```

Then copy the detected port into `ARDUINO_PORT` in `.zed/tasks.json`.

### Compile says core is missing

For Uno, Nano, and Mega, run:

```sh
arduino-cli core install arduino:avr
```

Then try `Arduino IDE: Verify` again.

### Libraries are missing

Install the library first:

```sh
arduino-cli lib install "Library Name"
```

Then include it in your sketch with `#include <LibraryHeader.h>`.
