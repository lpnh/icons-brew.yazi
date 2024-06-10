# icons-brew.yazi

Make a hot `theme.toml` for your Yazi icons with your favorite color palette.  
Basically just an adaptation of
[tiny-devicons-auto-colors.nvim](https://github.com/rachartier/tiny-devicons-auto-colors.nvim)
plugin for Yazi.

![image](assets/before.png) ![image](assets/after.png)

## On Tap

If you have a taste for [catppuccin's Mocha
palette](https://github.com/catppuccin/catppuccin?tab=readme-ov-file#-palette)
just grab the ready-made [mocha.toml](/mocha.toml), rename it and add it to
your Yazi config path. That's it, enjoy!

*`mocha.toml` is the script's default output.*

## Self-service

### Prepare

Use the `colors_table` in the [config.lua](/config.lua) file to apply the
desired color palette. There's also some other variables you can adjust to
change the color matching results.

### Brew

Run the `brew.lua` script and save the output in a `theme.toml` file.

Using Bash:

```bash
lua brew.lua > theme.toml
```

Using Nushell:

```nushell
lua brew.lua | save theme.toml
```

### Serve

Add the generated file to your Yazi config directory:

```shell
mv theme.toml ~/.config/yazi/theme.toml
```

## Acknowledgement

- [Yazi](https://yazi-rs.github.io) for the amazing — and *Blazing Fast* —
terminal file manager. The `brew.lua` follows the same script found on [Yazi's
repo](https://github.com/sxyazi/yazi/blob/main/scripts/icons/generate.lua).
- [tiny-devicons-auto-colors.nvim](https://github.com/rachartier/tiny-devicons-auto-colors.nvim),
for the algorithm and implementation logic. I.e. everything on the [prepare](/prepare)
path and the `config.lua` file derived from it.
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons), for
providing and maintaining the icons we all rely on.
- [catppuccin](https://github.com/catppuccin), for the soothing pastel theme. The
warmest flavors one could ask for.
