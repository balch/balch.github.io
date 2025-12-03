---
layout: page
title: Blog
permalink: /blog/
---

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
