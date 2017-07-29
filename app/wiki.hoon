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
::++  prep  _`.  :: wipe state when app code is changed
::
:: save an updated wiki, or request
++  poke-wiki-change
  |=  a/delt
  ^-  {(list move) _+>.$}
  ~|  poked-with=a
  :_  +>.$
  ?:  =(typ.a 'read')
    :: read request - just return existing content
    ?:  =(ver.a 'all')
      (get-history art.a)
    ?.  =(ver.a '')
      :: get specific version
      =+  r=(rash ver.a dem:ag)
      (get-history-for-rev art.a r r ~)
    :: get latest (or empty if doesn't exist)
    =+  w=(read-wiki-immediate art.a)
    %+  turn  (pale hid (prix-and-src /wiki/article/content src.hid))
    |=({o/bone *} `move`[o %diff %wiki-change w])
  :: write request
  :: do a security check - only duke or better allowed
  ?.  ?=(?($czar $king $duke) (clan src.hid))
    ~|  %duke-or-better-required
    !!
  =+  w=(read-wiki-immediate art.a)
  :: do a version check
  ?.  =(ver.a ver.w)
    ~|  %version-check-failed
    !!
  :: increment version
  =+  newver=+((rash ver.w dem:ag))
  %-  welp
  :_  %+  weld
    (create-label (escape-for-label art.a) newver)
    :: since this is a write, notify all clients
    %+  turn  (pale hid (prix /wiki/article/content))
    :: FIXME this doesn't contain the author and date of the change
    |=({o/bone *} `move`[o %diff %wiki-change a(ver (scot %ud newver))])
  =+  pax=(path-from-article art.a)
  (write-wiki a(ver (scot %ud newver)) pax)
::
++  peer-wiki-article
  |=  pax/path
  ^-  {(list move) _+>.$}
  ~&  [%subscribed-to pax=pax]
  ?:  =(pax /list)
    (get-articles wiki-base-path-full)
  [~ +>.$]
::
++  wiki-desk
  %home
::
++  wiki-base-path
  `path`/web/pages/wiki/pub
::
++  wiki-base-path-full
  (wiki-base-path-full-at da+now.hid)
::
++  wiki-base-path-full-at
  |=  at/case
  %-  tope
  %-  beam
  :_  (flop wiki-base-path)
  (beak our.hid wiki-desk at)
::
++  relpath-from-article
  |=  art/cord
  =+  ^-  ext/path  [(escape art) %md ~]
  (weld wiki-base-path ext)
::
++  path-from-article
  |=  art/cord
  (path-from-article-at art da+now.hid)
::
++  path-from-article-at
  |=  {art/cord at/case}
  ^-  path
  =+  ^-  ext/path  [(escape art) %md ~]
  (weld (wiki-base-path-full-at at) ext)
::
++  article-header
  |=  a/delt
  ^-  (map cord cord)
  %-  malt
  %-  limo
  :*
    [%author (scot %p src.hid)]
    [%at (scot %da now.hid)]
    [%article art.a]
    [%version ver.a]
    [%message msg.a]
    ~
  ==
::
++  read-wiki
  |=  {art/cord wir/wire}
  (read-wiki-at art wir da+now.hid)
::
++  read-wiki-at
  |=  {art/cord wir/wire cas/case}
  =+  pax=(relpath-from-article art)
  =+  ^-  rav/rave  [%sing %x cas pax]
  =+  ^-  rif/riff  [wiki-desk (some rav)]
  [ost.hid %warp wir [our.hid our.hid] rif]~
::
++  read-wiki-immediate
  |=  art/cord
  ^-  delt
  =+  pax=(path-from-article art)
  =+  maybe=(file pax)
  ?~  maybe
    :: article doesn't exist, return a default structure
    =+  r=*delt
    r(art art, ver '0')
  =+  v=(need maybe)
  ?.  ?=(@t v)
    ~|  %no-content
    !!
  =+  ^-  u/@t  v
  (parse-wiki u)
::
++  parse-wiki
  |=  u/@t
  ^-  delt
  =+  [atr mud]=(parse:frontmatter (lore u))
  =+  aut=(~(got by atr) 'author')
  =+  at=(slav %da (~(got by atr) 'at'))
  =+  art=(~(got by atr) 'article')
  =+  ver=(~(got by atr) 'version')
  =+  msg=(fall (~(get by atr) 'message') '')
  :*
    aut
    at
    ''
    art
    mud
    ver
    msg
  ==
::
++  write-wiki
  |=  {a/delt pax/path}
  ^-  (list move)
  %+  write-md  pax
  %-  nule
  %+  print:frontmatter
    (article-header a)
  ~[cot.a]
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
        /article/list
      [our.hid our.hid]
    :-  wiki-desk
    :-  ~
    [%next %y da+now.hid a]
  ==
::
++  writ
  |=  {way/wire rot/riot}
  ?:  =(way /article/list)
    =.  initialized  |                                  :: invalidate cache
    (get-articles wiki-base-path-full)
  :: content/history query result
  ?~  rot
    [~ +>.$]
  =+  a=(need rot)
  =+  p=q.a
  =+  u=q.q.r.a
  ?.  ?=(@t u)
    ~&  %no-content
    [~ +>.$]
  =+  w=(parse-wiki u)
  :_  +>.$
  %+  turn  (pale hid (prix-and-src (welp /wiki way) src.hid))
  |=({o/bone *} `move`[o %diff %wiki-change w])
::
++  escape-for-label
  |=  a/@t
  ^-  @tas
  ?:  =(a '')
    ''
  =+  first=(end 3 1 a)
  %-  cat
  :-  3
  :_  $(a (rsh 3 1 a))
  ?:
    ?|
      &((gte first 'a') (lte first 'z'))
      &((gte first '0') (lte first '9'))
    ==
    first
  (cat 3 '-' (scot %ud first))
::
++  escape
  |=  a/@t
  ^-  @t
  ?:  =(a '')
    ''
  =+  first=(end 3 1 a)
  %-  cat
  :-  3
  :_  $(a (rsh 3 1 a))
  ?:  =(first '/')  '~2f'
  ?:  =(first '~')  '~7e'
  first
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
  :: FIXME this should be sent to all clients (only) if cache was rebuilt
  %+  turn  (pale hid (prix /wiki/article/list))
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
::
++  get-history
  |=  art/cord
  ^-  (list move)
  =+  latest=(read-wiki-immediate art)
  ?:  =(ver.latest '0')
    ~&  %no-history
    ~
  =+  rev=(rash ver.latest dem:ag)
  ::  look back for no more than 10 revision
  =+  min=?:((lte rev 10) 1 (sub rev 10))
  (get-history-for-rev art rev min ~)
::
++  get-history-for-rev
  |=  {art/cord rev/@ud min/@ud labels/(unit (map @tas @ud))}
  ^-  (list move)
  ?:  (lth rev min)
    ~
  ?~  labels
    =+  dom=.^(dome cv+wiki-base-path-full)
    $(labels (some lab.dom))
  %-  welp  :_  $(rev (dec rev))
  :: check that the label exists
  =+  label=(label-for-rev (escape-for-label art) rev)
  ?~  (~(get by (need labels)) label)
    ~   ::TODO send default value
  (read-wiki-at art /article/history tas+label)
::
++  label-for-rev
  |=  {art/@t ver/@ud}
  ^-  @tas
  (rap 3 %wiki- art '-' (scot %ud ver) ~)
::
++  create-label
  |=  {art/@t ver/@ud}
  ^-  (list move)
  =+  label=(label-for-rev art ver)
  [ost.hid %info /wiki-label our.hid wiki-desk %| label]~
::
:: filter by path prefix and event source
++  prix-and-src
  |=  {pax/path src/ship}
  (both (prix pax) (bysrc src))
::
++  both  :: filter by two criteria
  |=  {a/$-(sink ?) b/$-(sink ?)}  |=  s/sink  ^-  ?
  &((a s) (b s))
::
++  bysrc            :: filter by src
  |=  src/ship  |=  sink  ^-  ?
  =(q.+< src)
--
