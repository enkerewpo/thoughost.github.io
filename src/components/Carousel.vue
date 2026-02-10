<script lang="ts">
import { rls_banner, rls_info_s } from '../assets/resources';
import { defineComponent } from 'vue';

const TIME_INTERVAL = 5000; // 5s
const TRANSITION_TIME = 1000; // 1s
const PROGRESS_INTERVAL = 100; // 0.1s

export default defineComponent({
  name: "Carousel",
  data() {
    return {
      currentIndex: 0,
      interval: null as any,
      sliding: '',
      progress: 0, //
      in_transition: false,
      in_transition_animation_trigger: false,
      in_jump: false,
      progress_percentage: 0,
      progressInterval: null as any,
    };
  },
  computed: {
    /** Which slide (image index) is currently in the center — progress follows this bar. */
    centerSlideIndex(): number {
      const L = this.images.length;
      return L ? (this.currentIndex + 6) % L : 0;
    },
    /** Progress fill width for the active bar only; frozen at 0 during slide to avoid glitch. */
    activeBarFillWidth(): string {
      const w = 40;
      if (this.in_transition) return '0';
      const p = Math.min(1, Math.max(0, this.progress_percentage));
      return (w * p).toFixed(2) + 'px';
    },
    currentImages(): any[] {
      const i: number = this.currentIndex;
      let arr = [];
      // insert all images in the order of currentIndex, currentIndex + 1, ... currentIndex - 1 as a loop
      let length = this.images.length;
      let offset = 4;
      for (let j = 0; j < length; j++) {
        arr.push((i + j + offset) % length);
      }
      return arr.map(item => this.images[item]);
    },
    images(): any[] {
      let arr: any[] = [];
      rls_info_s.forEach(element => {
        let banner = rls_banner(element.id);
        let url = element.homepage;
        if (banner !== undefined) {
          arr.push({ id: element.id, url: url, banner: banner });
        }
      });
      return arr;
    },
  },
  methods: {
    startSlideshow() {
      if (this.interval) clearInterval(this.interval);
      if (this.progressInterval) clearInterval(this.progressInterval);

      this.progress = 0;
      let count = TIME_INTERVAL / PROGRESS_INTERVAL;
      this.progressInterval = setInterval(() => {
        if (this.in_transition) return;
        this.progress += 1;
        this.progress_percentage = Math.min(1, this.progress / count);
        if (this.progress >= count) {
          this.progress = 0;
          this.progress_percentage = 0;
          this.in_transition = true;
          setTimeout(() => {
            this.in_transition_animation_trigger = true;
          }, TRANSITION_TIME / 2 + 300);
          this.slideToNext();
        }
      }, PROGRESS_INTERVAL);
    },
    slideToNext() {
      this.sliding = 'left';
      this.resetProgress();
      setTimeout(() => {
        this.currentIndex = this.nextNum(this.currentIndex);
        this.sliding = '';
        this.resetProgress();
        this.in_transition = false;
        this.in_transition_animation_trigger = false;
      }, TRANSITION_TIME);
    },
    goToSlide(index: number) {
      this.in_jump = true;
      setTimeout(() => {
        this.in_jump = false;
        clearInterval(this.interval);
        clearInterval(this.progressInterval);
        this.currentIndex = index;
        this.resetProgress();
        this.startSlideshow(); // Restart slideshow after manual navigation
      }, 300);
    },
    clearIntervals() {
      if (this.interval) clearInterval(this.interval);
      if (this.progressInterval) clearInterval(this.progressInterval);
      this.interval = null;
      this.progressInterval = null;
    },
    /** Scroll to the slide at indicator idx by the shortest path (no fade). */
    goToSlideByScroll(idx: number) {
      if (this.in_transition) return;
      const L = this.images.length;
      if (L === 0) return;
      // center slot is at index 2; clicked indicator idx => target currentIndex so that (new+6)%L = (cur+idx+4)%L
      const targetCurrentIndex = (this.currentIndex + idx - 2 + L) % L;
      let steps = (targetCurrentIndex - this.currentIndex + L) % L;
      let direction: 'left' | 'right' = 'left';
      if (steps > L / 2) {
        steps = L - steps;
        direction = 'right';
      }
      if (steps === 0) return;
      this.clearIntervals();
      this.resetProgress();
      const doOneStep = () => {
        if (steps === 0) {
          this.startSlideshow();
          return;
        }
        steps--;
        if (direction === 'left') {
          this.slideToNext();
        } else {
          this.slideToPrev();
        }
        setTimeout(doOneStep, TRANSITION_TIME);
      };
      doOneStep();
    },
    slideToPrev() {
      this.sliding = 'right';
      this.resetProgress();
      setTimeout(() => {
        this.currentIndex = this.prevNum(this.currentIndex);
        this.sliding = '';
        this.resetProgress();
        this.in_transition = false;
        this.in_transition_animation_trigger = false;
      }, TRANSITION_TIME);
    },
    onPrevClick() {
      if (this.in_transition) return;
      this.in_transition = true;
      if (this.progressInterval) clearInterval(this.progressInterval);
      this.slideToPrev();
      setTimeout(() => this.startSlideshow(), TRANSITION_TIME);
    },
    onNextClick() {
      if (this.in_transition) return;
      this.in_transition = true;
      if (this.progressInterval) clearInterval(this.progressInterval);
      this.slideToNext();
      setTimeout(() => this.startSlideshow(), TRANSITION_TIME);
    },
    resetProgress() {
      this.progress = 0;
      this.progress_percentage = 0;
    },
    prevNum(i: number): number {
      return i - 1 < 0 ? this.images.length - 1 : i - 1;
    },
    nextNum(i: number): number {
      return i + 1 >= this.images.length ? 0 : i + 1;
    },
    updateHeight() {
      const el = this.$el?.querySelector?.('.slideshow-container') as HTMLElement;
      if (el) el.style.height = Math.floor(648 * el.offsetWidth / 1400) + 'px';
    },
    getCurrentHeight() {
      return Math.floor(648 * this.$el.offsetWidth / 1400) + 'px';
    },
  },
  mounted() {
    this.startSlideshow();
    this.updateHeight();
    window.addEventListener('resize', this.updateHeight);
  },
  beforeDestroy() {
    clearInterval(this.interval);
    clearInterval(this.progressInterval);
  },
});
</script>

