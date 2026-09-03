# producer — a Mac for someone who makes sound.
#
# The person this is for: a sound designer and musician. Ableton Live is open
# most of the day, iZotope RX opens on top of it to clean a take, DaVinci
# Resolve bookends the session, and the browser is where the reference footage
# comes from. Not a developer, and not interested in becoming one to use their
# computer.
#
# The judgement calls, which are the interesting part:
#
#   - Windows (the tiler) OFF, and no leader key. This is the one that decides
#     whether the machine feels like a gift or a hijacking. Ableton, RX and
#     Resolve are full-screen, single-window applications with their own dense
#     keyboard vocabularies; tiling has nothing to arrange, and remapping Caps
#     Lock on the Mac someone already works on every day is a change they did
#     not ask for. With the room off, `haus.keys.leader` claims nothing and
#     Caps Lock stays Caps Lock.
#
#   - Launcher (pounce) ON, on ⌘Space. The one room this desktop can be
#     confident about, because the person it is for already runs pounce
#     standalone from Homebrew and reaches for Find Files daily. What the room
#     adds over the brew install is the wiring rather than the app: the daemon
#     as a login item, ⌘Space actually taken away from Spotlight, and the
#     Accessibility grant surviving a rebuild.
#
#     Two of the palette's optional commands come with it, picked by asking
#     what this person interrupts a session to go and do. It is moving between
#     the interface and the headphones, and waking a controller that has gone
#     to sleep. Both are a row in a window that is already open now, driving
#     `SwitchAudioSource` and `blueutil` rather than opening a settings pane.
#
#   - Appearance ON, and scoped to what haus itself draws. This is the room
#     that used to be half-set here by accident — an accent and a font size,
#     with the one switch it actually has left off. It is on now, and it is
#     deliberately narrow: it colours the palette, the shelf, the bar and the
#     apps in the roster below, and it touches nothing that was already on the
#     screen when you installed it. `wallpaper.style = "none"` keeps the desktop
#     picture, and `theme.systemAppearance` is left unset so macOS's own
#     Light/Dark stays exactly where it was. A studio Mac is somebody's room; a
#     config file gets to furnish it, not repaint it.
#
#   - Developer OFF, and AI with it. There is no shell toolbelt here, no coding
#     agents, and no terminal room.
#
#   - Shelf (perch) ON. The single most load-bearing room for this workflow and
#     the one that needs the least explaining: the notch is a place to park a
#     rendered stem, a trimmed clip or a grabbed frame while you switch apps,
#     and every step of a sound-redesign pass is a file moving between two
#     applications that have no idea the other exists.
#
#   - Focus ON, with three scenes rather than five. `studio`, `capture` and
#     `watch` below are the three states this machine is actually ever in, and
#     each one moves a lever the other two don't. A workflow that reorganises
#     itself every few months is not one to freeze into a config file, so none
#     of them declares a `when` condition — they are entered by hand, from the
#     palette, which also means the trigger agent that polls those conditions
#     never runs at all. Not from the bar's focus pill: its click is `focus
#     toggle`, which can LEAVE a scene and can flip plain quiet, and has no
#     route into a named one.
#
#   - Four apps, all free, and the thing they deliberately still don't do.
#     Ableton, RX and Resolve are already installed and already licensed; haus
#     has nothing to add by taking over Homebrew's ownership of them, and
#     `haus.homebrew.cleanup` stays at its default ("none") so nothing
#     undeclared is ever removed. What this desktop DOES bring is four free
#     ones a studio Mac turns out to need and that nobody installs until the
#     afternoon they are missing: a player for the containers QuickTime
#     refuses, an unarchiver for the ones Finder refuses, a virtual audio
#     device, and a recorder.
#
#     Not one of them CLAIMS anything, and that half is inherited rather than
#     re-argued. This file used to hand IINA thirteen file associations, and
#     the first rebuild put a stack of one modal per extension family in front
#     of the person it was meant to be helping. Putting an app on the Mac is a
#     desktop's business; deciding what opens your .mkv on a machine the
#     desktop has never seen is not. Each of the four is one line to drop.
#
#   - The sound settings are not decoration. A studio Mac's output is a pair of
#     monitors or headphones at working level, so the Trash whoosh, the volume-
#     key pop and the boot chime are not small noises here.
{
  haus = {
    # ---- rooms -------------------------------------------------------------

    launcher.enable = true;

    shelf.enable = true;

    focus.enable = true;

    bar.enable = true;

    # Left off, stated so the absence reads as a decision rather than an
    # oversight: windows (the tiler), developer, ai, terminal, zen.

    # ---- what the launcher looks like -------------------------------------

    keys.palette = "cmd-space";

    # The palette is read at arm's length from the mix position, not leaned
    # over like a terminal — which is the case `launcher.scale` exists for, in
    # its own option's words. Only the palette moves: `haus.ui.scale` would
    # take the Dock's icons and Finder's row height with it, and those were
    # already the size this person set them.
    launcher.scale = 1.2;

    # Two of the palette's optional commands. Each one installs the plain CLI it
    # shells out to (`audio` pulls switchaudio-osx, `bluetooth` pulls blueutil),
    # so neither is a row that fails with "not found".
    #
    # ⚠ A LIST, and a host that names `launcher.plugins` at all replaces it
    # whole rather than adding to it — losing both rows AND switchaudio-osx
    # with them, which is the tool the `studio` scene's `audio.input` wants.
    # Restate these two beside your own.
    #
    # `caffeinate` is the third one that fits this machine and is deliberately
    # not here: the bar already carries the coffee pill below, and a second
    # front on the same toggle is a row you have to learn instead of a shortcut
    # you already have.
    launcher.plugins = [
      "audio"
      "bluetooth"
    ];

    launcher.items = {
      # Find Files is the row this desktop's person already lives in, so it
      # gets a key of its own — ⌥Space, one modifier away from the palette it
      # would otherwise take two steps to reach through. ⌥Space is free on a
      # machine with no leader key; it is the chord `haus.keys.leader =
      # "alt-space"` would want, so a host that turns the tiler on later has to
      # move one of the two.
      "mode:filesearch" = {
        alias = "ff";
        hotkey = "opt+space";
        caption = "Find Files";
      };

      # No key — the palette is one keystroke away, and these are rows you go
      # looking for rather than reach for mid-take. Two letters each, so the
      # three panels this machine opens share one shape of shorthand.
      "mode:clipboard".alias = "cb";

      # The recent-screenshots panel. On this Mac a screenshot is usually a
      # reference frame pulled out of a film, so the panel is a contact sheet
      # of the last hour's grabs and the fastest route back to one.
      "mode:screenshots".alias = "ss";

      # "Audio Devices" already matches a search for "audio". The alias buys
      # the OTHER word people reach for when they want this window, which on a
      # machine with an interface plugged into it is the microphone.
      "cmd:audio".alias = "mic";

      "cmd:bluetooth".alias = "bt";

      # Homebrew's launchd services, listed on a Mac with no terminal on it and
      # nothing a person here would ever want to restart. The row is hidden
      # rather than the command removed: `listed = false` takes it out of the
      # list and leaves it reachable by name if a host ever binds it.
      "cmd:brew-services".listed = false;
    };

    # ---- the bar -----------------------------------------------------------

    bar.items = {
      # On top of the room's own defaults (clock, weather, media, battery,
      # wifi). `media` is already on and is the pill that matters most here.
      volume = true;
      cpu = true;
      memory = true;
      # A render or a spectral repair is a long job you walk away from; the
      # coffee pill is the manual version of what the `studio` scene does.
      caffeinate = true;
    };

    # ---- appearance --------------------------------------------------------

    # Teal rather than haus's own mauve: it is the one accent that stays
    # legible against the ambers and reds every DAW uses for clips and
    # clipping.
    theme.accent = "teal";

    # Nebelung's palette, written into any app in the roster that nebelung
    # ships a port for. The Appearance room is always present rather than
    # switched on, and this is the one leaf in it shaped like a switch; the
    # reason it was off no longer holds. It read "it writes theme files into
    # lazygit, fzf and yazi, none of which this desktop installs", which was
    # true of a roster with nothing in it.
    #
    # Be exact about what it buys, because the option itself is: it drops a
    # FILE. Whether the file SELECTS the theme is the app's call, not haus's —
    # some ports are a path the app already reads, most want one more click,
    # and a port whose install is a merge or a compile step is deliberately not
    # written at all. `haus doctor` is the list of which is which.
    #
    # On this roster it is almost entirely future value, and that is the honest
    # reason it is on: an app added to `haus.roster` later gets its theme
    # placed without anyone making a second decision. OBS is the only app here
    # nebelung draws, and its theme does not arrive complete — the port's
    # `path` names `Catppuccin_Mocha.ovt`, which `extends` a base carried by a
    # second file the port names only in prose, so OBS does not offer the theme
    # under Appearance yet. Leave OBS stock for now; nothing else here changes.
    theme.ports.enable = true;

    # The desktop picture is yours. `none` is the room's own default and is
    # stated anyway, because the absence of a line is not a promise anyone can
    # read: this is the most visible thing the layer can do to a Mac, and a
    # desktop that quietly did it would be the one thing here that could not be
    # undone by reading the file first.
    #
    # `theme.systemAppearance` is left unset for the same reason and gets no
    # line at all: macOS's own Light/Dark is a switch this person already threw
    # once, and a rebuild has no business throwing it back.
    wallpaper.style = "none";

    fonts.mono.baseSize = 19;

    # ---- sound -------------------------------------------------------------

    sound = {
      # The interface UI sounds — the Trash whoosh, the screenshot shutter —
      # go out of the same monitors the mix does, and into a screen recording.
      uiSounds = false;
      volumeFeedback = false;
      # Audible, but not at the level a beep would be if it arrived at the top
      # of a monitoring chain. 0 would silence it entirely; that hides errors.
      alertVolume = 25;
      # Firmware state, so this one survives a reinstall. A Mac booting at full
      # chime volume with the monitors up is the studio's oldest jump scare.
      startupChime = false;
    };

    # ---- screenshots -------------------------------------------------------

    screenshots = {
      # Write the file immediately instead of after the five seconds the
      # floating preview waits around. Grabbing a run of reference frames is a
      # burst, not a single capture — and with the shelf on, the file reaching
      # the notch IS the preview.
      #
      # The shelf room already asks for this at `mkDefault` while
      # `watchScreenshots` is on. It is pinned here rather than left to it so
      # that turning the watch off doesn't silently bring the five seconds
      # back: the burst is this desktop's reason, and it outlives the shelf's.
      thumbnail = false;
    };

    # ---- focus scenes ------------------------------------------------------

    focus.scenes = {
      studio = {
        description = "Recording or mixing — quiet, and the Mac stays awake through the take";
        dnd = true;
        preventSleep = true;
        # `audio.input` is deliberately not set here: which interface is
        # plugged in is a fact about one machine, not about this desktop. Name
        # yours in your host file — see the README.
      };

      capture = {
        description = "Screen recording — OBS up, and nothing allowed to interrupt";
        # The one scene where quiet is not a preference. A banner that arrives
        # mid-take is edited out afterwards or not at all.
        dnd = true;
        preventSleep = true;
        # The scene earns its place by opening the app rather than by being a
        # third mood: OBS is in the roster below, so this is a name the desktop
        # can be sure of.
        apps.open = [ "OBS" ];
        # Closes only what the scene actually started, and asks the way ⌘Q
        # asks — so an OBS you already had open, recording, is never taken
        # down by leaving.
        apps.closeOnExit = true;
      };

      watch = {
        description = "Hunting scenes — the display stays up through a two-hour film";
        # false means "leave Do Not Disturb exactly as you found it", not "turn
        # it off": you are watching, not working, and messages are fine.
        dnd = false;
        preventSleep = true;
      };
    };

    # ---- the four apps -----------------------------------------------------
    #
    # Roster entries with a source and nothing else. None claims a leader letter
    # (there is no leader on this machine) and none names a bundle id (that
    # field feeds the tiler's placement rules, and the tiler is off) — so each
    # of these is exactly one sentence: put this on the Mac.
    #
    # `haus.homebrew.adopt` is on by default, so a copy you already installed by
    # hand is adopted rather than fought over or installed twice.

    # The reference rips are .mkv and .avi, which QuickTime cannot open at all.
    # haus stopped claiming file types on your behalf, so IINA arrives without
    # taking anything: make it the default for a container you care about with
    # Finder's Get Info ▸ Change All, once.
    roster.iina.cask = "iina";

    # Sample packs and sound libraries arrive as .rar and .7z, neither of which
    # Finder opens. The same shape of argument as IINA, one folder earlier.
    roster.keka.cask = "keka";

    # A virtual audio device: the only way to get what a browser is playing
    # into a DAW input. It installs a system audio driver, which is the largest
    # single claim in this file — read the README's strong opinions before you
    # rebuild, and drop this line if you already run Loopback or Audio Hijack.
    roster.blackhole-2ch.cask = "blackhole-2ch";

    # Screen and session capture, and the one app here nebelung has a theme
    # for — see `theme.ports.enable` above.
    roster.obs.cask = "obs";

    # ---- the rest ----------------------------------------------------------

    security.touchId = {
      enable = true;
      # Without this, every `haus rebuild` stops and waits for a sudo password
      # in a terminal this person does not otherwise open.
      passwordlessRebuild = true;
    };

    # One step, and one on purpose. With the tiler off, `palette` is the only
    # signal the tour can actually detect, so a second step would either
    # complete itself instantly or sit there needing to be clicked past.
    tour = {
      enable = true;
      steps = [
        {
          hint = "press {palette}, type ff, hit ↵ — that's Find Files, from anywhere";
          detect = "palette";
        }
      ];
    };
  };
}
