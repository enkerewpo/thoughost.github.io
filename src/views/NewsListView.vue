<script lang="ts">
import { news_s } from '../assets/resources'
import { defineComponent } from 'vue'

export default defineComponent({
  computed: {
    newsData() {
      return (news_s || []).filter((n: any) => n && n.id)
    }
  },
  data() {
    return {}
  }
})
</script>

<template>
  <div class="news-page container">
    <div class="page-title">
      <h2>NEWS</h2>
    </div>
    <div class="news-list">
      <div v-for="item in newsData" :key="item.id" class="news-item">
        <span class="news-date-tag">{{ item.date }}</span>
        <a :href="`/news/${item.id}`" class="news-link">{{ item.title }}</a>
      </div>
    </div>
  </div>
</template>

<style scoped>
.news-page {
  padding-top: 40px;
  padding-bottom: 40px;
}

.page-title {
  margin-bottom: 24px;
}

.page-title h2 {
  font-size: 1.25rem;
  font-weight: 600;
  margin: 0;
}

.news-list {
  display: flex;
  flex-direction: column;
  gap: 0;
}

.news-item {
  display: flex;
  align-items: baseline;
  gap: 12px;
  padding: 20px 0;
  border-bottom: 1px solid rgba(0, 0, 0, 0.12);
}

.news-date-tag {
  flex-shrink: 0;
  font-size: 0.75rem;
  font-weight: 600;
  color: #fff;
  background: #101010;
  padding: 4px 10px;
  min-width: 90px;
  text-align: center;
}

.news-link {
  font-weight: 600;
  color: #101010;
  text-decoration: none;
  transition: opacity 0.2s ease;
}

.news-link:hover {
  opacity: 0.6;
}

@media (max-width: 768px) {
  .news-item {
    flex-wrap: wrap;
  }
}
</style>
