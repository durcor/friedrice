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
        'DEFAULT': 'https://duckduckgo.com/?q={}',
        'ddgi': 'https://duckduckgo.com/?q={}&t=h_&iax=images&ia=images',
        'gh': 'https://github.com/search?q={}',
        'ghu': 'https://github.com/search?q={}&type=Users',
        'sp': "https://www.startpage.com/do/search/?q={}",
        'at': "https://alternativeto.net/browse/search?q={}",
        'ext': "https://clients2.google.com/service/update2/crx?response=redirect&prodversion=48.0&x=id%3D{}%26installsource%3Dondemand%26uc",
        'yt': "https://www.youtube.com/results?search_query={}",
        'ytnew': "https://www.youtube.com/results?sp=CAI%253D&search_query={}",
        'sht': "https://share.tube/search?search={}",
        '4c': "https://4chan.org/{}",
        '8c': "https://8ch.net/{}",
        'lc': "https://lainchan.org/{}",
        'ec': "https://endchan.net/{}",
        'ac': "https://arisuchan.jp/{}",
        'dw': "https://distrowatch.com/table.php?distribution={}",
        'ht': "https://hooktube.com/results?search_query={}",
        'in': "https://invidio.us/search?q={}",
        'innew': "https://invidio.us/search?q=sort%3Adate+{}",
        'w': "https://en.wikipedia.org/?search={}",
        'aw': "https://wiki.archlinux.org/?search={}",
        'vw': "https://wiki.voidlinux.eu/?search={}",
        'gw': "https://wiki.gentoo.org/?search={}",
        'igw':  'https://wiki.installgentoo.com/?search={}',
        'surname': 'https://forebears.io/surnames?q={}',
        'name': 'https://behindthename.com/name/{}',
        'bit': 'https://bitchute.com/search/?q={}&sort=date_created+desc',
        'lut': 'https://lutris.net/games/?q={}',
        'arch': 'https://www.archlinux.org/packages/?q={}',
        'aur': 'https://aur.archlinux.org/packages/?O=0&SeB=nd&K={}&outdated=&SB=v&SO=d&PP=250&do_Search=Go',
        'am': 'https://www.amazon.com/s?url=search-alias%3Daps&field-keywords={}',
        'stst': 'https://store.steampowered.com/search/?snr=1_4_4__12&term={}',
        'stc': 'https://steamcommunity.com/search/users/#text={}',
        'wrenes': 'http://www.wordreference.com/redirect/translation.aspx?w={}&dict=enes',
        'wresen': 'http://www.wordreference.com/redirect/translation.aspx?w={}&dict=esen',
        'd': 'http://www.dictionary.com/?override_query={}#',
        'dx': 'http://dir.xiph.org/search?search={}',
        'r': 'https://www.reddit.com/r/{}',
        'ph':'https://www.pornhub.com/video/search?search={}',
        'xv': 'https://www.xvideos.com/?k={}',
        'nv': 'https://www.nudevista.com/?q={}&s=t',
        'sc': 'https://soundcloud.com/search?q={}',
        'li': 'https://www.linkedin.com/search/results/all/?keywords={}',
        'ni': 'https://www.niche.com/search/?q={}',
        'gm': 'https://www.google.com/maps/place/{}'
        }
