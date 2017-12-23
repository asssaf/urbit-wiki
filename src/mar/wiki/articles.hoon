/-  wiki
[wiki .]
=,  enjs:format
=,  mimes:html
!:
|_  {articles/(list delt)}
++  grab
  |%
  ++  noun  (list delt)
  ++  mime  |=(^mime (json (rash q.q apex:de-json:html)))
  ++  json
    |=  jon/^json
    ^-  (list delt)
    (need ((ar (ot author+so at+di article+so content+so version+so message+so ~)):dejs-soft:format jon))
  --
++  grow
  |%
  ++  mime  [/text/wiki-articles (as-octs (crip (en-json:html json)))]
  ++  json
    :-  %a
    %+  turn  articles
    |=  article/delt
    %-  pairs
    :*
      [%author (tape (trip aut.article))]
      [%at (time ?:(=(at.article *@da) ~1970.1.1 at.article))]
      [%article (tape (trip art.article))]
      [%content (tape (trip cot.article))]
      [%version (tape (trip ver.article))]
      [%message (tape (trip msg.article))]
      ~
    ==
  --
--
