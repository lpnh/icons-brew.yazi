# icons-brew.yazi

Make a hot `theme.toml` for your Yazi icons with your favorite color palette.

## Screenshots

<details open>
  <summary>Dark theme</summary>
    <img src="assets/default_dark.png"> <img src="assets/mocha.png">
</details>

<details>
  <summary>Light theme</summary>
    <img src="assets/default_light.png"> <img src="assets/latte.png">
</details>

Observe how the default colors (on the left) have been replaced with
user-provided colors (on the right).

These screenshots were made using the script's default output. The dark and
light themes are based on Catppuccin's Mocha and Latte palettes, respectively.

## On Tap

If you have a taste for [catppuccin
flavors](https://github.com/catppuccin/catppuccin?tab=readme-ov-file#-palette),
just grab the available ready-made theme inside the [catppuccin](/catppuccin)
directory. Rename the file to `theme.toml` and add it to your Yazi
configuration path. This can be done with a single `curl` command.

For the Mocha flavor:

```sh
curl https://raw.githubusercontent.com/lpnh/icons-brew.yazi/main/catppuccin/mocha.toml >> ~/.config/yazi/theme.toml
```

For the Latte flavor:

```sh
curl https://raw.githubusercontent.com/lpnh/icons-brew.yazi/main/catppuccin/latte.toml >> ~/.config/yazi/theme.toml
```

That's it, enjoy!

## Self-service

### Prepare

Use the `dark` and `light` tables in the [config.lua](/config.lua) file to
apply the desired color palette. For more information, see the
[Configuration](#configuration) section below.

### Brew

Run the `brew.lua` script to generate both dark and light theme files.

```bash
lua brew.lua
```

Note: this requires having `lua` installed on your system. You can check it by
running `lua -v`.

### Serve

Add the generated file to your Yazi config directory:

```shell
mv theme-dark.toml ~/.config/yazi/theme.toml
```

## Configuration

All configuration is done by editing the `dark`, `light`, and `groups` tables
in the `config.lua` file.

### Color Theme

The `dark` and `light` tables define hex colors for each semantic color group.  
To apply your own theme, simply modify these hex values.

For example, if you prefer
[gruvbox](https://github.com/morhetz/gruvbox?tab=readme-ov-file#dark-mode-1) as
your dark theme instead of Catppuccin Mocha, your configuration would look like
this:

```lua
M.dark = {
  ["grey"]           = "#928374",
  ["red"]            = "#cc241d",
  ["green"]          = "#98971a",
  ["yellow"]         = "#d79921",
  ["blue"]           = "#458588",
  ["magenta"]        = "#b16286",
  ["cyan"]           = "#689d6a",
  ["bright_grey"]    = "#a89984",
  ["bright_red"]     = "#fb4934",
  ["bright_green"]   = "#b8bb26",
  ["bright_yellow"]  = "#fabd2f",
  ["bright_blue"]    = "#83a598",
  ["bright_magenta"] = "#d3869b",
  ["bright_cyan"]    = "#8ec07c",
}
```

### Color Groups

The `groups` table maps xterm color numbers (0-255) to the semantic color
groups defined in `dark` and `light` tables. Each icon in `nvim-web-devicons`
has a `cterm_color` number, which we use to determine its color.

To change an icon's color, you can move its `cterm_color` number to a different
group. For example, to make an icon that uses cterm color `52` appear blue
instead of red, you would move `52` from the `red` array to the `blue` array.

```lua
M.groups = {
    ["red"] = { 1, 88, 124, 160, 196, ... },
    ["blue"] = { 4, 17, 18, 19, 20, 21, 52, ... }, -- 52 was moved here
    -- ... other groups
}
```

You can find the `cterm_color` for each icon in the
[nvim-web-devicons](/nvim-web-devicons/) module.

## Rationale

### Color Groups

The default color groups follow the "standard" 16 terminal colors: red, green,
yellow, blue, etc., and their bright variations. Except that black and white
have been replaced with grey.

They should work well with the popular color schemes we are accustomed to while
providing more than enough color distinction between the icons.

### Color Numbers

The xterm 256-color palette is a standard for terminal emulators.

This palette is divided into:

- **0-15**: 16 standard colors (8 basic + 8 bright)
- **16-231**: 216 RGB colors (6x6x6 color cube)
- **232-255**: 24 grayscale colors

`nvim-web-devicons` assigns each icon a `cterm_color` number from this palette.

For a visual reference of the entire xterm palette, you can check out these
resources:

[xterm color chart on
Wikipedia](https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg)

[xterm color table on SS64](https://ss64.com/bash/syntax-colors.html)

### Mapping Tables

The `groups` table simply maps the icon numbers provided by `nvim-web-devicons`
to a semantic group that we can then assign our own colors (the `dark` and
`light` tables).

The current mapping of each `cterm_color` number to a specific group was
created manually. This means the process is inherently subjective.

A significant effort was made to ensure the result is both aesthetically
pleasing and semantically coherent. But there's always room for improvement.

If you have any suggestion, please feel free to **open an issue or start a new
discussion**. Your feedback is more than welcome!

## Acknowledgement

- [Yazi](https://yazi-rs.github.io) for the amazing — and *Blazing Fast* —
terminal file manager. The `brew.lua` follows the same script found on [Yazi's
repo](https://github.com/sxyazi/yazi/blob/main/scripts/icons/generate.lua).
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons), for
providing and maintaining the icons we all rely on.
- [catppuccin](https://github.com/catppuccin), for the soothing pastel theme. The
warmest flavors one could ask for.
