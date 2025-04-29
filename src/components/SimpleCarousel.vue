<template>
    <div class="simple-carousel" @mouseenter="pauseAutoRotate" @mouseleave="startAutoRotate">
        <button class="arrow left" @click="prev" :disabled="currentIndex === 0">&lt;</button>
        <div class="card">
            <div class="progress-bar" :style="{ width: `${progress}%` }"></div>
            <transition :name="transitionName">
                <div :key="currentIndex" class="card-content">
                    <div class="content-wrapper">
                        <div class="left-section">
                            <slot name="title" :item="items[currentIndex]">
                                <h3>{{ items[currentIndex].title }}</h3>
                                <p v-if="items[currentIndex].subtitle" class="subtitle">{{ items[currentIndex].subtitle }}</p>
                            </slot>
                        </div>
                        <div class="right-section">
                            <slot name="content" :item="items[currentIndex]">
                                <p>{{ items[currentIndex].content }}</p>
                            </slot>
                        </div>
                    </div>
                </div>
            </transition>
            <div class="indicators">
                <div v-for="(item, index) in items" :key="index" class="indicator-item">
                    <transition name="fade">
                        <div v-if="hoverIndex === index || currentIndex === index" 
                            :class="['hover-title', { 'current-title': currentIndex === index }]">{{ item.title }}</div>
                    </transition>
                    <button class="indicator-dot"
                        :class="{ active: currentIndex === index }" 
                        @click="goToSlide(index)"
                        @mouseenter="hoverIndex = index"
                        @mouseleave="hoverIndex = -1"></button>
                </div>
            </div>
        </div>
        <button class="arrow right" @click="next" :disabled="currentIndex === items.length - 1">&gt;</button>
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
        const hoverIndex = ref(-1);

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

        const resetAllStates = () => {
            if (autoRotateTimer !== null) {
                clearInterval(autoRotateTimer);
                autoRotateTimer = null;
            }
            if (progressTimer) {
                cancelAnimationFrame(progressTimer);
                progressTimer = null;
            }
            progress.value = 100;
            startAutoRotate();
        };

        const prev = () => {
            if (currentIndex.value > 0) {
                transitionName.value = 'slide-right';
                currentIndex.value--;
                resetAllStates();
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
            resetAllStates();
        };

        const goToSlide = (index: number) => {
            transitionName.value = index > currentIndex.value ? 'slide-left' : 'slide-right';
            currentIndex.value = index;
            resetAllStates();
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
            progress.value = progress.value;
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
            progress,
            hoverIndex
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
    width: 100vw;
    margin: 0;
    background: #ffffff;
    min-height: 40vh;
    padding: 2rem 0;
    position: relative;
}

.card {
    background: #000000;
    color: #ffffff;
    border-radius: 0;
    box-shadow: none;
    padding: 2.5rem 2.5rem 2rem 2.5rem;
    width: 100%;
    height: 400px;
    min-width: 100%;
    max-width: 100%;
    min-height: 400px;
    max-height: 400px;
    text-align: center;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    overflow: hidden;
    border: none;
}

.card:hover {
    box-shadow: none;
    transform: none;
    border: none;
}

.card h3 {
    font-size: 2.1rem;
    font-weight: 700;
    margin-bottom: 0.7rem;
    color: #ffffff;
}

.card p {
    font-size: 1rem;
    margin: 0.2rem 0;
    color: #d0d0d0;
}

.card p.subtitle {
    color: #909090;
    font-weight: 400;
    font-style: italic;
    margin-bottom: 1rem;
}

.card p:last-child {
    font-size: 0.95rem;
    color: #e0e0e0;
}

.arrow {
    background: none;
    border: none;
    color: #ffffff;
    font-size: 2rem;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    position: absolute;
    z-index: 2;
    padding: 0;
    width: auto;
    height: auto;
}

.arrow.left {
    left: 1rem;
}

.arrow.right {
    right: 1rem;
}

.arrow:hover {
    color: #ffffff;
    transform: scale(1.1);
    background: none;
    box-shadow: none;
}

.arrow:disabled {
    opacity: 0.2;
    cursor: not-allowed;
    transform: none;
}

@media (max-width: 900px) {
    .card {
        padding: 1rem;
        width: 100%;
        min-width: 100%;
        max-width: 100%;
        height: 220px;
        min-height: 160px;
        max-height: 220px;
    }

    .card h3 {
        font-size: 1.3rem;
    }

    .arrow {
        font-size: 1.5rem;
    }
}

.content-wrapper {
    width: 90%;
    max-width: 1400px;
    display: flex;
    justify-content: flex-start;
    align-items: flex-start;
    gap: 4rem;
    margin: 0 auto;
    padding-left: 5%;
}

.left-section {
    flex: 0 0 40%;
    text-align: right;
    padding-right: 2rem;
    border-right: 1px solid rgba(255, 255, 255, 0.1);
}

.right-section {
    flex: 0 0 45%;
    text-align: left;
    padding-left: 2rem;
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
    bottom: 1.2rem;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 0.8rem;
    z-index: 10;
    background: rgba(26, 26, 26, 0.9);
    padding: 0.8rem 1.5rem;
    border-radius: 30px;
    backdrop-filter: blur(8px);
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
}

.indicator-item {
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.hover-title {
    position: absolute;
    bottom: 100%;
    left: 50%;
    transform: translateX(-50%);
    background: rgba(0, 0, 0, 0.8);
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    font-size: 0.9rem;
    white-space: nowrap;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
    margin-bottom: 0.5rem;
}

.current-title {
    background: rgba(0, 0, 0, 0.5);
    color: rgba(255, 255, 255, 0.8);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.current-title::after {
    border-color: rgba(0, 0, 0, 0.5) transparent transparent transparent;
}

.fade-enter-active,
.fade-leave-active {
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.fade-enter-from,
.fade-leave-to {
    opacity: 0;
    transform: translate(-50%, 10px);
}

.fade-enter-to,
.fade-leave-from {
    opacity: 1;
    transform: translate(-50%, 0);
}

.hover-title::after {
    content: '';
    position: absolute;
    top: 100%;
    left: 50%;
    transform: translateX(-50%);
    border-width: 5px;
    border-style: solid;
    border-color: rgba(0, 0, 0, 0.8) transparent transparent transparent;
}

.indicator-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.15);
    border: none;
    cursor: pointer;
    transition: all 0.3s ease;
    padding: 0;
    position: relative;
}

.indicator-dot::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 20px;
    height: 20px;
    border-radius: 50%;
    background: transparent;
}

.indicator-dot:hover {
    background: rgba(255, 255, 255, 0.4);
    transform: scale(1.2);
}

.indicator-dot.active {
    background: #ffffff;
    transform: scale(1.2);
    box-shadow: 0 0 8px rgba(255, 255, 255, 0.4);
}

@media (max-width: 900px) {
    .indicators {
        padding: 0.6rem 1.2rem;
        gap: 0.6rem;
    }

    .indicator-dot {
        width: 7px;
        height: 7px;
    }

    .indicator-dot::before {
        width: 16px;
        height: 16px;
    }

    .content-wrapper {
        width: 90%;
        flex-direction: column;
        gap: 2rem;
        padding-left: 0;
    }

    .left-section,
    .right-section {
        flex: 0 0 100%;
        padding: 0;
        border-right: none;
    }

    .card h3 {
        font-size: 1.3rem;
    }
}

.progress-bar {
    position: absolute;
    bottom: 0;
    left: 0;
    height: 3px;
    background: linear-gradient(90deg, #ffffff 0%, #e0e0e0 50%, #ffffff 100%);
    transition: width 0.1s linear;
    z-index: 10;
    opacity: 0.6;
}

.progress-bar::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    height: 100%;
    width: 100%;
    background: linear-gradient(90deg, #ffffff 0%, #e0e0e0 50%, #ffffff 100%);
    transform-origin: left;
    transform: scaleX(var(--progress, 1));
    transition: transform 0.1s linear;
    filter: blur(1px);
}
</style>