window.urb.appl = "wiki"
debugEnabled = true

function debug(arg) {
  if (debugEnabled) {
    console.log(arg)
  }
}

function bindPath(path, callback) {
  window.urb.bind("/wiki/" + path, callback)
}

function dropPath(path, callback) {
  window.urb.drop("/wiki/"  + path, callback)
}

function articlePath(path) {
  return "article/" + path
}

function poke(article, callback) {
  window.urb.send(
    article,
    {mark: "wiki-change"},
    (err,res) => {
      if (err) {
        debug(err)
        //this.error = "There was an error. Sorry!"

      } else if(res.data !== undefined &&
         res.data.ok !== undefined &&
         res.data.ok !== true) {

        debug(res.data.res)
        //this.error = res.data.res

      } else {
        if (callback) {
          callback()
        }
      }
    })
}

function load(article) {
  poke({
    "article": article,
    "content": "",
    "version": "",
  })
}

function render(content) {
  // replace internal links
  var linkPattern = /\[\[([^\]]*)\]\]/
  var parts = content.split(linkPattern)
  content = ""
  for (i in parts) {
    if (i % 2 == 1) {
      var escaped = encodeURIComponent(parts[i])
      content += "[" + parts[i] + "](wiki#/view/" + escaped + ")"

    } else {
      content += parts[i]
    }
  }

  return marked(content)
}


const Main = {
  template: `
    <div>
      <h1>Articles</h1>
      <div v-if="$root.dukeOrBetter">
        <input v-model.trim="newArticle" />
        <button @click="editNewArticle" :disabled="newArticleDisabled">New</button>
      </div>
      <div v-else>
        <button title="Duke rank (planet) or higher required to create new articles" disabled="true">New</button>
      </div>
      <ul v-for="article in articles">
        <li><router-link :to="{ name: 'view', params: { article: article } }">{{ article }}</router-link></li>
      </ul>
      <div v-if="loading">Loading...</div>
      <div v-else-if="articles.length == 0">
        No articles found
      </div>
    </div>
  `,
  data: function() {
    return  {
      newArticle: "",
    }
  },
  computed: {
    newArticleDisabled: function() {
      if (this.newArticle.length == 0) {
        return true
      }

      return false
    },
    loading: function() {
      return this.$root.articlesLoading
    },
    articles: function() {
      return this.$root.articles
    }
  },
  methods: {
    editNewArticle: function() {
      this.$router.push({ name: "edit", params: { article: this.newArticle } })
    }
  }
}


const Edit = {
  props: [ "article" ],
  template: `
    <div>
      <nav-bar :article="article" :is-edit="true" />

      <h1>Edit {{ article }}</h1>
      <div>
        <small>as ~{{ $root.user }}</small>
      </div>
      <div>
        <textarea cols="80" rows="25" v-model="content" :disabled="loading" />
      </div>
      <div>
        <button @click="preview">Preview</button>
        <button @click="save" :disabled="loading || changedOnServer">Save</button>
        <button @click="back(false)">Cancel</button>
      </div>

      <div v-if="changedOnServer">
        Warning: a newer version has been saved, you'll need to reload before
        saving your changes
      </div>

      <div>{{ error }}</div>

      <div v-if="previewContent">
        <h2>Preview</h2>
        <div v-html="previewContent" style="border: 1px solid black" />
      </div>
    </div>
  `,
  data: function() {
    return {
      loading: true,
      content: "loading...",
      version: null,
      error: null,
      listenerKey: null,
      previewContent: null,
      changedOnServer: false
    }
  },
  created: function() {
    this.listenerKey = this.$root.addArticleListener(this.accept)
    load(this.article)
  },
  destroyed: function() {
    if (this.listenerKey) {
      this.$root.removeArticleListener(this.listenerKey)
    }
  },
  beforeRouteUpdate: function(to, from, next) {
    this.loading = true
    load(to.params.article)
    next()
  },
  methods: {
    accept: function(err, dat) {
      if (dat.data.article != this.article) {
        return
      }
      if (!this.loading) {
        if (dat.data.version != this.version) {
          this.changedOnServer = true
        }
        return
      }
      this.content = dat.data.content
      this.version = dat.data.version
      this.loading = false
      this.changedOnServer = false
    },
    preview: function() {
      this.previewContent = render(this.content)
    },
    save: function() {
      poke({
        "article": this.article,
        "content": this.content,
        "version": this.version,
      }, () => {
        this.back(true)
      })
    },
    back: function(saved) {
      if (this.version == "0" && !saved) {
        this.$router.push({ path: "/"} )

      } else {
        this.$router.push({ name: "view", params: { article: this.article } })
      }
    }
  }
}


