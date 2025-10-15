# icons-brew.yazi

Make a hot `theme.toml` for your Yazi icons with your favorite color palette.

## Screenshots

Left: `nvim-web-devicons` defaults | Right: `Catppuccin` Mocha and Latte

<details>
  <summary>Dark theme</summary>
  <img width="124" height="994" alt="Image" src="https://github.com/user-attachments/assets/038cbccc-8285-4d4c-8f4c-8366784a3052" />
  <img width="124" height="994" alt="Image" src="https://github.com/user-attachments/assets/c7937c83-be23-4439-bac8-2584f5e82e36" />
</details>

<details>
  <summary>Light theme</summary>
  <img width="124" height="994" alt="Image" src="https://github.com/user-attachments/assets/3afa7f26-b037-4ded-bb8f-6f5b1d0a7118" />
  <img width="124" height="994" alt="Image" src="https://github.com/user-attachments/assets/412146c1-e177-46e6-9e08-1a7073691dae" />
</details>

## On Tap

If you have a taste for [Catppuccin
flavors](https://github.com/catppuccin/catppuccin?tab=readme-ov-file#-palette),
just grab the available ready-made theme inside the [catppuccin](/catppuccin)
directory. Rename the file to `theme.toml` and place it in your Yazi
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

For a visual reference of the entire xterm palette, see the following resources:

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

## Automatic Theme Switching

As you may have noticed, the dark and the light themes are split into two
configuration files (`theme-dark.toml` and `theme-light.toml`), while the setup
instructions mentions a single `theme.toml` file.

The `theme.toml` supports only one color scheme. If your terminal usage
involves dynamic theme switching, this means a single theme will be applied to
your icon colors regardless, as the values in the `theme.toml` file take
precedence over any other configuration.

Fortunately, Yazi allows us to switch between themes using the `[flavor]`
section in the `theme.toml`. Here, we can specify two different configuration
files (flavors), one for each mode, like this:

```toml
[flavor]
dark  = "dracula"
light = "one-light"
```

To achieve this, we need to convert the generated theme files into custom Yazi
flavors. Like plugins, Yazi flavors have their own `flavors` directory, and
each flavor is a directory with a kebab-case name ending in `.yazi`.

For example, to create `custom-mocha` and `custom-latte` flavors, the directory
structure should look like this:

```bash
~/.config/yazi
├──  flavors
│   ├──  custom-latte.yazi
│   └──  custom-mocha.yazi
```

So, what we need to do is create both directories:

```bash
mkdir -p ~/.config/yazi/flavors/custom-mocha.yazi ~/.config/yazi/flavors/custom-latte.yazi
```

Then, move each generated theme file into its respective flavor directory:

```bash
mv theme-dark.toml ~/.config/yazi/flavors/custom-mocha.yazi/flavor.toml
mv theme-light.toml ~/.config/yazi/flavors/custom-latte.yazi/flavor.toml
```

Finally, tell Yazi to use our custom flavors in `~/.config/yazi/theme.toml`:

```toml
[flavor]
dark = "custom-mocha"
light = "custom-latte"
```

There are some ready-made themes available in the
[yazi-rs/flavors](https://github.com/yazi-rs/flavors) repo. You can use any of
them as a starting point and then just append the contents of your
`theme-dark.toml` or `theme-light.toml` to their `flavor.toml`.

See the [Flavors section](https://yazi-rs.github.io/docs/flavors/overview) of
the Yazi documentation for more details.

## Acknowledgement

- [Yazi](https://yazi-rs.github.io) for the amazing — and *Blazing Fast* —
terminal file manager. The `brew.lua` follows the same script found on [Yazi's
repo](https://github.com/sxyazi/yazi/blob/main/scripts/icons/generate.lua).
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons), for
providing and maintaining the icons we all rely on.
- [Catppuccin](https://github.com/catppuccin), for the soothing pastel theme. The
warmest flavors one could ask for.
