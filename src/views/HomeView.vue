<script lang="ts">
import Carousel from '@/components/Carousel.vue';
import { banner, rls_info_s, rls_cover, masks, news_s } from '../assets/resources'
export default {
  data() {
    return {
      project_txt: '「KAKUSATSU SHOUJO 3」',
      release_banner: banner,
      releases: rls_info_s.slice(0, 12),
      release_cover: rls_cover,
      release_mask: masks,
      news: news_s.slice(0, 4),
    }
  },
  components: { Carousel },
  methods: {
    get_news_link(id: any) {
      return `/news/${id}`
    }
  }
}
</script>

<template>
  <div class="home-view">
    <Carousel></Carousel>

    <!-- news container -->
    <div class="container tg-pt-40 tg-pb-40">
    <div class="tg-pb-40">
      <h2 class="tg-font-20">NEWS</h2>
    </div>
    <div class="tg-flex-lr tg-flex-wrap position-relative" style="margin-top: -26px;">
      <div v-for="n in news" :key="n.id" class="news-wrapper tg-font-12">
        <div class="d-inline-block">{{ n.date }}</div>
        <div class="d-inline-block">
          <a target="_top" :href="get_news_link(n.id)" class="news-link">
            <span>{{ n.title }}</span>
          </a>
        </div>
      </div>
      <div class="more">
        <a href="/news">
          <span class="tg-font-9">MORE</span>
        </a>
        <img src="@/assets/icons/more.svg">
      </div>
    </div>
  </div>

  <!-- releases -->
  <div style="background-color: #F2F2F2">
    <div class="container tg-pt-40 position-relative">
      <div class="tg-pb-40">
        <h2 class="tg-font-20">RELEASES</h2>
      </div>
      <div class="release-grid">
        <div v-for="release in releases" :key="release.id" class="release-cover"
          :style="`background-image:url(${release_cover(release.id)})`">
          <a target="_top" :href="release.homepage">
            <!-- <img :src="release_mask(release.type)"> -->
          </a>
        </div>
      </div>
      <div class="more">
        <a href="/releases">
          <span class="tg-font-9">MORE</span>
        </a>
        <img src="@/assets/icons/more.svg">
      </div>
    </div>
  </div>

  </div>
  <!-- <main class="container">
  <div class="mt-4 d-block w-100">
    <div class="title-header">
      <div>
        <h2>PROJECT</h2>
      </div>
      <div class="title-sub text-black-50" style="display:default">
        <a target="_top" :href="project_txt ? '/project' : '/'" :style="{ cursor: (project_txt ? 'pointer' : 'default') }">
          <span>MORE INFORMATION</span>
          <span class="iconfont icon-right"></span>
        </a>
      </div>
    </div>
    <div>
      <div class="project-item">
        <a target="_top" :href="project_txt ? '/project' : '/'" :style="{ cursor: (project_txt ? 'pointer' : 'default') }">
          <span>{{project_txt ? project_txt : "Next project comming soon..."}}</span>
        </a>
      </div>
    </div>
  </div>
</main> -->
</template>

<style scoped>
.news-wrapper {
  padding: 26px 0;
  font-weight: 600;
  border-bottom: 1px solid #A7A7A7;
  width: 47%;
}

.news-wrapper div:nth-child(1) {
  width: 110px;
  height: 22px;
  line-height: 22px;
  color: #fff;
  background-color: #101010;
  text-align: center;
  margin-right: 10px;
}

.news-link {
  color: #101010;
  font-weight: 600;
  text-decoration: none;
  background: linear-gradient(to left, rgb(255, 255, 255) 50%, rgb(0, 0, 0) 50%) right;
  background-size: 200%;
  transition: .3s ease-in-out;
}

.news-link:hover {
  color: #fff;
  padding: 0 10px;
  background-position: left;
  transition: .3s ease-in-out;
}

.more {
  position: absolute;
  right: 0;
  bottom: -44px;
  font-weight: 600;
  margin-bottom: 10px;
}

.more span {
  cursor: pointer;
  transition: .3s ease-in-out;
}

.more span:hover {
  background-color: #101010;
  color: #fff;
  padding: 0 10px;
  transition: .3s ease-in-out;
}

.more div {
  display: inline-block;
  vertical-align: middle;
}

.more img {
  height: 12px;
  margin-left: 5px;
  display: inline-block;
  vertical-align: middle;
}

.release-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 278px));
  justify-content: center;
  gap: 16px;
  margin-top: 0;
  padding-bottom: 52px;
}

.release-cover {
  width: 100%;
  aspect-ratio: 1;
  max-width: 278px;
  max-height: 278px;
  justify-self: center;
  background-size: cover;
  background-position: center;
  position: relative;
}

.release-cover a {
  display: block;
  position: absolute;
  inset: 0;
}

.release-bar:hover img {
  display: block;
}

.release-bar img {
  width: 100%;
  position: absolute;
  top: 0;
  display: none;
}

.project-item {
  width: 100%;
  background-color: black;
  padding-top: 12.51%;
  position: relative;
  cursor: pointer;
}

.project-item img {
  width: 100%;
  position: absolute;
  top: 0;
  display: none;
}

.project-item span {
  position: absolute;
  top: 0;
  width: 100%;
  height: 100%;
  text-align: center;
  color: white;
  font-weight: 600;
  font-size: 1.5rem;
  letter-spacing: 0.05rem;
  z-index: 2;
}

.project-item span:before {
  display: inline-block;
  content: "";
  height: 100%;
  vertical-align: middle;
}
</style>
