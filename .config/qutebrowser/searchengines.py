# ~/.config/qutebrowser/searchengines.py
# vi:ft=python
#
## Search engines which can be used via the address bar. Maps a search
## engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
## placeholder. The placeholder will be replaced by the search term, use
## `{{` and `}}` for literal `{`/`}` signs. The search engine named
## `DEFAULT` is used when `url.auto_search` is turned on and something
## else than a URL was entered to be opened. Other search engines can be
## used by prepending the search engine name to the search term, e.g.
## `:open google qutebrowser`.
## Type: Dict
# c.url.searchengines = {'DEFAULT': 'https://duckduckgo.com/?q={}'}
c.url.searchengines = {
        'sxd': 'https://search.disroot.org/?q={}',
        'sxm': 'https://searx.me/?q={}',
        'ud': 'https://www.urbandictionary.com/define.php?term={}',
        'sxo': 'https://searx.org/?q={}',
        'sxc': 'https://searx.ch/?q={}',
        'ddg': 'https://duckduckgo.com/?q={}',
        'ddgi': 'https://duckduckgo.com/?q={}&t=h_&iax=images&ia=images',
        'gh': 'https://github.com/search?q={}',
        'ghu': 'https://github.com/search?q={}&type=Users',
        'DEFAULT': "https://www.startpage.com/do/search/?q={}",
        'at': "https://alternativeto.net/browse/search?q={}",
        'ext': "https://clients2.google.com/service/update2/crx?response=redirect&prodversion=48.0&x=id%3D{}%26installsource%3Dondemand%26uc",
        'yt': "https://www.youtube.com/results?search_query={}",
        'ytnew': "https://www.youtube.com/results?sp=CAI%253D&search_query={}",
        'st': "https://share.tube/search?search={}",
        'c4': "https://4chan.org/{}",
        'c8': "https://8ch.net/{}",
        'cl': "https://lainchan.org/{}",
        'ce': "https://endchan.net/{}",
        'ca': "https://arisuchan.jp/{}",
        'dw': "https://distrowatch.com/table.php?distribution={}",
        'th': "https://hooktube.com/results?search_query={}",
        'in': "https://invidio.us/search?q={}",
        'innew': "https://invidio.us/search?q=sort%3Adate+{}",
        'w': "https://en.wikipedia.org/?search={}",
        'wa': "https://wiki.archlinux.org/?search={}",
        'wv': "https://wiki.voidlinux.eu/?search={}",
        'wg': "https://wiki.gentoo.org/?search={}",
        'wig':  'https://wiki.installgentoo.com/?search={}',
        'surname': 'https://forebears.io/surnames?q={}',
        'name': 'https://behindthename.com/name/{}',
        'bit': 'https://bitchute.com/search/?q={}&sort=date_created+desc',
        'lut': 'https://lutris.net/games/?q={}',
        'pa': 'https://www.archlinux.org/packages/?q={}',
        'paur': 'https://aur.archlinux.org/packages/?O=0&SeB=nd&K={}&outdated=&SB=v&SO=d&PP=250&do_Search=Go',
        'am': 'https://www.amazon.com/s?url=search-alias%3Daps&field-keywords={}',
        'st': 'https://store.steampowered.com/search/?snr=1_4_4__12&term={}',
        'stu': 'https://steamcommunity.com/search/users/#text={}',
        'enes': 'http://www.wordreference.com/redirect/translation.aspx?w={}&dict=enes',
        'esen': 'http://www.wordreference.com/redirect/translation.aspx?w={}&dict=esen',
        'd': 'http://www.dictionary.com/?override_query={}#',
        'dx': 'http://dir.xiph.org/search?search={}',
        'r': 'https://www.reddit.com/r/{}',
        'ph':'https://www.pornhub.com/video/search?search={}',
        'xv': 'https://www.xvideos.com/?k={}',
        'nv': 'https://www.nudevista.com/?q={}&s=t',
        'sc': 'https://soundcloud.com/search?q={}'
        }
