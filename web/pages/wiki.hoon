;html
  ;head
    ;script(type "text/javascript", src "//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js");
    ;script(type "text/javascript", src "/~/at/lib/js/urb.js");
    ;script(type "text/javascript", src "/pages/wiki/vue/vue.js");
    ;script(type "text/javascript", src "/pages/wiki/vue-router/vue-router.js");
    ;script(type "text/javascript", src "/pages/marked/marked.min.js");
    ;title:"Wiki"
    ;style(type "text/css")
      ; #pass-cont { display: none; }
      ; #password { font: monospace; }
    ==
  ==
  ;body
    ;div#app
      ;router-view;
    ==
    ;footer
      ;small
        ;a/"https://github.com/asssaf/urbit-wiki"(target "_blank"): Source
      ==
    ==

    ;script(type "text/javascript", src "/pages/wiki/main.js");
  ==
==
