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
    {$diff drift}
    {$warp wire sock riff}
  ==
++  drift
  $?
    {$wiki-change delt}
    {$wiki-articles (list delt)}
    {$json json}
  ==
++  config
  $%
    {$serve d/desk}
  ==
++  history-callback-state
  {art/cord rev/@ud min/@ud res/(list delt)}
--
::
|_  $:
  hid/bowl
  articles/(list {@t $~})
  initialized/_|
  wiki-desk/_'home'
  rag/(map wire history-callback-state)
==
::++  prep  _`.  :: wipe state when app code is changed
::
:: general configuration interface
++  poke-noun
  |=  a/config
  ?>  (team our.hid src.hid)      :: don't allow strangers
  ?-  a
  {$serve *}
    ?:  =(d.a wiki-desk)
      ~&  [%already-serving-from d.a]
      [~ +>.$]
    :: clear cached article list and unsubscribe from previous desk
    ~&  [%serving-from d.a]
    =+  moves=(unwatch-dir wiki-base-path)
    =.  wiki-desk  d.a
    =.  initialized  |                                  :: invalidate cache
    =+  res=(get-articles wiki-base-path-full)
    [(welp moves -.res) +.res]
  ==
::
:: save an updated wiki, or request
++  poke-wiki-change
  |=  a/delt
  ^-  {(list move) _+>.$}
  ~|  poked-with=a
  :_  +>.$
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
  =+  newver=(get-next-version (escape-for-label art.w) +((rash ver.w dem:ag)))
  =+  a=a(ver (scot %ud newver), at now.hid, aut (scot %p src.hid))
  %-  welp
  :_  %+  weld
    (create-label (escape-for-label art.a) newver)
    :: since this is a write, notify all clients
    (diff-by-path /wiki/article/content %wiki-change a)
  =+  pax=(path-from-article art.a)
  (write-wiki a pax)
::
++  peer-wiki-article
  |=  pax/path
  ^-  {(list move) _+>.$}
  ~&  [%subscribed-to pax=pax]
  ?:  =(pax /list)
    (get-articles wiki-base-path-full)
  ?:  =(-.pax 'content')
    =+  art=(woad (snag 1 pax))
    =+  w=(read-wiki-immediate art)
    :_  +>.$
    (diff-by-ost %wiki-change w)
  ?:  =(-.pax 'history')
    (get-history (snag 1 pax))
  [~ +>.$]
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
    [%author aut.a]
    [%at (scot %da at.a)]
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
++  unwatch-dir
  |=  a/path
  ^-  (list move)
  :~  :-  ost.hid
    :^    %warp
        /article/list
      [our.hid our.hid]
    :-  wiki-desk
    ~
  ==
::
++  writ
  |=  {way/wire rot/riot}
  ?:  =(way /article/list)
    =.  initialized  |                                  :: invalidate cache
    (get-articles wiki-base-path-full)
  :: history query result
  (history-callback way rot)
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
  (cat 3 '-' (scot %ud first))::
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
++  diff-by-path
  |=  {pax/path d/drift}
  %+  turn  (pale hid (prix pax))
  |=({o/bone *} `move`[o %diff d])
::
++  diff-by-src
  |=  {pax/path s/ship d/drift}
  %+  turn  (pale hid (prix-and-src pax s))
  |=({o/bone *} `move`[o %diff d])
::
++  diff-by-ost
  |=  {d/drift}
  [ost.hid %diff d]~
::
:: get cached article list, initialize if needed
++  get-articles
  |=  pax/path
  ^-  {(list move) _+>.$}
  ?.  initialized
    =.  initialized  &
    =.  articles  (list-dir-articles pax)
    :_  +>.$
    %+  welp  (watch-dir wiki-base-path)
    :: since the cache was rebuilt, notify all subscribers
    (diff-by-path /wiki/article/list %json (jobe articles))
  :_  +>.$
  :: since there was no change, notify only the event source
  (diff-by-ost %json (jobe articles))
::
++  list-dir-articles
  |=  pax/path
  ^-  _articles
  %+  murn  (~(tap by (list-dir pax)) ~)
  |=  {p/@t q/*}
  ?~  q
    ~
  (some [(unescape p) ~])
::
::  get directory listing (for md files) once
++  list-dir
  |=  pax/path
  ^-  (map @t *)
  =+  ls=.^(arch %cy pax)
  %-  ~(urn by dir.ls)
  |=  {p/knot q/$~}
  =+  subfil=.^(arch %cy (welp pax p ~))
  ?~  ((soft (map @t *)) dir.subfil)
    ~
  ?.  (~(has by dir.subfil) %md)
    ~
  =+  a=.^(noun cx+(welp pax [p] [%md] ~))
  ?.  ?=(@t a)
    ~
  =+  [atr mud]=(parse:frontmatter (lore a))
  atr
::
++  get-history
  |=  pax/knot
  ^-  (quip move +>)
  =+  way=/article/history/[pax]
  =+  art=(woad pax)
  =+  latest=(read-wiki-immediate art)
  ?:  =(ver.latest '0')
    (history-finish way)
  =+  rev=(rash ver.latest dem:ag)
  ::  look back for no more than 10 revision
  =+  min=?:((lte rev 10) 1 (sub rev 10))
  =+  hist=[art rev min ~]
  (get-history-next way hist)
::
++  get-history-next
  |=  {way/wire hist/history-callback-state}
  =.  rag
  (~(put by rag) way hist)
  (get-history-for-rev way art.hist rev.hist)
::
++  history-callback
  |=  {way/wire rot/riot}
  ^-  (quip move +>)
  =+  his=(~(got by rag) way)
  =+  a=(need rot)
  =+  p=q.a
  =+  u=q.q.r.a
  ?.  ?=(@t u)
    ~&  %no-content
    (history-finish way)
  =+  w=(parse-wiki u)
  =+  res=(welp res.his ~[w])
  ?:  =(rev.his min.his)
    :: finished - return result
    (history-finish way)
  =+  rev=(dec rev.his)
  (get-history-next way his(rev rev, res res))
  ::~
++  history-finish
  |=  way/wire
  ^-  (quip move +>)
  =+  his=(~(get by rag) way)
  =+  res=?~(his ~ res:(need his))
  =.  rag  (~(del by rag) way)
  :_  +>.$
  (diff-by-src (welp /wiki way) src.hid %wiki-articles `(list delt)`res)
::
++  get-history-for-rev
  |=  {way/wire art/cord rev/@ud}
  ^-  (quip move +>)
  =+  dom=.^(dome cv+wiki-base-path-full)
  =+  labels=lab.dom
  :: check that the label exists
  =+  label=(label-for-rev (escape-for-label art) rev)
  ?~  (~(get by labels) label)
    (history-finish way)
  :_  +>.$
  (read-wiki-at art way tas+label)
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
  :: check that label doesn't exist yet
  =+  dom=.^(dome cv+wiki-base-path-full)
  ?^  (~(get by lab.dom) label)
    ~|  [%label-already-exists label=label]
    !!
  [ost.hid %info /wiki-label our.hid wiki-desk %| label]~
::
:: check if the label for the next version is not taken, otherwise increment
++  get-next-version
  |=  {art/@t ver/@ud}
  =+  dom=.^(dome cv+wiki-base-path-full)
  |-
  =+  label=(label-for-rev art ver)
  ?^  (~(get by lab.dom) label)
    $(ver +(ver))
  ver
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
