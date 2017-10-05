# urbit-wiki

## Description
Wiki for urbit

![wiki demo](https://github.com/asssaf/urbit-wiki/raw/master/wiki.gif "Wiki demo")

## Install
### %package
If you have [%package](https://github.com/asssaf/urbit-package) installed on your urbit in the `%pkg-wiki` desk:
```
dojo> :package|install %pkg "https://raw.githubusercontent.com/asssaf/urbit-wiki/master/package.json"
```

### Urbit Sync
You can sync from `~bidner-hadlev-napler-pittev--livdyl-ritrev-ropwyc-bitpub`'s `%dist-wiki` desk.
```
dojo> |sync %home ~bidner-hadlev-napler-pittev--livdyl-ritrev-ropwyc-bitpub %dist-wiki
```
### Manually
Copy everything into the pier:
```
$ cp -a src/* /path/to/pier/home/
```

## Run
```
dojo> |start %wiki
```

## Configure
By default the wiki stores and serves files from the %home desk. You probably
want to create a separate desk for the wiki. For example:

### Create %wiki desk
```
dojo> |merge %wiki our %home
merged with strategy %init
```

### Configure wiki to serve from the %wiki desk
```
dojo> :wiki [%serve %wiki]
[%serving-from %wiki]
```

## Usage
The wiki main page will be accessible at https://your-ship.urbit.org/pages/wiki

### Wiki format
The wiki pages are written in markdown.  
For internal wiki links use the format `[[other-page]]`

## Storage
All wiki pages are stored at `pier/home/web/pages/wiki/pub`

Since %clay is used for storage, all the history is also preserved.
