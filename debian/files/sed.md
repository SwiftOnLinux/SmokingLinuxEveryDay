### Words boundaries
*e.g. match spaces: word1 word2*
```bash
sudo sed -i 's/word1.*word2/word3 word4/' /path/to/file/name
```

### Prepend line (add line before SearchPattern)
```bash
sudo sed -i '/SearchPattern/ithis is a new line' /path/to/file/name
```

### Append line (add line after SearchPattern)
```bash
sudo sed -i '/SearchPattern/athis is a new line' /path/to/file/name
```

