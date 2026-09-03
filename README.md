# producer: a haus desktop for people who make sound

A [haus](https://hausfold.co/haus) **desktop**: one data-only file that says what
a Mac should feel like. Read `producer.nix`. It is the whole thing, it installs
nothing on its own, and it cannot run code.

```sh
haus show github:hausfold/producer-desktop     # read it before you run it
haus add  github:hausfold/producer-desktop     # pin it and select it
haus rebuild
```

> **Needs haus `v2026.09.02` or newer** — that is where `haus.launcher.plugins`
> arrived. On anything older, `haus show` refuses this file with
> *"haus.launcher.plugins is not a haus option"*. Run `haus update` first, or
> delete the `launcher.plugins` block from `producer.nix` and keep everything
> else.

## Who it's for

Someone whose Mac is a studio. Ableton Live is open most of the day, iZotope RX
opens on top of it to repair a take, DaVinci Resolve bookends the session, and
the browser is where the reference footage comes from. Not a developer, and not
interested in becoming one to use their computer.

It assumes you already own and have installed your creative apps, and it leaves
those alone. What it brings is four free tools that a studio Mac turns out to
need anyway. See [What it installs](#what-it-installs).

## Rooms it turns on

| Room | Why |
|---|---|
| **Launcher** (pounce), on ⌘Space | The palette. What the room adds over the standalone Homebrew install is wiring, not the app: the daemon as a login item, and ⌘Space actually taken back from Spotlight. Drawn at 1.2, because you read it from the mix position rather than leaning over the keyboard. Making the Accessibility grant survive a rebuild takes one more line, and only your host file can carry it: see [the strong opinions](#the-strong-opinions-stated). |
| **Shelf** (perch) | The notch becomes a place to park a rendered stem, a trimmed clip or a grabbed frame while you switch apps. Every step of a sound-redesign pass is a file moving between two applications that have no idea the other exists. New screenshots reach it too, once you have pointed perch at your screenshots folder (a one-time pick). |
| **Focus**, with three scenes | `studio`: Do Not Disturb on, and the Mac stays awake through a long take or a long render. `capture`: the same quiet, and OBS comes up with it. `watch`: the display stays up through a two-hour film, notifications left exactly as they were. All three are entered by hand, **from the palette**. The bar's focus pill is a plain quiet toggle: it can leave a scene, but it has no route into one. |
| **Bar** | Clock, weather, battery, Wi-Fi and now-playing (the room's own defaults), plus volume, CPU, memory and a coffee pill. Spectral repair and a Resolve export are the two things on this machine worth watching a graph for. |
| **Appearance** | Not a room with a switch: it is always present, and what changed is that this desktop now decides it instead of grazing it. Teal, mono at 19, the sound and screenshot settings below, and `theme.ports` on so a themed app you add later is coloured without a second decision. Two deliberate refusals: it does **not** replace your desktop picture, and it does **not** touch macOS's own Light/Dark. |
| **Touch ID**, including for `haus rebuild` | Without the second half, every rebuild stops and waits for a `sudo` password in a terminal you do not otherwise open. |

## What it installs

Four apps, all free, none of them creative. The rule that picked them: a studio
Mac turns out to need each one, and nobody installs it until the afternoon it is
missing.

| App | The gap it fills |
|---|---|
| **IINA** | The reference rips are `.mkv` and `.avi`, which QuickTime cannot open at all. |
| **Keka** | Sample packs and sound libraries arrive as `.rar` and `.7z`. Finder opens neither. |
| **BlackHole 2ch** | A virtual audio device. The only way to get what a browser is playing into a DAW input. Read [the strong opinions](#the-strong-opinions-stated) before this one. |
| **OBS** | Screen and session capture, and the app the `capture` focus scene opens. |

Already have one of them? `haus.homebrew.adopt` is on by default, so an existing
copy is adopted rather than fought over or installed twice. Don't want one? Drop
its line. `haus.homebrew.cleanup` stays at `"none"`, so nothing you installed
yourself is ever removed by a rebuild.

## Rooms it deliberately leaves off

This is the half you cannot reconstruct from the file.

- **Windows, the tiler, and with it the leader key.** The decision that
  determines whether this feels like a gift or a hijacking. Ableton, RX and
  Resolve are full-screen, single-window applications with dense keyboard
  vocabularies of their own; tiling has nothing to arrange, and remapping
  **Caps Lock** on a Mac somebody already works on every day is a change they
  did not ask for. With the room off, `haus.keys.leader` claims nothing and
  Caps Lock stays Caps Lock.
- **Development, and AI with it.** No shell toolbelt, no coding agents, no
  terminal room. AI follows development rather than leading it.
- **Zen, the browser.** Which browser you use is not a desktop's business.

Turn any of them on in your host file with a plain assignment. Nothing here
needs `lib.mkForce` to override.

## The strong opinions, stated

Things that will surprise muscle memory, or that reach further than a rebuild.

**Three keys change hands.**

- **⌘Space is taken from Spotlight** and given to the palette.
- **⌥Space is claimed globally** for Find Files. It is free on a machine with no
  leader key, and it is exactly the chord `haus.keys.leader = "alt-space"`
  wants, so turning the tiler on later means moving one of the two.
- **⌘Tab stops being the app switcher, once pounce has its Accessibility
  grant.** The launcher room replaces it with the palette's window switcher,
  which walks *windows* rather than apps. On a Mac running Ableton that is
  usually what you wanted, since a plug-in window and the arrangement are two
  rows instead of one app. Tap to toggle, hold ⌘ and keep tapping ⇥ to walk
  back, type while holding to filter. It needs the grant to install its event
  tap, so on a fresh machine stock ⌘Tab keeps working until you approve pounce
  in Accessibility. Put the stock one back for good with
  `haus.launcher.windowSwitcher = false`.

**The Accessibility grant does not survive a rebuild on its own, and no desktop
can fix that.** Every rebuild that moves pounce gives it a new code signature,
and macOS keys the grant to the old one, so pounce goes quiet and ⌘Tab reverts
until you approve it again. The fix is one line, and it is host-only because it
names something in your login keychain:

```nix
# security find-identity -v -p codesigning
haus.launcher.signingIdentity = "Developer ID Application: Your Name (TEAMID)";
```

**BlackHole installs a system audio driver, and that is the largest single claim
in this file.** It is a virtual device, not a kernel extension, and it is the
one the rest of the Mac audio world assumes you have. Three things to know
before you rebuild:

1. The cask runs a package installer, so the rebuild asks for **Touch ID** part
   way through. That is Homebrew, not haus.
2. Installing an audio plug-in restarts `coreaudiod`, so **audio drops out of
   whatever is playing** at that moment. Don't rebuild mid-take.
3. It adds **BlackHole 2ch** to your Sound settings. It does not select it. If
   you ever find yourself with silent monitors, that is the first list to look
   at.
4. If you already run **Loopback** or **Audio Hijack**, you do not need it.
   Delete the `roster.blackhole-2ch` line before the first rebuild. Backing it
   out afterwards wants BlackHole's own uninstaller rather than
   `brew uninstall` alone, because the driver lives outside `/Applications`.

**IINA arrives without taking anything.** haus stopped claiming file types on
your behalf, so `.mkv` still opens in whatever opens it today. Make IINA the
default for a container you care about with Finder's Get Info ▸ Change All,
once.

**OBS stays stock, and that is a known rough edge rather than a setting.**
nebelung's OBS theme is two files, a Mocha variant and the base it extends, and
the port names only the first. haus copies what the port names, so the theme
does not appear in OBS's Appearance list. Nothing is broken by this and nothing
here needs doing: use OBS's own themes. `haus doctor` is where the machine
lists what it placed and what is still waiting.

**The rest, in the order you would notice them.**

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
- **Homebrew's services row is hidden from the palette.** The command is still
  there, it is just not in the list on a Mac with no terminal on it.
- The palette is drawn at **1.2**, the monospace size is **19**, and the accent
  colour is **teal**, the one accent that stays legible against the ambers and
  reds every DAW uses for clips and for clipping.

**What it explicitly does not touch.** Your desktop picture stays where it is
(`haus.wallpaper.style = "none"`, stated in the file rather than left to a
default, because the absence of a line is not a promise anyone can read). So
does macOS's own Light/Dark: `haus.theme.systemAppearance` is left unset.

## The three list-typed options it sets

A list in your host file **replaces the desktop's whole** rather than appending
to it: your definition outranks the desktop's, and only the winning one
survives. Nothing fails, you just quietly get fewer entries than you meant. If
you set any of these, restate what is here beside your own.

```nix
# Losing this one silently drops both palette rows AND switchaudio-osx from the
# machine, which is the tool the `studio` scene's audio.input needs.
haus.launcher.plugins = [ "audio" "bluetooth" ];

haus.focus.scenes.capture.apps.open = [ "OBS" ];

haus.tour.steps = [
  { hint = "press {palette}, type ff, hit ↵ — that's Find Files, from anywhere"; detect = "palette"; }
];
```

One tour step is on purpose: with the tiler off, `palette` is the only signal
the tour can detect, so a second step would either complete itself instantly or
sit there waiting to be clicked past.

## What it deliberately does not do

- **It does not touch your licensed apps.** Ableton, RX and Resolve are already
  on your Mac and already paid for; haus has nothing to add by taking over
  Homebrew's ownership of them, and `haus.homebrew.cleanup` stays at `"none"`,
  so nothing you installed yourself is ever removed by a rebuild. The four in
  [What it installs](#what-it-installs) are the other case: free, unlicensed,
  and not a replacement for anything you run.
- **It does not claim your file associations.** The reference rips are `.mkv`,
  which QuickTime cannot open, and IINA is here to open them. Which app *owns*
  the extension is still yours: this file used to hand IINA thirteen of them,
  and the first rebuild put a stack of one modal per extension family in front
  of the person it was meant to be helping. A desktop reaching that far into a
  machine it has never seen is the kind of change this file is built not to
  make.
- **It does not name your audio interface.** Which box is plugged in is a fact
  about one machine, not a taste a desktop can share. The `studio` scene will
  switch the system input for you once you name it in your host:

  ```nix
  # the exact string `SwitchAudioSource -a -t input` prints
  haus.focus.scenes.studio.audio.input = "Scarlett 2i2 USB";
  ```

  `SwitchAudioSource` is already on this machine: the `audio` palette command
  brings it, and so does the scene the moment you name a device.
- **It grants no permissions.** After the first rebuild, macOS will ask for
  Accessibility for pounce, and perch needs you to pick your screenshots folder
  once so it can mint the security-scoped bookmark for it. Nothing declarative
  can do either for you.
- **It sets no identity, no secrets and nothing about your hardware.** Those
  belong in your host file, which is the file that also beats every line here.

## Two more lines for your host file, not set here

Both are left out because they are about you rather than about a studio.

```nix
# Stop the things haus itself animates: the bar's hover sweeps, the marquees.
# It also asks for macOS's own Reduce Motion, which rewrites the web too.
haus.appearance.reduceMotion = true;

# Everything else haus draws, bigger: the bar's type, the Dock's icons,
# Finder's row height. It will NOT move the palette on this desktop, because
# `launcher.scale` is pinned at 1.2 here and a pinned value beats the default
# ui.scale would set. Raise both, or drop the pin.
haus.ui.scale = 1.35;
haus.launcher.scale = 1.35;
```

## If you are coming from the Homebrew pounce

The launcher room installs and runs its own pounce, so stop the Homebrew one
first or the two will fight over ⌘Space:

```sh
brew services stop pounce
brew uninstall pounce
```

Your own commands in `~/.config/pounce/commands` are untouched by any of this.
The daemon still discovers them there.

## Tested against

- haus `v2026.09.02` and newer. Checked against `f48f9125`, `VERSION`
  2026.09.03.
- `haus show ./producer.nix` passes: **a desktop, data only, and haus checked
  it**, 47 options across 7 rooms.
- A real host evaluates. A consumer flake selecting this file through `mkHaus`
  resolves a full `system.build.toplevel` with no failed assertions and no
  warnings: all four casks in the resolved Homebrew list, `wallpaper.style` at
  `none`, `theme.systemAppearance` at `unmanaged`, and the OBS theme file
  placed.
- **Rebuilt and driven on a real macOS install**, at the version of this file
  before the four apps were added: the palette answers ⌘Space, ⌥Space opens
  Find Files, the bar carries the four pills, and Caps Lock is left alone.
- **The four apps, the `capture` scene and the two palette commands have not
  been lived in.** They evaluate; nobody has yet watched Homebrew install a
  driver mid-rebuild.

## License

MIT. See [LICENSE](./LICENSE).
