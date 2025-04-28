<template>
    <div class="simple-carousel" @mouseenter="pauseAutoRotate" @mouseleave="startAutoRotate">
        <button class="arrow left" @click="prev" :disabled="currentIndex === 0">&#8592;</button>
        <div class="card">
            <div class="progress-bar" :style="{ width: `${progress}%` }"></div>
            <transition :name="transitionName">
                <div :key="currentIndex" class="card-content">
                    <slot :item="items[currentIndex]">
                        <h3>{{ items[currentIndex].title }}</h3>
                        <p v-if="items[currentIndex].subtitle" class="subtitle">{{ items[currentIndex].subtitle }}</p>
                        <p>{{ items[currentIndex].content }}</p>
                    </slot>
                </div>
            </transition>
            <div class="indicators">
                <button v-for="(_, index) in items" :key="index" class="indicator-dot"
                    :class="{ active: currentIndex === index }" @click="goToSlide(index)"></button>
            </div>
        </div>
        <button class="arrow right" @click="next" :disabled="currentIndex === items.length - 1">&#8594;</button>
    </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted, onUnmounted } from 'vue';
export default defineComponent({
    name: 'SimpleCarousel',
    props: {
        items: {
            type: Array,
            required: true
        },
        autoRotateInterval: {
            type: Number,
            default: 5000
        }
    },
    setup(props) {
        const currentIndex = ref(0);
        const transitionName = ref('slide-left');
        const items = props.items as any[];
        let autoRotateTimer: number | null = null;
        const progress = ref(100);
        let progressTimer: number | null = null;

        const updateProgress = () => {
            const startTime = Date.now();
            const duration = props.autoRotateInterval;
            
            const update = () => {
                const elapsed = Date.now() - startTime;
                progress.value = 100 - (elapsed / duration) * 100;
                
                if (progress.value > 0) {
                    progressTimer = requestAnimationFrame(update);
                }
            };
            
            progressTimer = requestAnimationFrame(update);
        };

        const prev = () => {
            if (currentIndex.value > 0) {
                transitionName.value = 'slide-right';
                currentIndex.value--;
                progress.value = 100;
                if (progressTimer) {
                    cancelAnimationFrame(progressTimer);
                }
                updateProgress();
            }
        };

        const next = () => {
            if (currentIndex.value < items.length - 1) {
                transitionName.value = 'slide-left';
                currentIndex.value++;
            } else {
                transitionName.value = 'slide-left';
                currentIndex.value = 0;
            }
            progress.value = 100;
            if (progressTimer) {
                cancelAnimationFrame(progressTimer);
            }
            updateProgress();
        };

        const goToSlide = (index: number) => {
            transitionName.value = index > currentIndex.value ? 'slide-left' : 'slide-right';
            currentIndex.value = index;
            progress.value = 100;
            if (progressTimer) {
                cancelAnimationFrame(progressTimer);
            }
            updateProgress();
        };

        const startAutoRotate = () => {
            if (autoRotateTimer === null) {
                autoRotateTimer = window.setInterval(() => {
                    next();
                }, props.autoRotateInterval);
                updateProgress();
            }
        };

        const pauseAutoRotate = () => {
            if (autoRotateTimer !== null) {
                clearInterval(autoRotateTimer);
                autoRotateTimer = null;
            }
            if (progressTimer) {
                cancelAnimationFrame(progressTimer);
                progressTimer = null;
            }
        };

        onMounted(() => {
            startAutoRotate();
        });

        onUnmounted(() => {
            pauseAutoRotate();
        });

        return {
            currentIndex,
            prev,
            next,
            items,
            transitionName,
            goToSlide,
            startAutoRotate,
            pauseAutoRotate,
            progress
        };
    }
});
</script>

<style scoped>
.simple-carousel {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 1.5rem;
    width: 100%;
    margin: 2rem 0;
}

