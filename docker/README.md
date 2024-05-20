# Docker & Rancher Desktop

## Fix Rancher Desktop docker compose file access permission issue

Edit (or create) the file 

Edit (or create) the file


```
~/Library/Application\ Support/rancher-desktop/lima/_config/override.yaml
```

and add this configuration to set specific permission properties

```
mountType: 9p
mounts:
  - location: "~"
    9p:
      securityModel: mapped-xattr
      cache: "mmap"
```

