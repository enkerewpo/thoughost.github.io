<script lang="ts">
import { news_s, news_images_s } from '../assets/resources'

export default {
  computed: {
    get_news() {
      const id = (this as any).$route?.params?.id as string;
      return id ? news_s.find((n: any) => n.id === id) : undefined;
    },
    get_image() {
      const id = (this as any).$route?.params?.id as string;
      return id ? news_images_s.find((n: any) => n.id === id) : undefined;
    },
    /** Content with plain URLs turned into clickable links. */
    contentWithLinks(): string {
      const raw = this.get_news?.content;
      if (!raw || typeof raw !== 'string') return '';
      // Match http(s):// then any character that can appear in a URL (no whitespace, no <>"')
      const urlRe = /(^|[\s>])(https?:\/\/[^\s<>"']+)/g;
      const escape = (s: string) =>
        s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/"/g, '&quot;');
      return raw.replace(urlRe, (_: string, before: string, url: string) => {
        const trimmed = url.replace(/[.!?)\]\u201d\u2019]+$/, '');
        const suffix = url.slice(trimmed.length);
        return `${before}<a href="${escape(trimmed)}" target="_blank" rel="noopener">${escape(trimmed)}</a>${suffix}`;
      });
    },
  },
}
</script>

<template>
  <div class="news-detail-view container">
    <div v-if="get_news == undefined" class="news-detail">
      <p class="news-not-found">News {{ $route.params.id }} not found.</p>
    </div>
    <div v-else class="news-detail">
      <p class="news-date">{{ get_news.date }}</p>
      <h1 class="news-title">{{ get_news.title }}</h1>
      <img v-if="get_image != undefined" class="news-image" :src="get_image.url" alt="">
      <div class="news-content" v-html="contentWithLinks"></div>
    </div>
  </div>
</template>

<style scoped>
.news-detail-view {
  padding-top: 40px;
  padding-bottom: 60px;
}

.news-detail {
  max-width: 720px;
  margin: 0 auto;
}

.news-date {
  font-size: 0.75rem;
  font-weight: 600;
  color: #101010;
  margin: 0 0 8px 0;
}

.news-title {
  font-size: 1.5rem;
  font-weight: 600;
  margin: 0 0 24px 0;
  line-height: 1.3;
}

.news-not-found {
  color: #101010;
  margin: 0;
}

.news-image {
  width: 100%;
  max-width: 100%;
  display: block;
  margin-bottom: 24px;
}

.news-content {
  font-size: 1rem;
  line-height: 1.6;
  color: #101010;
}

.news-content :deep(p) {
  margin: 0 0 12px 0;
}

.news-content :deep(a) {
  color: #101010;
  text-decoration: underline;
}

.news-content :deep(a:hover) {
  opacity: 0.7;
}

.news-content :deep(h1),
.news-content :deep(h2),
.news-content :deep(h3),
.news-content :deep(h4),
.news-content :deep(h5),
.news-content :deep(h6) {
  font-size: 1.1rem;
  font-weight: 600;
  margin: 24px 0 8px 0;
}

.news-content :deep(ul),
.news-content :deep(ol) {
  margin: 12px 0;
  padding-left: 24px;
}

.news-content :deep(li) {
  margin-bottom: 4px;
}

.news-content :deep(blockquote) {
  margin: 20px 0;
  padding: 12px 0 12px 16px;
  border-left: 3px solid #101010;
  color: #101010;
}

.news-content :deep(img) {
  max-width: 100%;
  height: auto;
  margin: 12px 0;
}
</style>