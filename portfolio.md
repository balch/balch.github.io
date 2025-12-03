---
layout: page
title: Portfolio
permalink: /portfolio/
---

<div class="portfolio-grid">
    {% for project in site.data.portfolio %}
    <div class="portfolio-item{% if project.featured %} featured{% endif %}">
        <img src="{{ project.image }}" alt="{{ project.title }}" class="portfolio-img">
        <div class="portfolio-content">
            <h3>{{ project.title }}</h3>
            {% if project.awards %}
            <div class="portfolio-awards">
                {% for award in project.awards %}
                <span class="award-badge">🏆 {{ award }}</span>
                {% endfor %}
            </div>
            {% endif %}
            <p>{{ project.description }}</p>
            {% if project.technologies %}
            <div class="tech-tags">
                {% for tech in project.technologies %}
                <span class="tech-tag">{{ tech }}</span>
                {% endfor %}
            </div>
            {% endif %}
            <a href="{{ project.link }}" class="btn" style="margin-top: 10px; font-size: 0.9rem;">View Project</a>
        </div>
    </div>
    {% endfor %}
</div>
