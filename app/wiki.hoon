:: wiki
/?  314
/-  wiki
/+  frontmatter
[wiki .]
!:
|%
++  move  {bone card}
++  card
  $%
    {$info wire @p toro}
    {$diff $wiki-change delt}
    {$diff $json *}
    {$warp wire sock riff}
  ==
--
::
|_  {hid/bowl articles/(map @t *) initialized/_|}
++  prep  _`.  :: wipe state when app code is changed
:: save an updated wiki, or request
++  poke-wiki-change
  |=  a/delt
  ^-  {(list move) _+>.$}
  ~|  poked-with=a
  =+  pax=(path-from-article art.a)
  =+  w=(read-wiki art.a)
  :_  +>.$
  ?:  =(ver.a "")
    :: read request - just return existing content
    %+  turn  (prey /wiki/article/content hid)
    |=({o/bone *} `move`[o %diff %wiki-change w])
  :: write request - do a version check
  ?.  =(ver.a ver.w)
    ~|  %version-check-failed
    !!
  %+  write-md  pax
  %-  nule
  %+  print:frontmatter
    (article-header a)
  %-  lune
  %-  crip
  :: add newline at end only if it doesn't already end with a newline
  ?:  =((scag 1 (flop cot.a)) "\0a")
    cot.a
  (weld cot.a "\0a")
::
++  peer-wiki-article
  |=  pax/path
  ^-  {(list move) _+>.$}
  ~&  [%subscribed-to pax=pax]
  ?.  =(pax /list)
    [~ +>.$]
  (get-articles wiki-base-path-full)
::
++  wiki-base-path
  `path`/web/pages/wiki/pub
::
++  wiki-base-path-full
  %-  tope
  %-  beam
  :_  (flop wiki-base-path)
  (beak our.hid %home da+now.hid)
::
++  path-from-article
  |=  art/tape
  ^-  path
  =+  ^-  ext/path  [(crip (escape art)) %md ~]
  (weld wiki-base-path-full ext)
::
++  article-header
  |=  a/delt
  ^-  (map cord cord)
  :: increment version
  =+  ver=(scot %ud +((scan ver.a dem:ag)))
  %-  malt
  %-  limo
  :*
    [%author (scot %p src.hid)]
    [%at (scot %da now.hid)]
    [%article (crip art.a)]
    [%version ver]
    ~
  ==
::
++  read-wiki
  |=  art/path
  ^-  delt
  =+  pax=(path-from-article art)
  =+  maybe=(file pax)
  ?~  maybe
    :: article doesn't - exist, return a default structure
    [(scow %p src.hid) now.hid art "" "0"]
  =+  v=(need maybe)
  ?>  ?=(@t v)
  =+  ^-  u/@t  v
  =+  [atr mud]=(parse:frontmatter (lore u))
  =+  aut=(trip (need (~(get by atr) 'author')))
  =+  at=(need (slaw %da (need (~(get by atr) 'at'))))
  =+  art=(trip (need (~(get by atr) 'article')))
  =+  ver=(trip (need (~(get by atr) 'version')))
  :*
    aut
    at
    art
    (trip mud)
    ver
  ==
::
++  read
  |=  pax/path
  ~&  read-pax=pax
  =+  v=(need (file pax))
  ?>  ?=(@t v)
  =+  ^-  u/@t  v
  [~ +>.$]
::
++  write-md
  |=  {pax/path cot/cord}
  (write pax [%md !>(cot)])
::
++  write
  |=  {pax/path val/cage}
  =+  wr=(foal pax val)
  [ost.hid %info /writing our.hid wr]~
::
++  watch-dir
  |=  a/path
  ^-  (list move)
  :~  :-  ost.hid
    :^    %warp
        a
      [our.hid our.hid]
    :-  %home
    :-  ~
    [%next %y da+now.hid a]
  ==
::
++  writ
  |=  {way/wire rot/riot}
  =.  initialized  |
  (get-articles wiki-base-path-full)
::
++  escape
  |=  a/tape
  ^-  tape
  ?~  a
    ~
  (welp (escape-char -.a) (escape +.a))
::
++  escape-char
  |=  c/@
  ?:  =(c '/')
    "~2f"
  ?:  =(c '~')
    "~7e"
  [c ~]
::
++  unescape
  |=  a/@t
  ^-  @t
  ?:  =(a '')
    ''
  =+  first=(end 3 1 a)
  ?.  =(first '~')
    (cat 3 first $(a (rsh 3 1 a)))
  =+  code=(end 3 2 (rsh 3 1 a))
  %-  cat
  :-  3
  :_  $(a (rsh 3 3 a))
  ?:  =(code '2f')  '/'
  ?:  =(code '7e')  '~'
  ~|  [%bad-sequence code=`@t`code]
  !!
::
:: get cached article list, initialize if needed
++  get-articles
  |=  pax/path
  ^-  {(list move) _+>.$}
  ?.  initialized
    =.  initialized  &
    =.  articles  %-  list-dir
    pax
    =+  res=$
    [(welp -.res (watch-dir wiki-base-path)) +.res]
  =+  arts=(~(tap by articles) ~)
  =+  arts2=(turn arts |=({p/@t q/*} [(unescape p) ~]))
  :_  +>.$
  %+  turn  (prey /wiki/article/list hid)
  |=({o/bone *} `move`[o %diff %json (jobe arts2)])
::
::  get directory listing (for md files) once
++  list-dir
  |=  pax/path
  ^-  _articles
  =+  ls=.^(arch %cy pax)
  %-  ~(urn by dir.ls)
  |=  {p/knot q/$~}
  =+  a=.^(noun cx+(welp pax [p] [%md] ~))
  ?.  ?=(@t a)
    ~
  =+  [atr mud]=(parse:frontmatter (lore a))
  atr
--
