---
layout: post
title:  "Introducing Orphic-FM"
date:   2026-01-03 12:00:00 -0800
image: /assets/images/posts/2026-01-03-hello-orpheus-fm/orpheus_avatar.webp
description: "Meet Orpheus, the AI-powered persona of Orphic-FM - a Synth FM Software Emulator built with Kotlin/Compose Multiplatform."
redirect_from:
  - /2026/01/03/hello_orpheus-fm.html
  - /2026/01/03/hello_orpheus-fm/
---

### <img src="/assets/images/posts/2026-01-03-hello-orpheus-fm/orpheus_avatar.webp" alt="Orpheus" style="height: 2.0em; vertical-align: middle; margin-right: 0.3em;"> Meet Orpheus from Orphic-FM!

> **Orpheus** (from Ancient Greek: Ὀρφεύς) was a **divine musician** from *Greek Mythology* who used his music to charm Hades and Persephone so he could *rescue* his wife, **Eurydice** from the **Underworld**. He was a master of the **Lyre**.

> **FM** stands for *Frequency Modulation* which describes a technique to enhance sound by creating **rich harmonics** involving changing the pitch of waveforms produced by Oscillators. 

**Orphic-FM** is a software app inspired by the [LYRA-8](https://somasynths.com/lyra-organismic-synthesizer/) *organismic synthesizer* invented by SOMA LABORATORY. This app's official purpose is to provide a platform for musical creativity enhanced by AI integration. In reality, I'm just looking for some interesting sounds and visuals to help me relax and meditate. 

The AI integration features a persona named **Orpheus** who has full access to all the sound features in the app. The agent operates by streaming prompts and tool commands in an effort to shape the soundscape in real-time. The AI integration contains:

- **Drone Mode** – AI creates evolving background drones used to accompany the user sonic creations
- **Solo Mode** – Sit back and watch the AI generate a complete compilation based on predefined prompts that represent parts of a song
- **Tidal Mode** – Uses the [TidalCycles](https://tidalcycles.org) programming language to create interactive music the user can "watch" and "change" in real-time
- **Chat Mode** – User can issue prompts to create and influence sounds

#### Quick Demos

<div class="video-grid">
  <div class="video-container">
    <video class="video-lightbox-trigger" src="/assets/images/posts/2026-01-03-hello-orpheus-fm/pads.mp4" autoplay loop muted playsinline></video>
    <button class="sound-toggle" aria-label="Toggle sound">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 5L6 9H2v6h4l5 4V5z"/><line x1="23" y1="9" x2="17" y2="15"/><line x1="17" y1="9" x2="23" y2="15"/></svg>
    </button>
  </div>
  <div class="video-container">
    <video class="video-lightbox-trigger" src="/assets/images/posts/2026-01-03-hello-orpheus-fm/strings.mp4" autoplay loop muted playsinline></video>
    <button class="sound-toggle" aria-label="Toggle sound">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 5L6 9H2v6h4l5 4V5z"/><line x1="23" y1="9" x2="17" y2="15"/><line x1="17" y1="9" x2="23" y2="15"/></svg>
    </button>
  </div>
</div>

Getting compelling sounds out of the instrument is an art which I intend to explore in a series of posts about soundscaping, feature demonstrations, and technical underpinnings of the app.

Features I intend to cover include

| Feature                                                   | Description                                                      | Visuals                                                                                                                                                                                                                                                                                  |
|:----------------------------------------------------------|:-----------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Separation of Concerns<br>Single Responsibility Principle | Architecture to support many dynamic features                    | <img src="/assets/images/posts/2026-01-03-hello-orpheus-fm/architecture_diagram.webp" alt="Architecture Diagram" style="height: 120px; border-radius: 6px;">                                                                                                                             |
| Adaptive UX                                               | App supports different UX for Desktop and Mobile formfactors     | <img src="/assets/images/posts/2026-01-03-hello-orpheus-fm/mobile_portrait.webp" alt="Portrait" style="height: 100px; border-radius: 6px;"><img src="/assets/images/posts/2026-01-03-hello-orpheus-fm/mobile_landscape.webp" alt="Landscape" style="height: 100px; border-radius: 6px;"> |
| Frequency Modulation, LFOs, Delays                        | Sound scaping tools                                              | <img src="/assets/images/posts/2026-01-03-hello-orpheus-fm/fm_lfo_delays.webp" alt="FM LFO Delays" style="height: 80px; border-radius: 6px;">                                                                                                                                            |
| TidalCycles and REPL                                      | Mini-Notation for defining and playing music in code             | <video class="video-lightbox-trigger" src="/assets/images/posts/2026-01-03-hello-orpheus-fm/REPL.mp4" autoplay loop muted playsinline style="height: 100px; border-radius: 6px;"></video>                                                                                                |
| AI Agent App integration                                  | Using Prompts and Tools for Sound Control                        | <video class="video-lightbox-trigger" src="/assets/images/posts/2026-01-03-hello-orpheus-fm/ai_song.mp4" autoplay loop muted playsinline style="height: 100px; border-radius: 6px;"></video>                                                                                             | 
| Midi integration                                          | MIDI devices for external control with interactive learning mode | <img src="/assets/images/posts/2026-01-03-hello-orpheus-fm/midi_integration.webp" alt="MIDI Integration" style="height: 100px; border-radius: 6px;">                                                                                                                                     |
| TBD                                                       |                                                                  |                                                                                                                                                                                                                                                                                          | 

