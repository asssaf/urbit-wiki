# urbit-wiki

## Description
Wiki for urbit

![wiki demo](https://github.com/asssaf/urbit-wiki/raw/gif/wiki.gif "Wiki demo")

## Install
### Makefile
```
$ make DESTDIR=/path/to/pier
```

### Manually
Copy everything into the pier:
```
$ cp -av {app,mar,sur,web} /path/to/pier/home
```

## Configure
Not configurable yet

## Run
```
dojo> |start %wiki
```

## Usage
The wiki main page will be accessible at https://your-ship.urbit.org/pages/wiki

### Wiki format
The wiki pages are written in markdown.  
For internal wiki links use the format `[[other-page]]`

## Storage
All wiki pages are stored at `pier/home/web/pages/wiki/pub`

Since %clay is used for storage, all the history is also preserved.