const View = {
  props: [ "article" ],
  template: `
    <div>
      <nav-bar :article="article" :is-edit="false" :author="author" :at="at" />

      <h1>{{ article }}</h1>
      <div v-if="loading">
        Loading...
      </div>
      <div v-else v-html="contentRendered" />
    </div>
  `,
  data: function() {
    return {
      loading: true,
      content: null,
      author: null,
      at: null,
      listenerKey: null
    }
  },
  computed: {
    contentRendered: function() {
      if (this.content == null) {
        return "Loading..."
      }

      return render(this.content)
    }
  },
  created: function() {
    this.listenerKey = this.$root.addArticleListener(this.accept)
    load(this.article)
  },
  destroyed: function() {
    if (this.listenerKey) {
      this.$root.removeArticleListener(this.listenerKey)
    }
  },
  beforeRouteUpdate: function(to, from, next) {
    this.loading = true
    load(to.params.article)
    next()
  },
  methods: {
    accept: function(err, dat) {
      if (dat.data.article != this.article) {
        return
      }
      if (dat.data.version == "0") {
        this.edit()
        return
      }
      this.content = dat.data.content
      this.author = dat.data.author
      this.at = new Date(dat.data.at).toString()
      this.loading = false
    },
    edit: function() {
      this.$router.push({ name: "edit", params: { article: this.article } })
    }
  }
}


Vue.component('nav-bar', {
  props: [ "article", "isEdit", "author", "at"],
  template: `
  <small>
    <router-link to="/">Home</router-link>
    <span v-if="!isEdit">
      |
      <span v-if="$root.dukeOrBetter">
        <a @click.prevent="edit" href="#">Edit</a>
      </span>
      <span v-else>
        <span title="Duke rank (planet) or higher required to edit">Edit (?)</span>
      </span>
    </span>
    <span v-if="author">
      | Last edit by: {{ author }}
      (at: {{ at }})
    </span>
  </small>
  `,
  methods: {
    edit: function() {
      this.$router.push({ name: "edit", params: { article: this.article } })
    }
  }
})


const routes = [
  { path: '/', component: Main },
  { name: 'edit', path: '/edit/:article', component: Edit, props: true },
  { name: 'view', path: '/view/:article', component: View, props: true }
]


const router = new VueRouter({
  routes // short for `routes: routes`
})


const app = new Vue({
  router,
  data: function() {
    return {
      articleListeners: [],
      articles: [],
      articlesLoading: true,
      id: 1
    }
  },
  computed: {
    user: function() {
      return window.urb.user
    },
    dukeOrBetter: function() {
      return window.urb.user.length <= 7
    }
  },
  created: function() {
    bindPath("article/content", this.accept)
    bindPath("article/list", this.acceptList)
  },
  destroyed: function() {
    this.articleListeners = []
    dropPath("article/content", this.accept)
    dropPath("article/list", this.acceptList)
  },
  methods: {
    accept: function(err, dat) {
      keys = Object.keys(this.articleListeners)
      for (i in this.articleListeners) {
        this.articleListeners[i](err, dat)
      }
    },
    acceptList: function(err, dat) {
      this.articles = Object.keys(dat.data)
      this.articlesLoading = false
    },
    addArticleListener: function(callback) {
      this.articleListeners["" + this.id] = callback
      return this.id++
    },
    removeArticleListener: function(id) {
      delete this.articleListeners["" + id]
    }
  }
}).$mount('#app')
