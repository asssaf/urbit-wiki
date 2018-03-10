# urbit-wiki
[![package hash](https://img.shields.io/badge/dynamic/json.svg?label=%package%20hash&colorB=008bb8&prefix=&suffix=&query=$.hash&uri=https://raw.githubusercontent.com/asssaf/urbit-wiki/master/package.json)](https://raw.githubusercontent.com/asssaf/urbit-wiki/master/package.json)
[![sync ship](https://img.shields.io/badge/dynamic/json.svg?label=sync%20ship&colorB=008bb8&prefix=&suffix=&query=$.our&uri=https://dist.u.replaythat.com/pages/badge.json)](#urbit-sync)

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
You can sync from the `%dist-wiki` desk on ![ship](https://img.shields.io/badge/dynamic/json.svg?label=ship&colorB=008bb8&prefix=&suffix=&query=$.our&uri=https://dist.u.replaythat.com/pages/badge.json).
```
dojo> |sync %home ~dist-ship %dist-wiki
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

## Export
```
dojo> :wiki [%export %/backup/wiki-articles]
```

## Import
```
dojo> :wiki [%import %/backup/wiki-articles]
```