<template>
  <div class="carousel-wrapper">
    <div class="slideshow">
      <button type="button" class="carousel-arrow carousel-arrow-prev" aria-label="Previous" @click="onPrevClick">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M15 18l-6-6 6-6"/></svg>
      </button>
      <button type="button" class="carousel-arrow carousel-arrow-next" aria-label="Next" @click="onNextClick">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 18l6-6-6-6"/></svg>
      </button>
      <div class="container tg-container" :style="{ opacity: in_jump ? 0 : 1 , transition: 'opacity 0.5s ease' }">
        <div class="slideshow-container" :class="{
          'left-sliding': sliding == 'left',
          'right-sliding': sliding == 'right'
        }">
          <a v-for="(img, idx) in currentImages" :key="img.id" :href="`/releases/${img.id}`" target="_top"
            :style="{ backgroundImage: 'url(' + img.banner + ')' }" class="slideshow-item"></a>
        </div>
      </div>
    </div>
    <div class="carousel-flat-indicators-container">
      <div class="carousel-indicators">
        <span
          v-for="(img, idx) in images"
          :key="img.id"
          class="carousel-bar"
          :class="{ 'carousel-bar-active': idx === centerSlideIndex }"
          role="button"
          tabindex="0"
          aria-label="Go to slide"
          @click="goToSlideByScroll(idx)"
          @keydown.enter.prevent="goToSlideByScroll(idx)"
        >
          <span
            class="carousel-bar-fill"
            :style="idx === centerSlideIndex ? { width: activeBarFillWidth } : {}"
          ></span>
        </span>
      </div>
    </div>
  </div>
</template>

<!-- 150 380 -->

<style scoped>
.carousel-wrapper {
  position: relative;
}

.carousel-arrow {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  z-index: 10;
  width: 48px;
  height: 48px;
  border: none;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.45);
  color: rgba(255, 255, 255, 0.9);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background 0.25s ease, box-shadow 0.25s ease, color 0.25s ease;
}

.carousel-arrow:hover {
  background: rgba(0, 0, 0, 0.7);
  color: #fff;
  box-shadow: 0 0 0 2px rgba(255, 255, 255, 0.25);
}

.carousel-arrow:active {
  background: rgba(0, 0, 0, 0.85);
  box-shadow: 0 0 0 2px rgba(255, 255, 255, 0.15);
}

