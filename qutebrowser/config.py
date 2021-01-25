# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
config.load_autoconfig()

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Setting dark mode
config.set("colors.webpage.darkmode.enabled", True)

config.set("auto_save.session", True)
config.set("tabs.show", "switching")
config.set('tabs.background', True)
config.set('tabs.show_switching_delay', 2000)

# Search engines which can be used via the address bar. Maps a search
# engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
# placeholder. The placeholder will be replaced by the search term, use
# `{{` and `}}` for literal `{`/`}` signs. The search engine named
# `DEFAULT` is used when `url.auto_search` is turned on and something
# else than a URL was entered to be opened. Other search engines can be
# used by prepending the search engine name to the search term, e.g.
# `:open google qutebrowser`.
# Type: Dict
c.url.searchengines = {'DEFAULT': 'https://duckduckgo.com/?q={}',
                       'aw': 'https://wiki.archlinux.org/index.php?search={}',
                       'aur': 'https://aur.archlinux.org/packages/?O=0&K={}',
                       'vw': 'https://wiki.voidlinux.org/index.php?search={}',
                       'g': 'https://www.google.com/search?q={}'}

# Bindings for normal mode
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('M', 'hint links spawn mpv {hint-url}')
config.bind('b', 'hint all tab-bg')
config.bind('<Ctrl+p>', 'spawn --userscript qute-lastpass')