.card {
    background: #ffffff;
    color: #181818;
    border-radius: 16px;
    box-shadow: 0 4px 24px rgba(0, 0, 0, 0.18);
    padding: 2.5rem 2.5rem 2rem 2.5rem;
    width: 800px;
    height: 400px;
    min-width: 800px;
    max-width: 800px;
    min-height: 400px;
    max-height: 400px;
    text-align: center;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    transition: box-shadow 0.2s;
    position: relative;
    overflow: hidden;
}

.card h3 {
    font-size: 2.1rem;
    font-weight: 700;
    margin-bottom: 0.7rem;
}

.card p {
    font-size: 1rem;
    margin: 0.2rem 0;
}

.card p.subtitle {
    color: #909090;
    font-weight: 400;
    font-style: italic;
    margin-bottom: 1rem;
}

.card p:last-child {
    font-size: 0.95rem;
    color: #000000;
}

.arrow {
    background: rgba(106, 106, 106, 0.7);
    border: none;
    color: #fff;
    font-size: 1.5rem;
    border-radius: 50%;
    width: 50px;
    height: 32px;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    backdrop-filter: blur(4px);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

.arrow:hover {
    background: rgba(24, 24, 28, 0.9);
    transform: scale(1.1);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
}

.arrow:disabled {
    opacity: 0.3;
    cursor: not-allowed;
    transform: none;
    box-shadow: none;
}

@media (max-width: 900px) {
    .card {
        padding: 1rem;
        width: 98vw;
        min-width: 0;
        max-width: 98vw;
        height: 220px;
        min-height: 160px;
        max-height: 220px;
    }

    .card h3 {
        font-size: 1.3rem;
    }

    .arrow {
        font-size: 1.2rem;
        width: 32px;
        height: 32px;
    }
}

.card-content {
    position: absolute;
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    will-change: transform, opacity;
    backface-visibility: hidden;
    -webkit-backface-visibility: hidden;
}

.slide-left-enter-active,
.slide-left-leave-active,
.slide-right-enter-active,
.slide-right-leave-active {
    transition: all 0.6s cubic-bezier(0.33, 1, 0.68, 1);
    position: absolute;
    width: 100%;
    height: 100%;
}

.slide-left-enter-from {
    transform: translateX(50%);
    opacity: 0;
}

.slide-left-leave-to {
    transform: translateX(-50%);
    opacity: 0;
}

.slide-right-enter-from {
    transform: translateX(-50%);
    opacity: 0;
}

.slide-right-leave-to {
    transform: translateX(50%);
    opacity: 0;
}

.indicators {
    position: absolute;
    bottom: 1rem;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 0.5rem;
    z-index: 10;
    background: rgba(255, 255, 255, 0.8);
    padding: 0.5rem;
    border-radius: 20px;
    /* backdrop-filter: blur(4px); */
}

.indicator-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: rgba(103, 103, 103, 0.2);
    border: 2px solid rgba(199, 199, 199, 0.1);
    cursor: pointer;
    transition: all 0.3s ease;
    padding: 0;
}

.indicator-dot:hover {
    background: rgba(0, 0, 0, 0.4);
    transform: scale(1.2);
}

.indicator-dot.active {
    background: #000;
    border-color: #000;
    transform: scale(1.2);
}

@media (max-width: 900px) {
    .indicators {
        bottom: 0.5rem;
        padding: 0.3rem;
    }

    .indicator-dot {
        width: 6px;
        height: 6px;
    }
}

.progress-bar {
    position: absolute;
    top: 0;
    left: 0;
    height: 4px;
    background: rgba(0, 0, 0, 0.05);
    transition: width 0.1s linear;
    z-index: 10;
}

.progress-bar::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    height: 100%;
    width: 100%;
    background: rgba(0, 0, 0, 0.1);
    transform-origin: left;
    transform: scaleX(var(--progress, 1));
    transition: transform 0.1s linear;
}
</style>