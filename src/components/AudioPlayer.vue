<template>
  <div v-if="info" class="audio-info">
    <h6 class="audio-title">{{ song_title }}</h6>
    <p class="audio-artist">{{ song_artist }}</p>
    <div class="controls">
      <button @click="toggle">
        <i :class="play_back_icon"></i>
      </button>
      <p class="time-info">{{ convert_seconds_to_time(song_current_time) }} / {{ convert_seconds_to_time(song_total_time) }}
      </p>
    </div>
    <div class="progress-bar">
      <div class="progress-played" :style="{ width: progress_played_width }"></div>
      <input type="range" class="time-slider" :value="song_current_time" :max="song_total_time" @input="seek_to_time">
    </div>
  </div>
</template>

<script lang="ts">
import { rls_info_l, crossfade_audios } from '@/assets/resources';
import { defineComponent } from 'vue';

export default defineComponent({
  name: 'AudioPlayer',
  data() {
    return {
      song_title: 'LOADING...',
      song_artist: 'LOADING...',
      song_total_time: 0, // seconds
      song_current_time: 0, // seconds
      audio_element: null as any,
      is_playing: false as boolean
    };
  },
  computed: {
    info(): Record<string, any> | undefined {
      const id = (this as any).$route?.params?.id as string;
      return id ? (rls_info_l as Record<string, any>)[id] : undefined;
    },
    get_audio(): string {
      const id = (this as any).$route?.params?.id as string;
      return id ? crossfade_audios(id) : '';
    },
    play_back_icon(): string {
      return this.is_playing ? 'fas fa-pause' : 'fas fa-play';
    },
    progress_played_width(): string {
      if (this.song_total_time === 0) return '0';
      const progress = (this.song_current_time / this.song_total_time) * 100;
      return `${progress}%`;
    }
  },
  mounted() {
    this.load_audio();
  },
  methods: {
    async load_audio() {
      if (!this.info?.audio) return;
      this.song_title = this.info.audio.title;
      this.song_artist = this.info.audio.artist;

      const audio_path = await this.get_audio;
      this.audio_element = new Audio(audio_path);
      this.audio_element.addEventListener('loadedmetadata', () => {
        this.song_total_time = Math.floor(this.audio_element.duration);
      });
      this.audio_element.addEventListener('timeupdate', this.update_current_time);
    },
    convert_seconds_to_time(seconds: number) {
      const min = Math.floor(seconds / 60);
      const sec = Math.floor(seconds % 60);
      return `${min}:${sec < 10 ? '0' + sec : sec}`;
    },
    update_current_time() {
      this.song_current_time = Math.floor(this.audio_element.currentTime);
    },
    toggle() {
      if (this.is_playing) {
        this.pause();
      } else {
        this.play();
      }
    },
    play() {
      if (this.audio_element) {
        this.audio_element.play();
        this.is_playing = true;
      }
    },
    pause() {
      if (this.audio_element) {
        this.audio_element.pause();
        this.is_playing = false;
      }
    },
    seek_to_time(event: Event) {
      const target = event.target as HTMLInputElement;
      const time = parseFloat(target.value);
      if (this.audio_element) {
        this.audio_element.currentTime = time;
        this.song_current_time = time;
      }
    }
  }
});
</script>

<style scoped>
.audio-info {
  padding: 24px 0;
  max-width: 360px;
}

.audio-title {
  font-size: 1.1rem;
  font-weight: 600;
  margin: 0 0 6px 0;
}

.audio-artist {
  font-size: 0.9rem;
  font-style: italic;
  margin: 0 0 20px 0;
  color: #333;
}

.controls {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 16px;
}

.controls button {
  width: 44px;
  height: 44px;
  padding: 0;
  border: 2px solid #101010;
  background: #fff;
  color: #101010;
  cursor: pointer;
  outline: none;
  border-radius: 0;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  transition: background 0.2s ease, color 0.2s ease;
  flex-shrink: 0;
}

.controls button:hover {
  background: #101010;
  color: #fff;
}

.controls button i {
  font-size: 16px;
}

.time-info {
  font-size: 0.9rem;
  margin: 0;
}

.progress-bar {
  width: 100%;
  height: 10px;
  background-color: #e0e0e0;
  border-radius: 0;
  position: relative;
  overflow: hidden;
  box-sizing: border-box;
}

/* 已播放：绝对定位铺满整条高度，避免只显示一半 */
.progress-played {
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  height: 100%;
  background-color: #b0b0b0;
  border-radius: 0;
  transition: width 0.1s linear;
  pointer-events: none;
}

.time-slider {
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  margin: 0;
  background: transparent;
  border: none;
  outline: none;
  -webkit-appearance: none;
}

.time-slider::-webkit-slider-runnable-track {
  background: transparent;
  height: 10px;
}

.time-slider::-moz-range-track {
  background: transparent;
  height: 10px;
}

.time-slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  width: 14px;
  height: 14px;
  background-color: #101010;
  border-radius: 0;
  cursor: pointer;
  position: relative;
  z-index: 2;
}

.time-slider::-webkit-slider-thumb:hover {
  background-color: #555;
}

.time-slider::-moz-range-thumb {
  width: 14px;
  height: 14px;
  background-color: #101010;
  border-radius: 0;
  cursor: pointer;
  position: relative;
  z-index: 2;
}

.time-slider::-moz-range-thumb:hover {
  background-color: #555;
}
</style>
