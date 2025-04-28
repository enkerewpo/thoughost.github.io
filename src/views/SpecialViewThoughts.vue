<template>
  <div class="thoughts-view">

  
    <div class="title-section">
      <h1>Thoughts</h1>
    </div>

    <div class="cover-section">
      <img class="cover" src="@/assets/special/thoughts_cover.jpg" alt="Thoughts Cover">
    </div>

    <!-- <h1>Thoughts</h1> -->
    
    <div class="main-sections">
      <section class="main-section">
        <div class="sub-title">Thoughts 诞生幕后</div>
        <div class="content">
          <div class="story-item">
            <h3>创作灵感</h3>
            <p>占位字符</p>
          </div>
          <div class="story-item">
            <h3>制作历程</h3>
            <p>占位字符</p>
          </div>
        </div>
      </section>

      <section class="main-section scrollable">
        <div class="sub-title">音乐制作幕后</div>
        <SimpleCarousel :items="musicCards" :autoRotateInterval="30000" />
      </section>

      <!-- 这里放一些设计相关的图 -->
      <section class="main-section">
        <div class="sub-title">设计图</div>
        <div class="design-images">
          <div class="design-image-item">
            <img src="@/assets/special/thoughts_background.png" alt="Thoughts Background">
            <p>图1：背景</p>
          </div>
          <div class="design-image-item">
            <img src="@/assets/special/thoughts_background.png" alt="Thoughts Background">
            <p>图2：背景</p>
          </div>
        </div>
      </section>

      <section class="main-section scrollable">
        <div class="sub-title">艺术设计幕后</div>
        <SimpleCarousel :items="artCards" :autoRotateInterval="30000" />
      </section>

      <section class="main-section">
        <div class="sub-title">Credits</div>
        <div class="credits">
          <div class="credit-group">
            <h3>Artist</h3>
            <div class="credit-list">
              <span>VeetaCrush</span>
              <span>Joulez</span>
              <span>潮音きつね</span>
              <span>望月真白</span>
              <span>Aki Sz</span>
              <span>かたぎり</span>
              <span>wheatfox</span>
              <span>Nirotiy</span>
              <span>桃罐</span>
              <span>Rayven</span>
            </div>
          </div>
          <div class="credit-group">
            <h3>Mastering</h3>
            <div class="credit-list">
              <span>Valtrax</span>
            </div>
          </div>
          <div class="credit-group">
            <h3>Illustration</h3>
            <div class="credit-list">
              <span>TARA#376</span>
            </div>
          </div>
          <div class="credit-group">
            <h3>Art Direction & Design</h3>
            <div class="credit-list">
              <span>Konseki Takane</span>
            </div>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import SimpleCarousel from '@/components/SimpleCarousel.vue'

export default defineComponent({
  name: 'SpecialViewThoughts',
  components: { SimpleCarousel },
  setup() {
    const musicCards = [
      { title: 'VeetaCrush', content: '占位段落', subtitle: 'TR01: palette ii' },
      { title: 'Joulez', content: '占位段落', subtitle: 'TR02: Awake' },
      { title: '潮音きつね', content: '占位段落', subtitle: 'TR03: 幽けきルミノールライト' },
      { title: '望月真白', content: '占位段落', subtitle: 'TR04: Lucidandelion' },
      { title: 'Aki Sz', content: '占位段落', subtitle: 'TR05: Titania' },
      { title: 'かたぎり', content: '占位段落', subtitle: 'TR06: December' },
      { title: 'wheatfox', content: '占位段落', subtitle: 'TR07: 6 p.m.' },
      { title: 'Nirotiy', content: '占位段落', subtitle: 'TR08: Voix sacrée' },
      { title: '桃罐', content: '占位段落', subtitle: 'TR09: 曇天' },
      { title: 'Rayven', content: '占位段落', subtitle: 'TR10: Epilogue' }
    ]
    const artCards = [
      { title: 'TARA#376', subtitle: 'Illustration', content: '占位段落' },
      { title: 'Konseki Takane', subtitle: 'Art Direction & Design', content: '占位段落' }
    ]
    return { musicCards, artCards }
  }
})
</script>

<style scoped>

.title-section {
  margin-top: 2rem;
  margin-bottom: 2rem;
  background-color: #000000;
  padding: 2rem;
}

.title-section h1 {
  color: #ffffff;
  margin: 0;
  font-size: 2.5rem;
  font-weight: 700;
}

.thoughts-view {
  padding: 0;
  max-width: 100%;
  margin: 0;
  font-family: 'Poppins', 'Noto Sans JP', 'Noto Sans SC', sans-serif;
  text-align: center;
  background: #ffffff;
  color: #333333;
}

.cover-section {
  margin-bottom: 0;
  text-align: center;
  padding: 2rem;
  background: #ffffff;
}

.cover {
  max-width: 400px;
  width: 100%;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.cover:hover {
  transform: scale(1.05);
}

.main-sections {
  margin-top: 0;
  display: flex;
  flex-direction: column;
  gap: 0;
  align-items: center;
}

.main-section {
  background: #ffffff;
  border-radius: 0;
  padding: 2rem;
  width: 100%;
  max-width: 100%;
  border-top: 1px solid rgba(0, 0, 0, 0.05);
}

.main-section.scrollable {
  color: #000000;
  padding: 0;
}

.sub-title {
  font-size: 1.4rem;
  font-weight: 1000;
  line-height: 2rem;
  margin-bottom: 1.5rem;
  text-align: center;
  color: #333333;
}

.main-section.scrollable .sub-title {
  color: #000000;
  padding: 2rem 2rem 0 2rem;
}

.content {
  font-size: 1.1rem;
  font-weight: 400;
  line-height: 1.5;
  text-align: center;
  color: #666666;
}

.story-item {
  margin-bottom: 1.5rem;
  text-align: center;
}

.story-item h3 {
  font-size: 1.2rem;
  margin-bottom: 0.5rem;
  color: #333333;
}

.credits {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  align-items: center;
}

.credit-group {
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  padding-bottom: 1rem;
  width: 100%;
  text-align: center;
}

.credit-group:last-child {
  border-bottom: none;
}

.credit-group h3 {
  font-size: 1.1rem;
  color: #333333;
  margin-bottom: 0.5rem;
}

.credit-list {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
  justify-content: center;
}

.credit-list span {
  font-size: 0.9rem;
  color: #666666;
}

.design-images {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 2rem;
}

.design-image-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.design-image-item img {
  width: 40%;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.design-image-item p {
  font-size: 1rem;
  font-weight: 200;
  line-height: 2rem;
  margin-top: 1rem;
  text-align: center;
  color: #666666;
}

@media (max-width: 992px) {
  .thoughts-view {
    padding: 0;
  }

  .cover-section {
    padding: 1rem;
  }

  .main-section {
    padding: 1.5rem;
  }

  .main-section.scrollable {
    padding: 0;
  }

  .main-section.scrollable .sub-title {
    padding: 1.5rem 1.5rem 0 1.5rem;
  }

  .credit-list {
    gap: 0.5rem;
  }

  .design-image-item img {
    width: 90%;
  }
}
</style> 

<!-- 1. palette ii - VeetaCrush (02:48)
2. Awake - Joulez (03:50)
3. 幽けきルミノールライト - 潮音きつね (05:26)
4. Lucidandelion - 望月真白 (06:36)
5. Titania - Aki Sz (05:16)
6. December - かたぎり (03:27)
7. 6 p.m. - wheatfox (04:27)
8. Voix sacrée - Nirotiy (07:54)
9. 曇天 - 桃罐 (05:00)
10. Epilogue - Rayven (03:23)
 -->