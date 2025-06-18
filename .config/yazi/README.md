
# Plugin installation

These are instructions for after installing the latest version of yazi with the plugins in this config. Keep in mind Yazi plugins are in beta.

To install:

```bash
ya pack -a yazi-rs/plugins:git
ya pack -a yazi-rs/plugins:mount
ya pack -a dedukun/bookmarks
```

To view mounted systems, press <kbd>M</kbd>.

## Troubleshooting

If there are issues with the plugins above, check:

- You meet the minimum requirements for each plugin. Likely, yazi is updated.
- You're on the latest plugin updates with `ya pkg -u` or in older versions `ya pack -u` if you update yazi.

## Plugin info
In general, the readme's can be very helpful. For this config, you can see them in:

Unix-like systems (Linux, MacOS):
```sh
~/.config/yazi/plugins/mount.yazi/README.md
~/.config/yazi/plugins/git.yazi/README.md
~/.config/yazi/plugins/bookmarks.yazi/README.md # according to this, as of 2025-2-18, latest version of yazi is required
```

Windows:
```bat
%AppData%\yazi\config\plugins\mount.yazi\README.md
%AppData%\yazi\config\plugins\git.yazi\README.md
%AppData%\yazi\config\plugins\bookmarks.yazi\README.md
```

Above mount.yazi, git.yazi, and general plugin documentation are available here: https://github.com/yazi-rs/plugins

Plugin list (contains bookmark.yazi): [Resources \| Yazi](https://yazi-rs.github.io/docs/resources/)

# Where is the default config so I don't waste time?

https://github.com/sxyazi/yazi/tree/main/yazi-config/preset

Locally with git or [fgit (git helper)](https://github.com/FrostyNick/fgit):
`fgit https://github.com/sxyazi/yazi yazi-config/preset`
<!-- `~/p/yazi/yazi-config/preset/yazi-default.toml` -->

