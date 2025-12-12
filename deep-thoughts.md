---
layout: default
title: Balch Blog
permalink: /deep-thoughts/
---

<!-- Deep Thoughts Quote Section -->
<div class="deep-thoughts-container">
    <div class="deep-thoughts-card">
        <h2 class="deep-thoughts-title">Deep Thoughts</h2>
        <button class="gear-button" onclick="getNewQuote()" aria-label="Get a new deep thought">
            <svg class="gear gear-large" xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M12 20a8 8 0 1 0 0-16 8 8 0 0 0 0 16Z"></path>
                <path d="M12 14a2 2 0 1 0 0-4 2 2 0 0 0 0 4Z"></path>
                <path d="M12 2v2"></path>
                <path d="M12 22v-2"></path>
                <path d="m17 20.66-1-1.73"></path>
                <path d="M11 10.27 7 3.34"></path>
                <path d="m20.66 17-1.73-1"></path>
                <path d="m3.34 7 1.73 1"></path>
                <path d="M14 12h8"></path>
                <path d="M2 12h2"></path>
                <path d="m20.66 7-1.73 1"></path>
                <path d="m3.34 17 1.73-1"></path>
                <path d="m17 3.34-1 1.73"></path>
                <path d="m11 13.73-4 6.93"></path>
            </svg>
            <svg class="gear gear-small" xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M12 20a8 8 0 1 0 0-16 8 8 0 0 0 0 16Z"></path>
                <path d="M12 14a2 2 0 1 0 0-4 2 2 0 0 0 0 4Z"></path>
                <path d="M12 2v2"></path>
                <path d="M12 22v-2"></path>
                <path d="m17 20.66-1-1.73"></path>
                <path d="M11 10.27 7 3.34"></path>
                <path d="m20.66 17-1.73-1"></path>
                <path d="m3.34 7 1.73 1"></path>
                <path d="M14 12h8"></path>
                <path d="M2 12h2"></path>
                <path d="m20.66 7-1.73 1"></path>
                <path d="m3.34 17 1.73-1"></path>
                <path d="m17 3.34-1 1.73"></path>
                <path d="m11 13.73-4 6.93"></path>
            </svg>
        </button>
        <div class="quote-content">
            <p class="quote-text" id="quoteText"></p>
            <p class="quote-author" id="quoteAuthor"></p>
        </div>
    </div>
</div>

<!-- Blog Posts List -->
<ul class="post-list">
    {% for post in site.posts %}
    <li class="post-item">
        <p class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</p>
        <h2 class="post-title">
            <a class="post-link" href="{{ post.url | relative_url }}">{{ post.title }}</a>
        </h2>
        {% if post.excerpt %}
        <div class="post-excerpt">
            {{ post.excerpt }}
        </div>
        {% endif %}
    </li>
    {% endfor %}
</ul>

<script>
    // Quotes data from Jekyll
    const quotes = [
        {% for quote in site.data.quotes %}
        { text: {{ quote.text | jsonify }}, author: {{ quote.author | jsonify }} }{% unless forloop.last %},{% endunless %}
        {% endfor %}
    ];

    // Shuffle function (Fisher-Yates)
    function shuffleArray(array) {
        const newArr = [...array];
        for (let i = newArr.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [newArr[i], newArr[j]] = [newArr[j], newArr[i]];
        }
        return newArr;
    }

    let shuffledQuotes = shuffleArray(quotes);
    let quoteIndex = 0;
    let isAnimating = false;
    let isGrinding = false;

    function displayQuote() {
        const quote = shuffledQuotes[quoteIndex];
        const textEl = document.getElementById('quoteText');
        const authorEl = document.getElementById('quoteAuthor');
        
        // Clear previous content
        textEl.innerHTML = '';
        authorEl.textContent = '';
        
        // Split into words and animate
        const words = quote.text.split(' ');
        
        // Add opening quote
        textEl.textContent = '"';
        
        words.forEach((word, index) => {
            const span = document.createElement('span');
            span.textContent = word;
            span.className = 'animate-word';
            span.style.animationDelay = `${index * 0.07}s`;
            textEl.appendChild(span);
            if (index < words.length - 1) {
                textEl.appendChild(document.createTextNode(' '));
            }
        });
        
        // Add closing quote
        const closingSpan = document.createElement('span');
        closingSpan.textContent = '"';
        closingSpan.className = 'animate-word';
        closingSpan.style.animationDelay = `${words.length * 0.07}s`;
        textEl.appendChild(closingSpan);
        
        // Set author with delay
        setTimeout(() => {
            authorEl.textContent = '— ' + quote.author;
            authorEl.classList.add('visible');
        }, words.length * 70 + 300);
        
        // Track animation state
        isAnimating = true;
        const animationDuration = 400 + words.length * 70;
        setTimeout(() => {
            isAnimating = false;
        }, animationDuration);
    }

    function getNewQuote() {
        if (isAnimating || isGrinding) return;
        
        // Start gear grinding animation
        isGrinding = true;
        const gearLarge = document.querySelector('.gear-large');
        const gearSmall = document.querySelector('.gear-small');
        gearLarge.classList.add('grinding');
        gearSmall.classList.add('grinding');
        
        // Haptic feedback if available
        if (navigator.vibrate) {
            navigator.vibrate([50, 100, 50, 70, 200]);
        }
        
        setTimeout(() => {
            // Move to next quote
            quoteIndex++;
            if (quoteIndex >= shuffledQuotes.length) {
                let newShuffled = shuffleArray(quotes);
                // Avoid immediate repeat
                if (quotes.length > 1 && newShuffled[0].text === shuffledQuotes[shuffledQuotes.length - 1].text) {
                    [newShuffled[0], newShuffled[1]] = [newShuffled[1], newShuffled[0]];
                }
                shuffledQuotes = newShuffled;
                quoteIndex = 0;
            }
            
            // Reset gear animation
            gearLarge.classList.remove('grinding');
            gearSmall.classList.remove('grinding');
            gearLarge.classList.add('spinning');
            gearSmall.classList.add('spinning-reverse');
            isGrinding = false;
            
            // Display new quote
            displayQuote();
            
            // Remove spin class after animation
            setTimeout(() => {
                gearLarge.classList.remove('spinning');
                gearSmall.classList.remove('spinning-reverse');
            }, 2000);
        }, 600);
    }

    // Initial quote display
    document.addEventListener('DOMContentLoaded', () => {
        displayQuote();
        
        // Start initial gear spin
        const gearLarge = document.querySelector('.gear-large');
        const gearSmall = document.querySelector('.gear-small');
        gearLarge.classList.add('spinning');
        gearSmall.classList.add('spinning-reverse');
        
        setTimeout(() => {
            gearLarge.classList.remove('spinning');
            gearSmall.classList.remove('spinning-reverse');
        }, 2000);
    });
</script>
