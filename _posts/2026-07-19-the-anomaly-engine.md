---
layout: post
title:  "The Anomaly Engine"
date:   2026-07-19 09:00:00 -0700
image: /assets/images/posts/2026-07-19-the-anomaly-engine/vibe-info-all-melodic.png
description: "A drum-solo bug that silenced a whole track got fixed properly, then rebuilt on purpose as a tunable effect, and then seven more followed. Built almost entirely by AI across two overnight sessions."
---

"Anomaly" is my term for odd, interesting issues that show up in apps from time to time. The kind that might turn into a real bug, might be a one-off service hiccup, or might never be seen again. This time, I knew it was a real bug, but I liked its effect and started prompting Fable with:
>"I've run into a weird issue twice, where in Lost in Space the music cuts out mid section... The thing is, its brilliant if we tweak it a bit, we need the sound to ramp down and ramp back up..."

With only a couple of days left of Fable 5 access, I wanted to see what it could do over a couple of nights while I slept. AnomalyEngine is the result! I captured that sequence, made it tunable, and added it to the Vibes with a rare probability. I knew I needed to be able to activate the anomaly on demand, so I added that too.


### What Was the Bug?

Drum-lead handoffs are a rare, deliberate device in the Pulsar solo-handoff system (`liborpheus_dsp/src/pulsar_handoff.h`): about one in eight handoffs (a 12% roll) pass the lead to the drum track, gated to `SoloModeId::LICK_BUILDER` mode, and never twice in a row. One of three possible handoff styles is `BREAK`, which intentionally ducks every other melodic voice so the drum lead can solo alone. That ducking is a real, working arrangement feature, not the bug.

The bug was that nothing exempted the drum lead's own tracks from that duck when they were also typed `Melodic`, which is exactly the situation in `LostInSpaceVibe.kt`: all 8 tracks were `Melodic`, and zero `Percussive`. With no percussion track around to dodge the "wipe every Melodic track" filter, a `BREAK` landing on Lost In Space wiped the drummer's own just-rendered rhythm along with everything else, silencing the whole sequencer.

<img src="/assets/images/posts/2026-07-19-the-anomaly-engine/vibe-info-all-melodic.png" alt="Vibe Info sheet showing every Lost In Space track as Lead/Melodic, no Drums/Perc track" style="max-width: 360px; border-radius: 8px;">

The fix is small and specific: `render_drum_lead` now exempts the lead member's own tracks, with a code comment documenting the exact failure mode for whoever reads it next. But the sound that bug made by accident didn't just disappear. Separately, without reusing the buggy wipe, the Void Anomaly rebuilt that ramp-down, silence, ramp-back-up experience as its own independently tunable gain-envelope effect. The bug is fixed. The sound it made by accident was recreated on purpose.

### Night 1

With the bug understood and fixed, I kept the session going and had it build the Void Anomaly: a tunable duck where volume ramps down, settles on a near-silent floor (with an optional ghost flicker instead of dead silence), then ramps back up. I wired it into the Vibe system at a rare probability, added a manual trigger. Before I called it a night, I sealed the Anomaly schema. That was the deliberate part: get the shape right while the scope is still one effect, so night two is filling in a contract instead of negotiating one.

<video class="video-lightbox-trigger" src="https://github.com/balch/balch.github.io/releases/download/anomalies-assets/void-anomaly.mp4" autoplay loop muted playsinline style="max-width: 360px; border-radius: 8px;"></video>

It landed on `main` as [`e3ed37a3`](https://github.com/balch/orphic-fm-app/commit/e3ed37a39f2bab980f10a9cb376c9b5850544cb6), tagged **v1.8.0**, "Lost in Space, Fire Sky, and Anomalies."

### Night 2

Night two added seven more: Tape, Scratch, Filter, Crossfade, Cut, Swell, and Wah, plus a per-track lick-wah. The decision I made going in was to build them as reusable Master* output-stage effects rather than one-Vibe specials. Void earned its Vibe-specific hook because it came from a Vibe-specific bug. The other seven had no such excuse, and eight bespoke effects would have been eight places to fix the same problem later.

It landed on `main` as [`78863406`](https://github.com/balch/orphic-fm-app/commit/78863406888a62a283076373536e6a580f86b778), tagged **v1.8.1**, "Master Anomaly Effects & Pulsar Enhancements."

### By the Numbers

These are the machine-side numbers.

| Metric | Night 1 | Night 2 |
|:---|:---:|:---:|
| Dates | Fri Jul 17, 8:12 PM to Sat Jul 18, 1:05 PM PDT (about 17 hours) | Sat Jul 18, 9:20 PM to Sun Jul 19, 2:33 AM PDT (about 5 hours 13 minutes) |
| Models | `claude-fable-5` + `claude-opus-4-8` | `claude-opus-4-8` |
| Subagent dispatches | 44 | 29 |
| Output tokens | 1.73M | 770K |
| Commit | [`e3ed37a3`](https://github.com/balch/orphic-fm-app/commit/e3ed37a39f2bab980f10a9cb376c9b5850544cb6) (v1.8.0) | [`78863406`](https://github.com/balch/orphic-fm-app/commit/78863406888a62a283076373536e6a580f86b778) (v1.8.1) |

### One Last Thing

Both v1.8.0 and v1.8.1 used AI to facilitate the release process: tagging, building the AAB and APK, and publishing the GitHub release were all managed by AI after thorough testing (aka listening). I used **Antigravity** and _Gemini-3.5-Flash (high)_ to push the releases to manage my Anthropic quota.

There's more on how the Void Anomaly sounds and where it sits in the mix on the [orphic-fm devlog](https://orphic.fm/devlog/#lost-in-space). The whole app, DSP engine included, is open source at [github.com/balch/orphic-fm-app](https://github.com/balch/orphic-fm-app).