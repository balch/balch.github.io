---
layout: post
title:  "FOA - Feature Oriented Architecture"
date:   2026-01-25 09:00:00 -0800
image: /assets/images/posts/2026-01-25-synth-feature-pattern/intro_graphic_v2.png
description: "Discover how the SynthFeature pattern enforces single responsibility, simplifies AI reasoning, and unlocks powerful Compose previews."
---

### Feature-Oriented Architecture
This body describes architecture patterns used to add multiple *Features* to the **Orphic-FM Synthesizer Emulator**. 

### Feature Definition

When I think of software applications, I think in terms of features:
 - What features does this app have?
 - Are they useful to me?
 - How often are new features released?
 - How do I access the features from the app?
   - On Mobile/Desktop/Tablet/TV

So exactly what is a *Feature*? I define it as **distinct functionality** that makes an application useful. Features need to **work independently** but also need to collaborate with other features. This happens by contributing inputs or consuming outputs to and from other features.

Most features are designed for **end users** and implement some kind of **UX flow**, displaying a user interface in a variety of form factors and translating user input (a.k.a. Intents) into actions designed to influence the feature. 

Some features are **internal** and meant to add benefit to the app owner. **Analytics** is an example of this and something I consider a *Feature* of the app. 

### Scalability 

Most importantly, features need to **scale**. In addition to supporting multiple new and evolving behaviors, apps need to be able to turn features on and off based on experimentation, availability, and other reasons specific to the app owners' discretion.   

Scalability also covers how the feature is displayed and accessed. With many features, how the user navigates between features is a critical challenge that directly relates to customer satisfaction. Supporting different form factors requires the feature to "morph" into UI containers of all sizes and dimensions. This is where choosing a feature architecture that supports Compose Previews is critical for scaling feature development. 

These days we also need to take AI into consideration when discussing scalable feature architectures. To this end, a well-encapsulated feature definition with easy-to-follow patterns will make AI more productive in the short and long term. 

### Technical Anatomy of a Feature

From a Kotlin Multiplatform perspective, a feature typically consists of:
 - Business Logic: distinct functionality necessary for the feature to complete its goal
 - State: Used to reflect the current conditions the feature is operating under and what the feature wants to convey to the user
 - Actions: operations performed by the user or system used to convey intent to influence the feature. 


#### Business Logic
For KMP, Business Logic is typically orchestrated in the *ViewModel* where it delegates the *heavy lifting* into other well-encapsulated modules that perform tasks and gather (or generate) data necessary for the feature to complete its purpose. The modules often take the form of *Repositories*, *UseCases*, or other defined components and are relevant to this architecture as the **Providers for State** and **Consumers of Actions**.
















<figure class="fig-left fig-small">
  <img src="/assets/images/posts/2026-01-25-synth-feature-pattern/intro_graphic_v2.png" alt="Main Screen">
  <figcaption>Synth FM Emulator</figcaption>
</figure>

Building complex applications—like a modular synthesizer—requires a robust architecture that can scale. When we introduce AI agents into the mix, clarity becomes even more critical. AI needs to understand *what* the application does (State) and *how* to control it (Actions) without getting bogged down in implementation details.

Enter the **SynthFeature** pattern.

### The Problem: Monolithic ViewModels

In traditional modern Android development, ViewModels often become "God Objects." They expose StateFlow instances, handle navigation, manage lifecycle, and define ad hoc callback functions for the UI. This tight coupling makes it hard to:

1.  **Test**: You have to mock the entire ViewModel.
2.  **Preview**: You can't easily preview a Composable that strictly requires a `ViewModel`.
3.  **Reason**: An AI agent looking at the code sees a jumble of unrelated responsibilities.

### The Solution: SynthFeature<S, A>

The `SynthFeature` pattern explicitly separates **State** from **Behavior** (Actions). It is defined by a simple interface:

```kotlin
/**
 * A feature that exposes state as a StateFlow and stable actions.
 * Child composables should collect state at the leaf level for optimal recomposition.
 */
interface SynthFeature<S, A> {
    val stateFlow: StateFlow<S>
    val actions: A
}
```

This interface acts as a contract between the **Business Logic** (ViewModel) and the **UI** (Composable).

#### Architecture Diagram

<img src="/assets/images/posts/2026-01-25-synth-feature-pattern/synth_feature_diagram.png" alt="SynthFeature Architecture Diagram" style="width: 100%; border-radius: 8px; margin: 20px 0;">

### Why It Matters

#### 1. Single Responsibility Principle (SRP)
By decoupling the "Feature" definition from the `ViewModel` implementation, we adhere strictly to SRP.
-   **The Interface**: Defines the contract.
-   **The ViewModel**: Handles lifecycle, dependency injection, and data persistence behind the scenes.
-   **The UI**: Only knows about `SynthFeature`. It observes `stateFlow` and invokes `actions`.

#### 2. AI Encapsulation
This is the hidden superpower. When an AI agent (like the Orpheus persona) needs to interact with a feature, it looks for the `SynthFeature` definition.
-   **State (`S`)**: The AI can read the current state to understand the context.
-   **Actions (`A`)**: The AI sees a clearly defined set of operations it can perform (e.g., `setFrequency`, `triggerNote`).
There is no ambiguity. The AI doesn't need to parse complex side-effects or navigate private methods. It just calls the action.

#### 3. Powering Compose Previews
Because the UI only requires an interface, we can create lightweight "Fake" implementations for our `@Preview` functions.

```kotlin
// A fake implementation for Previews
class FakeOscillatorFeature : SynthFeature<OscillatorState, OscillatorActions> {
    override val stateFlow = MutableStateFlow(OscillatorState(frequency = 440f))
    override val actions = object : OscillatorActions {
        override fun setFrequency(hz: Float) { /* no-op */ }
    }
}

@Preview
@Composable
fun PreviewOscillator() {
    OscillatorScreen(feature = FakeOscillatorFeature())
}
```
No more crashing previews because of missing `ViewModelStore` or Dependency Injection errors!

### Conclusion

The `SynthFeature` pattern has been instrumental in building **Orphic-FM**. It keeps our codebase clean, our tests reliable, and our AI integration seamless. Just as a synthesizer module has a clear input and output, our software components should too.
