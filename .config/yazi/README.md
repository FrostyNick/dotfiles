
# Plugin installation

These are instructions for after installing the latest version of yazi with the plugins in this config. Keep in mind yazi plugins are in beta. You might want to frequently update plugins.

To install:

```bash
ya pack -a yazi-rs/plugins:git
ya pack -a yazi-rs/plugins:mount
ya pack -a dedukun/bookmarks
```

To view mounted systems, press <kbd>M</kbd>.

## Plugin info + troubleshooting

If there are issues with the git or mount plugins, make sure you have the minimum requirements for each plugin. In general the readme's are helpful! On Unix systems, you can check the concise documentation in:

```txt
~/.config/yazi/plugins/mount.yazi/README.md
~/.config/yazi/plugins/git.yazi/README.md
~/.config/yazi/plugins/bookmarks.yazi/README.md # according to this, as of 2025-2-18, latest version of yazi is required
```

Above mount.yazi, git.yazi, and general plugin documentation are available here: https://github.com/yazi-rs/plugins

Plugin list (contains bookmark.yazi): [Resources \| Yazi](https://yazi-rs.github.io/docs/resources/)

# Where is the default config so I don't waste time?

If you don't have it already get it from here (I put [fgit](https://github.com/FrostyNick/fgit) for my own convinience which assumes ~/p project path. This is just a git clone helper and you could just git clone everything instead.):
`fgit https://github.com/sxyazi/yazi yazi-config/preset`

If you git cloned it in `~/p`, the default configuration would be saved in:
`~/p/yazi/yazi-config/preset/yazi-default.toml`

