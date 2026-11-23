# What gets in

The list is for homebrew that works and is safe to put on a player's SD
card. The maintainers review every app against these rules.

## Yes

- Apps that run on a Wii, a Wii U in Wii mode, or a Wii Mini.
- Older apps next to newer ones that do the same job: the newer one is
  named in the older one's `newer`, and both stay listed.
- Apps made with AI assistance. How an app was written is not a reason to
  leave it out; whether it works is.

## No

- **Malware**, or anything that hides what it does.
- **Copyrighted game data**: an app may need the player's own files (a
  game's WAD, a ROM), but it must not ship them.
- **Anything built around something its owner had taken down.**
- **Apps without source**, unless there is a stated reason (and then a
  closer review).
- **Broken apps**: a download that is gone, or an app that does not start.
- **Installs that reach outside the app**: an app writes only to
  `apps/<id>/` and the data folders it names. Folders the Wii, RiftWii or
  other loaders own are refused by the check.

## Takedowns

An app is removed when its author asks, or on a valid takedown request.
Open an issue.
