---
layout: page
title: Portfolio
---

<div class="portfolio-grid">
    {% for project in site.data.portfolio %}
    <div class="portfolio-item">
        <img src="{{ project.image }}" alt="{{ project.title }}" class="portfolio-img">
        <div class="portfolio-content">
            <h3>{{ project.title }}</h3>
            <p>{{ project.description }}</p>
            <a href="{{ project.link }}" class="btn" style="margin-top: 10px; font-size: 0.9rem;">View Project</a>
        </div>
    </div>
    {% endfor %}
</div>