.carousel-arrow svg {
  width: 24px;
  height: 24px;
}

.carousel-arrow-prev {
  left: 16px;
}

.carousel-arrow-next {
  right: 16px;
}

.carousel-flat-indicators-container {
  margin-top: -40px;
  display: flex;
  justify-content: center;
  padding: 16px 0;
}

.carousel-indicators {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  gap: 6px;
  max-width: 100%;
}

.carousel-bar {
  position: relative;
  width: 40px;
  height: 6px;
  border-radius: 3px;
  background-color: rgba(255, 255, 255, 0.35);
  padding: 0;
  overflow: hidden;
  flex-shrink: 0;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.35);
  cursor: pointer;
  transition: background-color 0.25s ease, box-shadow 0.25s ease, opacity 0.25s ease;
}

.carousel-bar:hover {
  background-color: rgba(255, 255, 255, 0.6);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.25);
}

.carousel-bar-active {
  background-color: rgba(255, 255, 255, 0.5);
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.45);
}

.carousel-bar-active:hover {
  background-color: rgba(255, 255, 255, 0.85);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

.carousel-bar-fill {
  display: block;
  position: absolute;
  left: 0;
  top: 0;
  height: 100%;
  min-width: 0;
  border-radius: 3px;
  background-color: #fff;
  box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.15);
  transition: width 0.08s linear;
}

.slideshow {
  overflow-x: clip;
  position: relative;
}

.slideshow-container {
  overflow-x: visible;
  white-space: nowrap;
  transform: translateX(-200%);
  margin-left: -24px;
  width: 100%;
}

.slideshow-container .slideshow-item {
  width: 100%;
  height: 100%;
  display: inline-block;
  background-size: cover;
  background-position: center;
  text-decoration: none;
  cursor: pointer;
  position: relative;
  transition: filter 0.4s ease;
}

.slideshow-container .slideshow-item::after {
  content: '';
  position: absolute;
  inset: 0;
  background: transparent;
  transition: background 0.4s ease;
  pointer-events: none;
}

/* 两侧幻灯片：hover 时亮度柔和提升 */
.slideshow-container .slideshow-item:nth-child(1),
.slideshow-container .slideshow-item:nth-child(2) {
  margin-right: 12px;
  filter: brightness(0.2);
}

.slideshow-container .slideshow-item:nth-child(1):hover,
.slideshow-container .slideshow-item:nth-child(2):hover {
  filter: brightness(0.5);
}

.slideshow-container .slideshow-item:nth-child(1):hover::after,
.slideshow-container .slideshow-item:nth-child(2):hover::after {
  background: rgba(255, 255, 255, 0.06);
}

.slideshow-container .slideshow-item:nth-child(4),
.slideshow-container .slideshow-item:nth-child(5) {
  margin-left: 12px;
  filter: brightness(0.2);
}

.slideshow-container .slideshow-item:nth-child(4):hover,
.slideshow-container .slideshow-item:nth-child(5):hover {
  filter: brightness(0.5);
}

.slideshow-container .slideshow-item:nth-child(4):hover::after,
.slideshow-container .slideshow-item:nth-child(5):hover::after {
  background: rgba(255, 255, 255, 0.06);
}

/* 中间主图：hover 时轻微提亮 + 淡白叠层 */
.slideshow-container .slideshow-item:nth-child(3):hover {
  filter: brightness(1.05);
}

.slideshow-container .slideshow-item:nth-child(3):hover::after {
  background: rgba(255, 255, 255, 0.04);
}


.left-sliding .slideshow-item:nth-child(4) {
  margin-left: 0;
  filter: brightness(100%);
  transition: all 1s ease;
}

.left-sliding .slideshow-item:nth-child(3) {
  margin-right: 12px;
  filter: brightness(20%);
  transition: all 1s ease;
}

.left-sliding {
  transform: translateX(-300%);
  transition: transform 1s ease;
  margin-left: -36px;
}

.right-sliding {
  transform: translateX(-100%);
  transition: transform 1s ease;
  margin-left: -12px;
}

.right-sliding .slideshow-item:nth-child(2) {
  filter: brightness(100%);
  transition: all 1s ease;
}

.right-sliding .slideshow-item:nth-child(3) {
  filter: brightness(20%);
  margin-right: 12px;
  transition: all 1s ease;
}
</style>