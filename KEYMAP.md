# Corne keymap

A 42-key Corne running ZMK v0.3, seven layers, 30 combos, home-row mods, and two
Bluetooth hosts sharing one monitor.

The short version: **letters live on one layer, symbols live on both a layer and a set of
combos, and the layers carry everything else.** Combos cover the symbols you want without
breaking a word; `SYM` covers the rest.

- [Reading the diagrams](#reading-the-diagrams)
- [Layers](#layers)
- [Combos](#combos)
- [Combo timing](#combo-timing)
- [Behaviours](#behaviours)
- [Two hosts, one monitor](#two-hosts-one-monitor)
- [Config and build](#config-and-build)
- [Known gaps](#known-gaps)

---

## Reading the diagrams

`·` is `&none`, a dead key. `▽` is `&trans`, falling through to the layer below. A cell
marked `held` is the key you are holding to reach that layer.

Positions use the `zmk-helpers` 42-key labels. Column `0` is the **inner** index finger
and column `5` is the **outer** pinky, so `LT0` is `T` rather than `Tab`:

```
LT5 LT4 LT3 LT2 LT1 LT0        RT0 RT1 RT2 RT3 RT4 RT5
LM5 LM4 LM3 LM2 LM1 LM0        RM0 RM1 RM2 RM3 RM4 RM5
LB5 LB4 LB3 LB2 LB1 LB0        RB0 RB1 RB2 RB3 RB4 RB5
            LH2 LH1 LH0        RH0 RH1 RH2
```

---

## Layers

| # | Name | Reached by |
| --- | --- | --- |
| 0 | `DEF` | base |
| 1 | `NAV` | hold left middle thumb |
| 2 | `NUM` | hold right middle thumb |
| 3 | `MED` | hold left outer thumb |
| 4 | `FNC` | hold right outer thumb |
| 5 | `VDP` | hold left inner thumb |
| 6 | `SYM` | hold right inner thumb |

Five thumbs double as something useful on tap. The left outer is a layer only: its tap
went unused and every unused tap is a way to fire a stray modifier, so it is a plain
`&mo`.

### DEF

```
╭──────┬──────┬──────┬──────┬──────┬──────╮      ╭──────┬──────┬──────┬──────┬──────┬──────╮
│ Tab  │  Q   │  W   │  E   │  R   │  T   │      │  Y   │  U   │  I   │  O   │  P   │ Bksp │
├──────┼──────┼──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┼──────┼──────┤
│ Esc  │  A   │  S   │  D   │  F   │  G   │      │  H   │  J   │  K   │  L   │  ;   │  '   │
├──────┼──────┼──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┼──────┼──────┤
│ Shft │  Z   │  X   │  C   │  V   │  B   │      │  N   │  M   │  ,   │  .   │  /   │ Shft │
╰──────┴──────┴──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┴──────┴──────┴──────╯
                     │ MED  │ NAV  │ Spc  │      │ Ent  │ NUM  │ FNC  │
                     ╰──────┴──────┴──────╯      ╰──────┴──────┴──────╯
```

Home-row mods sit on the eight keys `A S D F` and `J K L ;`. Hold for the modifier, tap
for the letter:

| Key | Hold | Key | Hold |
| --- | --- | --- | --- |
| `A` | Gui | `J` | Shift |
| `S` | Alt | `K` | Ctrl |
| `D` | Ctrl | `L` | Alt |
| `F` | Shift | `;` | Gui |

| Thumb | Tap | Hold |
| --- | --- | --- |
| Left outer | none | `MED` |
| Left middle | Backspace | `NAV` |
| Left inner | Space | `VDP` |
| Right inner | Enter | `SYM` |
| Right middle | sticky Shift | `NUM` |
| Right outer | Escape | `FNC` |

Space carries `VDP`, which costs it press-on-release: the space lands when you let go, not
when you press. The trade is deliberate: `VDP` is left-hand heavy, so holding it with the
left thumb keeps the reach short, and `tap-preferred` at 200ms means a space-then-letter
roll still lands as a space. Autorepeat survives: tap, then hold, and Space repeats rather
than opening the layer. Enter pays the same cost for `SYM`, which matters less because you
press Enter far less often.

### NAV

Hold the left middle thumb. Arrows land under your right hand, modifiers under your left,
so `Shift+Ctrl+Left` is one grip.

```
╭──────┬──────┬──────┬──────┬──────┬──────╮      ╭──────┬──────┬──────┬──────┬──────┬──────╮
│  ·   │  ·   │ Swap │  ·   │Swap⇧ │  ·   │      │ Redo │Paste │ Copy │ Cut  │ Undo │  ·   │
├──────┼──────┼──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┼──────┼──────┤
│  ·   │ Gui  │ Alt  │ Ctrl │ Shft │  ·   │      │  ←   │  ↓   │  ↑   │  →   │  ·   │  ·   │
├──────┼──────┼──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┼──────┼──────┤
│  ·   │  ·   │◀Desk │  ·   │Desk▶ │  ·   │      │ Home │ PgDn │ PgUp │ End  │ Ins  │ ScLk │
╰──────┴──────┴──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┴──────┴──────┴──────╯
                     │  ▽   │ held │  ▽   │      │ Ent  │ Del  │ Bksp │
                     ╰──────┴──────┴──────╯      ╰──────┴──────┴──────╯
```

`Swap` is Alt+Tab held open, so you can tab repeatedly without Alt dropping. `Swap⇧`
walks backwards. Both set Alt on explicitly rather than toggling it, so mixing them in one
session is safe.

The clipboard row sends real `Ctrl` chords rather than the `C_AC_*` consumer codes, which
most X11, Wayland and macOS applications ignore. See [the Mac
caveat](#two-hosts-one-monitor).

Holding `Gui` here turns the arrow cluster into window management, though `VDP` carries
the same four snaps without the extra modifier.

### NUM

Hold the right middle thumb. Digits form a numpad on the left hand across `W E R`,
`S D F` and `X C V`, with `0` on `A`.

```
╭──────┬──────┬──────┬──────┬──────┬──────╮      ╭──────┬──────┬──────┬──────┬──────┬──────╮
│  ▽   │  ·   │  7   │  8   │  9   │  ·   │      │  ·   │  ·   │  ·   │  ·   │  ·   │ Bksp │
├──────┼──────┼──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┼──────┼──────┤
│  :   │  0   │  4   │  5   │  6   │  \   │      │  ·   │ Shft │ Ctrl │ Alt  │ Gui  │  ·   │
├──────┼──────┼──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┼──────┼──────┤
│  ·   │  `   │  1   │  2   │  3   │  !   │      │  ·   │  ·   │  ▽   │  ▽   │  ▽   │  ·   │
╰──────┴──────┴──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┴──────┴──────╯
                     │  .   │  -   │ Spc  │      │ Ent  │ held │  ·   │
                     ╰──────┴──────┴──────╯      ╰──────┴──────┴──────╯
```

Modifiers sit on the right home row so you can hold the layer and a modifier with one
hand while the other types digits. `,` `.` and `/` fall through so `f(1, 2)` and `1,000`
never need the layer released, and Tab and Enter stay live so a number can end a form
field or a calculator line without letting go.

### MED

Hold the left outer thumb. Bluetooth on the left, media on the right.

```
╭──────┬──────┬──────┬──────┬──────┬──────╮      ╭──────┬──────┬──────┬──────┬──────┬──────╮
│ Boot │→Arch │→Mac  │  ·   │  ·   │  ·   │      │  ·   │ Br-  │ Br+  │  ·   │BTclr │ Boot │
├──────┼──────┼──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┼──────┼──────┤
│  ·   │ BT0  │ BT1  │ BT2  │ BT3  │  ·   │      │ Prev │ Vol- │ Vol+ │ Next │  ·   │  ·   │
├──────┼──────┼──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┼──────┼──────┤
│  ·   │ Arch │ Mac  │  ·   │  ·   │  ·   │      │  ·   │ Arch │ Mac  │  ·   │  ·   │  ·   │
╰──────┴──────┴──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┴──────┴──────┴──────╯
                     │ held │  ·   │  ·   │      │ Stop │ Play │ Mute │
                     ╰──────┴──────┴──────╯      ╰──────┴──────┴──────╯
```

`→Arch` and `→Mac` drive the monitor input without touching Bluetooth. `Arch` and `Mac`
do both at once. The bottom row repeats them on the right hand because your left thumb is
busy holding the layer.

`Boot` drops a half into the bootloader. There is one on each side because ZMK's reset
behaviour runs on the half whose key was pressed: the left corner resets the left, the
right corner resets the right. A combo cannot do that, since combos always resolve on the
central half.

### FNC

Hold the right outer thumb. F-keys mirror the numpad shape: `F7 F8 F9` over `F4 F5 F6`
over `F1 F2 F3`, with `F10` to `F12` down the inner column.

```
╭──────┬──────┬──────┬──────┬──────┬──────╮      ╭──────┬──────┬──────┬──────┬──────┬──────╮
│  ·   │PrtSc │  F7  │  F8  │  F9  │ F12  │      │  ·   │  ·   │  ·   │  ·   │  ·   │  ·   │
├──────┼──────┼──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┼──────┼──────┤
│  ·   │ ScLk │  F4  │  F5  │  F6  │ F11  │      │ Spc  │ Shft │ Ctrl │ Alt  │ Gui  │  ·   │
├──────┼──────┼──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┼──────┼──────┤
│  ·   │Pause │  F1  │  F2  │  F3  │ F10  │      │  ·   │  ·   │  ·   │  ·   │  ·   │  ·   │
╰──────┴──────┴──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┴──────┴──────┴──────╯
                     │  ·   │ Alt  │ Spc  │      │  ·   │  ·   │ held │
                     ╰──────┴──────┴──────╯      ╰──────┴──────┴──────╯
```

Modifiers on the right home row mean `Ctrl+F5` is one grip: hold the thumb, hold `K`,
press `D`.

### VDP

Hold the left inner thumb. Desktops sit on the left hand in the same numpad shape as
`NUM`, so desktop 1 is two keys: hold Space, press `X`.

```
╭──────┬──────┬──────┬──────┬──────┬──────╮      ╭──────┬──────┬──────┬──────┬──────┬──────╮
│  ·   │  ·   │  D7  │  D8  │  D9  │  ·   │      │  ·   │  ·   │  ·   │  ·   │  ·   │  ·   │
├──────┼──────┼──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┼──────┼──────┤
│  ·   │◀Desk │  D4  │  D5  │  D6  │Desk▶ │      │ Gui← │ Gui↓ │ Gui↑ │ Gui→ │  ·   │  ·   │
├──────┼──────┼──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┼──────┼──────┤
│  ▽   │Mv+Dsk│  D1  │  D2  │  D3  │  ·   │      │  ·   │  ·   │  ·   │  ·   │  ·   │  ·   │
╰──────┴──────┴──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┴──────┴──────┴──────╯
                     │  ·   │ Alt  │ held │      │  ·   │  ·   │  ·   │
                     ╰──────┴──────┴──────╯      ╰──────┴──────┴──────╯
```

`D1` through `D9` send `Ctrl+F1` to `Ctrl+F9`, which is how KDE selects a desktop.
`◀Desk` and `Desk▶` step one at a time, and `Mv+Dsk` throws the focused window to desktop
1 and follows it there.

The `Gui`+arrow cluster on the right snaps the focused window. Enter is not reachable
while the layer is held, which has never come up: you switch desktops, you do not type.

### SYM

Hold the right inner thumb. The whole symbol set sits under the left hand, which is the
one not holding the layer.

```
╭──────┬──────┬──────┬──────┬──────┬──────╮      ╭──────┬──────┬──────┬──────┬──────┬──────╮
│  .   │  =   │  &   │  *   │  \   │  |   │      │  ·   │  [   │  ]   │  )   │  }   │ Bksp │
├──────┼──────┼──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┼──────┼──────┤
│  ;   │  :   │  $   │  %   │  ^   │  +   │      │  ·   │ Shft │ Ctrl │ Alt  │ Gui  │  ·   │
├──────┼──────┼──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┼──────┼──────┼──────┤
│  `   │  ~   │  !   │  @   │  #   │  -   │      │  ·   │  ·   │  <   │  >   │  ·   │  ·   │
╰──────┴──────┴──────┼──────┼──────┼──────┤      ├──────┼──────┼──────┴──────┴──────┴──────╯
                     │ ( {  │  _   │ Spc  │      │ held │  ·   │  ·   │
                     ╰──────┴──────┴──────╯      ╰──────┴──────┴──────╯
```

The left outer thumb is a mod-morph: `(` on its own, `{` with Shift held. The closing
brackets on the right top row are the fallback for when a squeeze does not land. Mirrored
modifiers sit on the right home row so `Ctrl+$` and the like stay one grip.

**Ctrl chords want the unshifted key.** USB HID has no plus usage, only
`EQUAL_AND_PLUS`, so `+` is `LS(EQUAL)`: Shift baked in. Hold Ctrl and press it and the
host gets `Ctrl+Shift+Equal`, which it reads as `Ctrl+plus`. Apps that bind zoom to
`Ctrl+=` alone never see it. The same applies to every symbol with a hidden Shift:

```
!  @  #  $  %  ^  &  *  (  )  +  :  ~  |  <  >  _
```

These carry no hidden Shift, so Ctrl chords with them are unambiguous:

```
=  -  `  \  ;  .  [  ]  /
```

`+` is the one that mattered, so it is a mod-morph rather than a plain `&kp PLUS`: under
Ctrl it sends bare `EQUAL`. `keep-mods` stops the morph masking the modifier that
triggered it. On the Mac the [Ctrl and Cmd swap](#the-mac-clipboard-caveat) turns this
into `Cmd+=`. The `+` combo on `RT1 RM1` uses the same behaviour so both routes to `+`
behave alike. If another symbol ever needs it, the same morph pattern applies. `KP_PLUS`
is the cruder alternative, a distinct usage with no implicit Shift but patchy app support.

---

## Combos

Every symbol on `SYM` also has a two-key squeeze on the base layer, so most symbols can be
typed either way. The combos exist for the ones you want mid-identifier, without leaving
the base layer. Symbol combos are live on `DEF` and `NUM` only: on `NAV` the same
positions hold arrows and paging keys, and a fast diagonal was firing `_`.

### The rule

**Same column, one row apart, vertical squeeze.** Sixteen of them follow it exactly.

Left hand, top and middle rows:

| Squeeze | Sends | | Squeeze | Sends |
| --- | --- | --- | --- | --- |
| `W`+`S` | `@` | | `S`+`X` | `` ` `` |
| `E`+`D` | `#` | | `D`+`C` | `\` |
| `R`+`F` | `$` | | `F`+`V` | `=` |
| `T`+`G` | `%` | | `G`+`B` | `!` |

Right hand, same idea:

| Squeeze | Sends | | Squeeze | Sends |
| --- | --- | --- | --- | --- |
| `Y`+`H` | `^` | | `H`+`N` | `~` |
| `U`+`J` | `+` | | `J`+`M` | `-` |
| `I`+`K` | `*` | | `K`+`,` | `/` |
| `O`+`L` | `&` | | `L`+`.` | `\|` |

### Brackets go horizontal

Adjacent keys on the right hand. The row picks the bracket:

| Row | Open | Close | Sends |
| --- | --- | --- | --- |
| Top | `U`+`I` | `I`+`O` | `[` `]` |
| Home | `J`+`K` | `K`+`L` | `(` `)` |
| Bottom | `M`+`,` | `,`+`.` | `{` `}` |

All six are live on `NUM` too.

Hold Shift while squeezing the home row pair and you get `<` `>` instead, through the
`lpar_lt` and `rpar_gt` mod-morphs.

Hold the home row pair instead of tapping it and you get a modifier chord: `J`+`K` held
is Shift+Ctrl, `K`+`L` held is Ctrl+Alt, the same two mods the keys carry on their own.

### One breaks the pattern

`_` is **`J`+`L`**, ring and index skipping the middle finger on the right home row. It
gets the best free position on the board because `snake_case` costs you an underscore
every few words.

`~` used to sit on `S`+`F` the same way, but holding those two is Alt+Shift, which zellij
uses for tab switching, and the combo fired a tilde under the chord. Nothing lives on a
home-row pair now.

### Everything else

| Squeeze | Sends |
| --- | --- |
| `X`+`V` | Cut |
| `X`+`C` | Copy |
| `C`+`V` | Paste |
| Both middle thumbs | Caps Word |
| Both outer thumbs | Caps Lock |

Cut, copy and paste send `Shift+Del`, `Ctrl+Ins` and `Shift+Ins` rather than
`Ctrl+X/C/V`, so they survive a terminal where `Ctrl+C` means SIGINT.

### What has no combo

`:` is Shift+`;` or the `Esc` position on `NUM`. `!` is also on `NUM`, on `B` beside
the `3`. Everything else you need is either a combo, a base-layer key or its shifted form.

---

## Combo timing

Two numbers govern every combo.

**`timeout-ms`** is how close together the two keys must land. **`require-prior-idle-ms`**
is how much quiet is needed *before* the combo will fire at all, which stops a fast letter
roll triggering it mid-word.

| Constant | Value | Effect |
| --- | --- | --- |
| `COMBO_IDLE` | 50 | the default guard |
| `COMBO_IDLE_NONE` | 0 | no guard at all |

Seven combos run with no guard, because you type them straight after a letter and their
key pair is not an English bigram:

| Combo | Keys | Bigram | Why open |
| --- | --- | --- | --- |
| `_` | `J`+`L` | `jl` | never occurs. `snake_case` needs it mid-identifier |
| `[` `]` | `U`+`I`, `I`+`O` | `ui`, `io` | typed right after an identifier, as in `arr[0]` |
| `(` `)` | `J`+`K`, `K`+`L` | `jk`, `kl` | typed right after a name, as in `func(` |
| `[` `]` on NAV | same | none | `NAV` has no letters at those positions |

Those four bracket and paren combos use an 18ms window, which is the real guard. Sustained,
18ms is around 660wpm, and even fast same-hand rolls land nearer 30 to 50ms.

Everything else keeps the 50ms default.

`I` carries five combos, which was the stock ceiling, so `CONFIG_ZMK_COMBO_MAX_COMBOS_PER_KEY`
is raised to 6. Past the limit a combo silently never fires and ZMK gives no warning.

---

## Behaviours

### Home-row mods

```
flavor                  = balanced
tapping-term-ms         = 280
quick-tap-ms            = 175
require-prior-idle-ms   = 150
hold-trigger-key-positions = opposite hand + thumbs
hold-trigger-on-release
```

`require-prior-idle-ms` kills the hold if you were mid-word, so fast typing never produces
a stray Ctrl. The positional trigger means a hold only counts when the other hand presses
something, which rules out same-hand misfires. `quick-tap-ms` lets you repeat a letter by
tapping then holding.

### Thumbs

| Behaviour | Flavor | Term | Bindings | Used on |
| --- | --- | --- | --- | --- |
| `&mo` | n/a | n/a | layer only | `MED` |
| `sticky_shift_mod_layer` | balanced | 150 | `&mo` / `&sk` | `NUM` |
| `&lt` | balanced | 200 | `&mo` / `&kp` | `NAV`, `SYM`, `FNC` |
| `space_layer` | tap-preferred | 200 | `&mo` / `&kp` | `VDP` |

`MED` is a plain `&mo`, so it engages on press with no term to wait out and no tap branch
that can misfire. `&lt` and `space_layer` carry `quick-tap-ms = 175` so Backspace, Enter
and Space autorepeat on a tap-then-hold. The sticky thumb does not: on a sticky mod there
is nothing to repeat, and it would only forbid the layer on a quick re-press. Sticky keys
release after 1500ms or on the next keypress, whichever comes first.

`balanced` means a hold counts as soon as another key is pressed *and released* while the
thumb is down, so the first digit on `NUM` fires without waiting out the term.

Space is the exception. Under `balanced`, typing a space and rolling into the next letter
resolves as a hold and the space disappears into `VDP`. `tap-preferred` ignores the
interrupting key entirely and decides on the term alone, so the only way to reach `VDP` is
a deliberate 200ms hold. That suits a layer you reach to switch desktops, not mid-word.

### Caps Word

Stock v0.3 behaviour. Modifiers pass through, and any key outside letters, digits and
the continue list ends it.

---

## Two hosts, one monitor

Profile 0 is the Arch box, profile 1 is the Mac. Both machines bind the same
`Ctrl+Alt+Gui` hotkeys, so whichever host currently owns the keyboard can drive the
monitor to either input.

```
DISP_ARCH = Ctrl+Alt+Gui+1    →  DisplayPort-1 (0x0f)
DISP_MAC  = Ctrl+Alt+Gui+2    →  HDMI-1        (0x11)
```

The `sw_arch` and `sw_mac` macros fire the monitor hotkey **first**, then hand over the
Bluetooth link. Order matters: the host you are leaving still owns the connection when the
hotkey goes out.

KDE matches the modifier set exactly, so the Mac binds the same three modifiers rather
than a four-modifier hyper.

### The Mac clipboard caveat

ZMK cannot tell which host it is talking to, so `Ctrl+C` from the keyboard stays `Ctrl+C`
on both. Fix it on the Mac rather than in firmware:

> System Settings → Keyboard → Keyboard Shortcuts → Modifier Keys, pick the Corne in the
> device dropdown, swap Command and Control.

That targets one device and leaves the built-in Mac keyboard alone. Every `Ctrl` shortcut
and the home-row `Ctrl` come along with it.

The trade: the `Shift+Del`, `Ctrl+Ins` and `Shift+Ins` clipboard combos stop working on
the Mac after the swap. The `NAV` clipboard row covers you there.

---

## Config and build

```
CONFIG_ZMK_IDLE_TIMEOUT=30000
CONFIG_ZMK_SLEEP=y
CONFIG_ZMK_IDLE_SLEEP_TIMEOUT=900000
CONFIG_BT_CTLR_TX_PWR_PLUS_8=y
CONFIG_ZMK_COMBO_MAX_COMBOS_PER_KEY=6
```

Transmit power stays at +8dBm. Sleep is where the battery win is, and cutting radio power
costs range.

### The two idle states

| State | After | What happens | Wake cost |
| --- | --- | --- | --- |
| Idle | 30s | Quiets activity, keeps Bluetooth connected | Instant |
| Deep sleep | 15 min | Drops Bluetooth, powers down peripherals, wipes RAM | Few seconds |

Deep sleep clears RAM, so waking is a cold start of the Bluetooth stack rather than a
resume. Both halves sleep independently, so the left half reconnects to the right half
**and** to the host before anything registers. The keypress that wakes it is spent waking
it and never reaches the host.

A few seconds after a long gap is the expected behaviour, not a fault. Deep sleep needs no
keymap binding: it runs off the inactivity timer, and the only requirement beyond
`CONFIG_ZMK_SLEEP` is a `wakeup-source` on the kscan, which the v0.3 Corne shield already
declares.

To make it sleep less often, raise `CONFIG_ZMK_IDLE_SLEEP_TIMEOUT`. That will not help the
first use of the day, which has slept overnight regardless. To remove the delay entirely,
set `CONFIG_ZMK_SLEEP=n` and accept roughly weeks per charge instead of months.

| Dependency | Source | Pin |
| --- | --- | --- |
| ZMK | `zmkfirmware/zmk` | `v0.3` |
| Helpers | `urob/zmk-helpers` | `v0.3` |
| Tri-state | `dhruvinsh/zmk-tri-state` | `main` |

Board `nice_nano_v2`, shields `corne_left` and `corne_right`.

```fish
bash commands.sh
```

That builds both halves in Docker and copies `zmk_left.uf2` and `zmk_right.uf2` into the
repo root. Double-tap reset on a half to mount it, then drop the matching file on.

`MED` plus the top outer corner of a half drops that half into the bootloader without
reaching for the reset button.

---

## Known gaps

**Five ways to press Shift.** Both pinky keys, both home-row mods, one sticky thumb. The
two bottom-row pinky keys are the only genuinely spare real estate on `DEF`.
