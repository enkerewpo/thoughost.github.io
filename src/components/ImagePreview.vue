<template>
  <div v-if="isOpen" class="image-preview-overlay" :class="{ exit: isClosing }">
    <div class="image-preview-content" :class="{ exit: isClosing }">
      <img :src="imageSrc" :alt="alt" @load="onImageLoad" />
      <button class="close-button" @click="close">
        <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none">
          <line x1="18" y1="6" x2="6" y2="18"></line>
          <line x1="6" y1="6" x2="18" y2="18"></line>
        </svg>
      </button>
      <div v-if="loading" class="loading">Loading...</div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, watch } from 'vue';

export default defineComponent({
  name: 'ImagePreview',
  props: {
    isOpen: {
      type: Boolean,
      required: true
    },
    imageSrc: {
      type: String,
      required: true
    },
    alt: {
      type: String,
      default: ''
    }
  },
  emits: ['close'],
  setup(props, { emit }) {
    const loading = ref(true);
    const isClosing = ref(false);

    const close = () => {
      isClosing.value = true;
      setTimeout(() => {
        emit('close');
        isClosing.value = false;
      }, 300); // Match the animation duration
    };

    const onImageLoad = () => {
      loading.value = false;
    };

    watch(() => props.isOpen, (newVal) => {
      if (newVal) {
        loading.value = true;
        isClosing.value = false;
      }
    });

    return {
      loading,
      close,
      onImageLoad,
      isClosing
    };
  }
});
</script>

<style scoped>
.image-preview-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.9);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
  /* cursor: pointer; */
  opacity: 0;
  animation: fadeIn 0.3s ease forwards;
}

.image-preview-content {
  position: relative;
  max-width: 90vw;
  max-height: 90vh;
  cursor: default;
  transform: scale(0.9);
  opacity: 0;
  animation: zoomIn 0.3s ease 0.1s forwards;
}

.image-preview-content img {
  max-width: 100%;
  max-height: 90vh;
  object-fit: contain;
  box-shadow: none;
}

.loading {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: white;
  font-size: 1.2rem;
  opacity: 0;
  animation: fadeIn 0.3s ease forwards;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes zoomIn {
  from {
    transform: scale(0.9);
    opacity: 0;
  }
  to {
    transform: scale(1);
    opacity: 1;
  }
}

/* Add exit animations */
.image-preview-overlay.exit {
  animation: fadeOut 0.3s ease forwards;
}

.image-preview-content.exit {
  animation: zoomOut 0.3s ease forwards;
}

@keyframes fadeOut {
  from {
    opacity: 1;
  }
  to {
    opacity: 0;
  }
}

@keyframes zoomOut {
  from {
    transform: scale(1);
    opacity: 1;
  }
  to {
    transform: scale(0.9);
    opacity: 0;
  }
}

.close-button {
  position: absolute;
  top: 16px;
  right: 16px;
  background: rgba(0, 0, 0, 0.3);
  color: white;
  cursor: pointer;
  padding: 8px;
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s ease;
  z-index: 1001;
  border: none;
  outline: none;
  backdrop-filter: blur(2px);
}

.close-button:hover {
  background-color: rgba(0, 0, 0, 0.5);
}

.close-button:active {
  transform: scale(0.95);
}

.close-button svg {
  width: 20px;
  height: 20px;
  stroke: white;
  stroke-width: 2.5;
}
</style> 