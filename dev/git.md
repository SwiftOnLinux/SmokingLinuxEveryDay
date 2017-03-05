### Adding Submodules to a Git Repository
```bash
git submodule add git@github.com:openssl/openssl.git
```

### Using Submodules
```bash
git submodule init
git submodule update
```

### Pull latest of all submodules
```bash
git pull --recurse-submodules
git submodule update --recursive --remote
```

### Ignore changes in git submodules

* Edit .gitmodules file
* Append this line to each submodule:
```bash
ignore = dirty
```

e.g.
```bash
[submodule "openssl"]
	path = openssl
	url = git@github.com:openssl/openssl.git
	ignore = dirty
```


