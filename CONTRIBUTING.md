<p align="center"><img src="docs/rift-store-wide.png" alt="Rift Store" width="800"></p>

# Add your app to the Rift Store

The **Rift Store** is the homebrew store built into
[RiftWii](https://github.com/KakarottoCake/Riftwii) (Settings > Online >
Rift Store). Every app in it comes from this repository: one small file
per app, reviewed in a pull request.

We never host your app. The list points at **your own release file**
and locks it by its checksum (SHA-256), so a Wii only ever installs the
exact file a maintainer approved. When you publish a new version, the
store picks it up for you (see [Updates](#updates)).

---

## Before you start

Your app needs:

- [ ] **A release file you published**: a `.zip` (or a lone `.dol`) on a
      GitHub release, or at a fixed address on your own site. GitHub
      releases are best: updates then reach the store on their own.
- [ ] **A `boot.dol` or `boot.elf` that ends up in `apps/<id>/`** on the
      SD card. Put a `meta.xml` and an `icon.png` (the Homebrew Channel's
      128x48 icon) next to it: the store shows that icon.
- [ ] **Public source code**, or a stated reason why not (then expect a
      closer review).
- [ ] **No copyrighted game data**, and nothing its owner had taken down.
- [ ] It **starts** on a Wii, a Wii U in Wii mode or a Wii mini (Dolphin
      is fine for checking).

The full rules are in [CONTENT-RULES.md](CONTENT-RULES.md). Apps made
with AI help are welcome; what counts is that they work.

---

## 1. Write your app's file

Fork this repository and add **`apps/<id>.json`**. The `id` is your app's
folder on the SD card (`sd:/apps/<id>/`). Copying a similar app's file
is the quickest start. A GitHub release looks like this:

```json
{
  "id": "myapp",
  "name": "My App",
  "author": "Your Name",
  "category": "games",
  "description": "One line that says what it does.",
  "license": "GPL-3.0",
  "page": "https://github.com/you/myapp",
  "platforms": ["wii", "vwii", "mini"],
  "source": {"github": "you/myapp", "asset": "MyApp-*.zip"},
  "format": "zip",
  "install": [
    {"from": "apps/myapp/", "to": "apps/myapp/"}
  ],
  "pin": {"tag": "1.0.0", "sha256": "…"}
}
```

| Field | What to put |
| --- | --- |
| `id` | Your folder name: letters, digits and `-_ .+()!`, at most 47 characters. |
| `name`, `author` | As players should see them (at most 63 characters each). |
| `category` | One of `games`, `emulators`, `media`, `internet`, `online`, `gametools`, `loaders`, `system`, `wiimenu`, `controllers`, `creative`, `toys`. |
| `description` | **One line** (at most 159 characters) that says what the app does, not its name again. |
| `license` | Optional: an SPDX id such as `GPL-3.0`, `MIT`. |
| `page` | Your app's page (`https://`). The store shows it as a QR code. |
| `platforms` | Any of `wii`, `vwii`, `mini`: where it works. |
| `source` | GitHub: `{"github": "owner/repo", "asset": "<pattern>"}`, where the pattern matches **exactly one** file of the release. Elsewhere: `{"url": "https://…", "version": "1.0", "released": "YYYY-MM-DD"}`. |
| `install` | Zip only: where the zip's folders go. `from` is a folder in the zip (ending in `/`), `to` is `apps/<id>/` or one of your `data_folders`. If your zip's top folder has a version in it, `*` matches it: `"*/apps/myapp/"`. |
| `data_folders` | Optional: folders at the card's root your app keeps saves or settings in (`["myapp"]`). Removing the app keeps them. |
| `newer` | Optional: the `id` of a listed app that does the same job and is better kept up. |

The complete reference is RiftWii's
[docs/APPSTORE.md](https://github.com/KakarottoCake/Riftwii/blob/main/docs/APPSTORE.md).

---

## 2. Lock your release (the `pin`)

The `pin` is how the store knows the file is the one you meant. It holds
the release's **tag** and the file's **SHA-256**. Pick either way:

**With RiftWii's tool** (writes the pin for you, from a RiftWii checkout):

```
python3 tools/app_list.py update path/to/your/apps-fork/apps myapp
```

**By hand**: download your release file, then get its SHA-256:

| System | Command |
| --- | --- |
| Windows (PowerShell) | `(Get-FileHash .\MyApp-1.0.0.zip -Algorithm SHA256).Hash.ToLower()` |
| macOS | `shasum -a 256 MyApp-1.0.0.zip` |
| Linux | `sha256sum MyApp-1.0.0.zip` |

and write `"pin": {"tag": "1.0.0", "sha256": "<the 64 characters>"}`
(for a `url` source, only `sha256`).

---

## 3. Open a pull request

Open it against `main` and fill in the checklist. The **validate** check
then does what a Wii would do: downloads your file, checks it against the
pin, unpacks it by your install rules, and reads the whole list back with
RiftWii's own parser. If it fails, its log says why. The usual ones:

| The check says | What to change |
| --- | --- |
| `no approved pin` | Add the `pin` (step 2). |
| `the download is not the approved file` | The SHA-256 is of a different file, or the release file was replaced: pin it again. |
| `… assets match` | Make `asset` match exactly one file of the release. |
| `puts no boot.dol` | Your `install` rules miss the folder with `boot.dol`; look inside the zip and fix `from`. |
| a data folder is refused | Folders the Wii or loaders own (`apps`, `private`, `title`, `wbfs`, `games`, `riftwii`, …) can't be data folders. |
| a field is too long | Shorten it (see the table above). |

A maintainer then tries the app and reviews it. Once the pull request is
merged, the app is in the Rift Store **within a few minutes**: every Wii
sees it the next time the store opens.

---

## Updates

- **GitHub releases**: nothing to do. Once a day the list is moved to each
  app's newest release, in one pull request a maintainer checks and
  merges.
- **Elsewhere**: open a pull request with the new `url`, `version`,
  `released` and `pin`.

## No releases? Nightly builds

If your app is only built from source, ask in an issue: RiftWii can run a
daily build of your main branch (like
[snes9xrx-nightly](https://github.com/RiftWii/snes9xrx-nightly)) and the
store follows it.

## Questions, problems, takedowns

Open an issue. An app is removed when its author asks.
