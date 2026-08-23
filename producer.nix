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
#   - Developer OFF, and AI with it. There is no shell toolbelt here, no coding
#     agents, and no terminal room. `haus.theme.ports` is left off for the same
#     reason `minimal` leaves it off — it writes theme files into lazygit, fzf
#     and yazi, none of which this desktop installs.
#
#   - Shelf (perch) ON. The single most load-bearing room for this workflow and
#     the one that needs the least explaining: the notch is a place to park a
#     rendered stem, a trimmed clip or a grabbed frame while you switch apps,
#     and every step of a sound-redesign pass is a file moving between two
#     applications that have no idea the other exists.
#
#   - Focus ON, with two scenes rather than five. `studio` and `watch` below
#     are the two states this machine is actually ever in. A workflow that
#     reorganises itself every few months is not one to freeze into a config
#     file, so neither scene declares a `when` condition — they are entered by
#     hand, from the palette or the bar pill, which also means the trigger
#     agent that polls those conditions never runs at all.
#
#   - No creative apps in the roster. Ableton, RX and Resolve are already
#     installed and already licensed. haus has nothing to add by taking over
#     Homebrew's ownership of them, and `haus.homebrew.cleanup` is deliberately
#     left at its default ("none") so that nothing undeclared is ever removed.
#     IINA is the exception, and earns it: the reference footage is .mkv, which
#     QuickTime cannot open at all.
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

      # No key — the palette is one keystroke away, and this is a row you go
      # looking for rather than reach for mid-take.
      "mode:clipboard".alias = "cb";
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

      watch = {
        description = "Hunting scenes — the display stays up through a two-hour film";
        # false means "leave Do Not Disturb exactly as you found it", not "turn
        # it off": you are watching, not working, and messages are fine.
        dnd = false;
        preventSleep = true;
      };
    };

    # ---- the rest ----------------------------------------------------------

    security.touchId = {
      enable = true;
      # Without this, every `haus rebuild` stops and waits for a sudo password
      # in a terminal this person does not otherwise open.
      passwordlessRebuild = true;
    };

    # IINA, and the video extensions with it. The reference rips are .mkv and
    # .avi, which QuickTime cannot open — this is the pick that removes an
    # actual daily annoyance rather than an editorial preference.
    apps.videoPlayer = {
      enable = true;
      claimFileTypes = true;
    };

    fonts.mono.baseSize = 19;

    # Teal rather than haus's own mauve: it is the one accent that stays
    # legible against the ambers and reds every DAW uses for clips and
    # clipping. `theme.ports` stays off — see the header.
    theme.accent = "teal";

    wallpaper.style = "minimal";

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
