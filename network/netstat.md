### Outbound connections

```bash
sudo netstat -nputw
```

or

```bash
sudo netstat -nputwc
```

### Outbound connections - IPs only

```bash
sudo netstat -nputw | tr -s ' ' | cut -f5 -d ' ' | grep -v '127.0.0.1'
```

