<script lang="ts">
import router from '@/router';
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
    currentImages(): any[] {
      const i: number = this.currentIndex;
      let arr = [];
      // insert all images in the order of currentIndex, currentIndex + 1, ... currentIndex - 1 as a loop
      let length = this.images.length;
      let offset = 4;
      for (let j = 0; j < length; j++) {
        arr.push((i + j + offset) % length);
      }
      let ret = arr.map(item => this.images[item]);
      console.log("currentImages:", ret);
      return ret;
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
      console.log("images:", arr);
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
        this.progress += 1;
        this.progress_percentage = this.progress / count;
        // console.log("progress:", this.progress, "percentage:", this.progress_percentage);
        if (this.progress >= count) {
          this.progress = 0;
          this.in_transition = true;
          // the full animation of slide is TRANSITION_TIME, we will trigger a width change in the middle of the animation
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
      const element: any = document.getElementsByClassName("slideshow-container")[0];
      element.style.height = Math.floor(648 * element.offsetWidth / 1400) + 'px';
      console.log("carousel height -> ", element.style.height);
    },
    getCurrentHeight() {
      return Math.floor(648 * this.$el.offsetWidth / 1400) + 'px';
    },
    itemClickHandler(idx: number) {
      console.log('click', idx, "url:", this.currentImages[idx].url);
      router.push({ path: this.currentImages[idx].url });
    },
    getOpacity(idx: number, currentIndex: number) {
      if (idx === currentIndex) return 1;
      // if (idx === this.prevNum(currentIndex) || idx === this.nextNum(currentIndex)) return 0.5;
      return 0;
    },
    getWidth(idx: number, currentIndex: number) {
      if (this.in_transition) {
        if (this.in_transition_animation_trigger) {
          return '0%';
        } else {
          return '100%';
        }
      }
      if (idx === currentIndex) return 31 * this.progress_percentage + 'px';
      return '100%';
    },
    getMarginLeft(idx: number, currentIndex: number) {
      if (this.in_transition) {
        if (this.in_transition_animation_trigger) {
          return '31px';
        } else {
          return '5px';
        }
      }
      if (idx === currentIndex) return '5px';
      return '5px';
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
  <div class="slideshow">
    <div class="container tg-container" :style="{ opacity: in_jump ? 0 : 1 , transition: 'opacity 0.5s ease' }">
      <div class="slideshow-container" :class="{
        'left-sliding': sliding == 'left',
        'right-sliding': sliding == 'right'
      }">
        <div v-for="(img, idx) in currentImages" :key="img.id" :style="{ backgroundImage: 'url(' + img.banner + ')' }"
          class="slideshow-item" @click="itemClickHandler(idx)"></div>
      </div>
    </div>
  </div>
  <div class="carousel-flat-indicators-container">
    <div class="carousel-indicators">
      <span v-for="(img, idx) in currentImages" :key="idx" class="carousel-indicators" @click="goToSlide(idx)">
        <!-- each indicator also has another overlay to enhance transition feel :) - wheatfox -->
        <span class="overlay"
          :style="{ opacity: getOpacity(idx, currentIndex), width: getWidth(idx, currentIndex), marginLeft: getMarginLeft(idx, currentIndex) }"></span>
        <!-- <span v-if="idx === currentIndex" class="active" :style="{ width: 31 * progress_percentage + 'px' }"
          v-show="in_transition"></span> -->
      </span>
    </div>
  </div>
</template>

<!-- 150 380 -->

<style scoped>
.carousel-flat-indicators-container {
  margin-top: -40px;
  /* margin-left calculation: let x = screen width / 2; let n = 5, then the total width of the indicators is (31 + 5) * n = 36 * 5 = 180px */
  margin-left: calc(50% - 90px - 5px);
}

/* Carousel Indicators */
.carousel-indicators {
  position: relative;
  margin-top: 12px;
  margin-left: 5px !important;
  margin-right: 0% !important;
  justify-content: initial !important;
}

.carousel-indicators span {
  width: 31px;
  height: 6px;
  background-color: #ddddddce;
  border-radius: 4px;
  margin: 0 5px;
  cursor: pointer;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.35);
}

.carousel-indicators span:hover {
  transform: scale(1.15);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.35);
}

.carousel-indicators .overlay {
  position: absolute;
  top: 0;
  left: -5px;
  width: 31px;
  height: 6px;
  background-color: #ffffff;
  border-radius: 4px;
  cursor: pointer;
  opacity: 0;
  transition: width 0.2s ease, margin-left 0.2s ease;
}

.slideshow {
  overflow-x: clip;
}

.slideshow-container {
  overflow-x: visible;
  white-space: nowrap;
  transform: translateX(-200%);
  margin-left: -24px;
  width: 100%;
}

.slideshow-container div {
  width: 100%;
  height: 100%;
  display: inline-block;
  background-size: cover;
  background-position: center;
}

.slideshow-container div:nth-child(1),
.slideshow-container div:nth-child(2) {
  margin-right: 12px;
  filter: brightness(20%);
}

.slideshow-container div:nth-child(4),
.slideshow-container div:nth-child(5) {
  margin-left: 12px;
  filter: brightness(20%);
}

.slideshow-item {
  cursor: pointer;
}

.left-sliding div:nth-child(4) {
  margin-left: 0;
  filter: brightness(100%);
  transition: all 1s ease;
}

.left-sliding div:nth-child(3) {
  margin-right: 12px;
  filter: brightness(20%);
  transition: all 1s ease;
}

.left-sliding {
  transform: translateX(-300%);
  transition: transform 1s ease;
  margin-left: -36px;
}
</style>