# producer — a haus desktop for people who make sound

A [haus](https://hausfold.co/haus) **desktop**: one data-only file that says what
a Mac should feel like. Read `producer.nix` — it is the whole thing, it installs
nothing on its own, and it cannot run code.

```sh
haus show github:hausfold/producer-desktop     # read it before you run it
haus add  github:hausfold/producer-desktop     # pin it and select it
haus rebuild
```

> **Needs a haus that carries
> [hausfold/haus#476](https://github.com/hausfold/haus/pull/476)** — the change
> that lets a desktop set `haus.launcher.items` at all. On anything older,
> `haus show` refuses this file with *"is not a plain item id"*. Run
> `nix flake update haus` first, or delete the `launcher.items` block from
> `producer.nix` and keep everything else.

## Who it's for

Someone whose Mac is a studio. Ableton Live is open most of the day, iZotope RX
opens on top of it to repair a take, DaVinci Resolve bookends the session, and
the browser is where the reference footage comes from. Not a developer, and not
interested in becoming one in order to use their computer.

It assumes you already own and have installed your creative apps. It installs
none of them, on purpose — see [What it deliberately does not
do](#what-it-deliberately-does-not-do).

## Rooms it turns on

| Room | Why |
|---|---|
| **Launcher** (pounce), on ⌘Space | The palette. What the room adds over the standalone Homebrew install is wiring, not the app: the daemon as a login item, ⌘Space actually taken back from Spotlight, and the Accessibility grant surviving a rebuild. Find Files gets the alias `ff` and a key of its own, **⌥Space**; clipboard history gets `cb`. |
| **Shelf** (perch) | The notch becomes a place to park a rendered stem, a trimmed clip or a grabbed frame while you switch apps. Every step of a sound-redesign pass is a file moving between two applications that have no idea the other exists. New screenshots reach it too, once you have pointed perch at your screenshots folder (a one-time pick). |
| **Focus**, with two scenes | `studio` — Do Not Disturb on, and the Mac stays awake through a long take or a long render. `watch` — the display stays up through a two-hour film, notifications left exactly as they were. Both are entered by hand, from the palette or the bar pill. |
| **Bar** | Clock, weather, battery, Wi-Fi and now-playing (the room's own defaults), plus volume, CPU, memory and a coffee pill. Spectral repair and a Resolve export are the two things on this machine worth watching a graph for. |
| **Video player** (IINA) | Takes over mp4/mkv/avi and ten more. The reference rips are `.mkv`, which QuickTime cannot open at all. |
| **Touch ID**, including for `haus rebuild` | Without the second half, every rebuild stops and waits for a `sudo` password in a terminal you do not otherwise open. |

## Rooms it deliberately leaves off

This is the half you cannot reconstruct from the file.

- **Windows — the tiler, and with it the leader key.** The decision that
  determines whether this feels like a gift or a hijacking. Ableton, RX and
  Resolve are full-screen, single-window applications with dense keyboard
  vocabularies of their own; tiling has nothing to arrange, and remapping
  **Caps Lock** on a Mac somebody already works on every day is a change they
  did not ask for. With the room off, `haus.keys.leader` claims nothing and
  Caps Lock stays Caps Lock.
- **Development, and AI with it.** No shell toolbelt, no coding agents, no
  terminal room. AI follows development rather than leading it.
- **`theme.ports`.** It writes theme files into lazygit, fzf and yazi — none of
  which this desktop installs. Same reason haus's own `minimal` leaves it off.
- **Zen (the browser).** Which browser you use is not a desktop's business.

Turn any of them on in your host file with a plain assignment. Nothing here
needs `lib.mkForce` to override.

## The strong opinions, stated

Things that will surprise muscle memory, or that reach further than a rebuild:

- **⌘Space is taken from Spotlight** and given to the palette.
- **⌥Space is claimed globally** for Find Files. It is free on a machine with no
  leader key — and it is exactly the chord `haus.keys.leader = "alt-space"`
  wants, so turning the tiler on later means moving one of the two.
- **IINA becomes the default application** for mp4, m4v, mov, mpg, mpeg, mkv,
  webm, avi, wmv, flv, 3gp, ogv and vob.
- **The desktop picture is replaced** with the generated haus look. Your current
  one is not deleted, but macOS keeps no record of it — set
  `haus.wallpaper.style = "none"` in your host before the first rebuild if you
  want to keep yours.
- **The startup chime is silenced.** This one is firmware state (`nvram
  StartupMute`), not a preference: it survives an OS reinstall and a wiped home
  directory. A Mac booting at full chime volume with the monitors up is the
  studio's oldest jump scare, but undoing it means setting
  `haus.sound.startupChime = true` and rebuilding, not deleting this desktop.
- **UI sounds and volume-key feedback are off**, and the alert beep drops to 25.
  Those noises go out of the same monitors the mix does, and into a screen
  recording. The beep is quietened rather than silenced, so errors still make a
  sound.
- **The screenshot preview thumbnail is off**, so captures write immediately.
  With the shelf on, the file arriving in the notch *is* the preview.
- The monospace size is set to 19 and the accent colour to **teal** — the one
  accent that stays legible against the ambers and reds every DAW uses for clips
  and for clipping.

## The one list-typed option it sets

`haus.tour.steps` — a single step. A host that names `tour.steps` at all
**replaces the list whole** rather than appending to it, so restate this entry
if you add your own:

```nix
{ hint = "press {palette}, type ff, hit ↵ — that's Find Files, from anywhere"; detect = "palette"; }
```

One step is on purpose: with the tiler off, `palette` is the only signal the
tour can detect, so a second step would either complete itself instantly or sit
there waiting to be clicked past.

## What it deliberately does not do

- **It installs no creative apps.** Ableton, RX and Resolve are already on your
  Mac and already licensed; haus has nothing to add by taking over Homebrew's
  ownership of them. `haus.homebrew.cleanup` is left at its default (`"none"`),
  so nothing you installed yourself is ever removed by a rebuild.
- **It does not name your audio interface.** Which box is plugged in is a fact
  about one machine, not a taste a desktop can share. The `studio` scene will
  switch the system input for you once you name it in your host:

  ```nix
  # the exact string `SwitchAudioSource -a -t input` prints
  haus.focus.scenes.studio.audio.input = "Scarlett 2i2 USB";
  ```
- **It grants no permissions.** After the first rebuild, macOS will ask for
  Accessibility for pounce, and perch needs you to pick your screenshots folder
  once so it can mint the security-scoped bookmark for it. Nothing declarative
  can do either for you.
- **It sets no identity, no secrets and nothing about your hardware.** Those
  belong in your host file, which is the file that also beats every line here.

## If you are coming from the Homebrew pounce

The launcher room installs and runs its own pounce, so stop the Homebrew one
first or the two will fight over ⌘Space:

```sh
brew services stop pounce
brew uninstall pounce
```

Your own commands in `~/.config/pounce/commands` are untouched by any of this —
the daemon still discovers them there.

## Tested against

- haus `5b90f34` (2026-08-23) — the head of hausfold/haus#476 — `VERSION` 2026.08.22.
- `haus show ./producer.nix` passes: **a desktop — data only, and haus checked
  it**, 33 options across 8 rooms.
- A real host evaluates: a consumer flake pinning this file as a `flake = false`
  input and selecting it through `mkHaus` resolves a full
  `system.build.toplevel`, with a host's own
  `focus.scenes.studio.audio.input` overriding it as designed.
- **Not yet run on a Mac.** Evaluated, not lived in.

## License

MIT — see [LICENSE](./LICENSE).
