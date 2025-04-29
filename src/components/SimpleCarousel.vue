<template>
    <div class="simple-carousel" @mouseenter="pauseAutoRotate" @mouseleave="startAutoRotate">
        <div class="page-list">
            <div v-for="(item, index) in items" 
                 :key="index" 
                 :class="['page-item', { active: currentIndex === index }]"
                 @click="goToSlide(index)">
                {{ item.title }}
            </div>
        </div>
        <button class="arrow left" @click="prev" :disabled="currentIndex === 0">&lt;</button>
        <div class="card">
            <div class="quote-start"></div>
            <div class="progress-bar" :style="{ width: `${progress}%` }"></div>
            <div class="carousel-container">
                <div class="left-section">
                    <div class="title-content">
                        <transition-group name="fade-title">
                            <div :key="currentIndex" class="title-wrapper">
                                <slot name="title" :item="items[currentIndex]">
                                    <h3>{{ items[currentIndex].title }}</h3>
                                    <p v-if="items[currentIndex].subtitle" class="subtitle">{{ items[currentIndex].subtitle }}</p>
                                </slot>
                            </div>
                        </transition-group>
                    </div>
                </div>
                
                <div class="right-section">
                    <transition name="fade" mode="out-in" @before-leave="onBeforeContentLeave" @after-enter="onAfterContentEnter">
                        <div :key="currentIndex" class="content-wrapper">
                            <slot name="content" :item="items[currentIndex]">
                                <p v-for="(line, index) in items[currentIndex].content" :key="index" :class="{ 'vspace': line === '' }">{{ line }}</p>
                            </slot>
                        </div>
                    </transition>
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
        const isTransitioning = ref(false);
        const forceHideContent = ref(false);

        const onBeforeContentLeave = () => {
            forceHideContent.value = true;
        };

        const onAfterContentEnter = () => {
            forceHideContent.value = false;
        };

        const pauseContentAnimation = () => {
            isTransitioning.value = true;
            forceHideContent.value = true;
        };

        const resumeContentAnimation = () => {
            isTransitioning.value = false;
            setTimeout(() => {
                forceHideContent.value = false;
            }, 400);
        };

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
            isTransitioning,
            forceHideContent,
            pauseContentAnimation,
            resumeContentAnimation,
            onBeforeContentLeave,
            onAfterContentEnter
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
    height: 600px;
    min-width: 100%;
    max-width: 100%;
    min-height: 600px;
    max-height: 600px;
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

.card::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: 
        linear-gradient(90deg, 
            rgba(255, 255, 255, 0.08) 1px, 
            transparent 1px) 0 0 / 100px 100px,
        linear-gradient(0deg, 
            rgba(255, 255, 255, 0.08) 1px, 
            transparent 1px) 0 0 / 100px 100px,
        linear-gradient(45deg, 
            rgba(255, 255, 255, 0.05) 25%, 
            transparent 25%, 
            transparent 50%, 
            rgba(255, 255, 255, 0.05) 50%, 
            rgba(255, 255, 255, 0.05) 75%, 
            transparent 75%, 
            transparent) 0 0 / 400px 400px;
    animation: moveBackground 30s linear infinite;
    z-index: 1;
}

@keyframes moveBackground {
    0% {
        background-position: 0 0, 0 0, 0 0;
    }
    100% {
        background-position: 100px 0, 0 100px, 400px 0;
    }
}

.card::after {
    content: "」";
    position: absolute;
    font-size: 8rem;
    font-family: serif;
    color: rgba(255, 255, 255, 0.3);
    line-height: 1;
    z-index: 2;
    bottom: 2rem;
    right: 1rem;
}

.card .quote-start::before {
    content: "「";
    position: absolute;
    font-size: 8rem;
    font-family: serif;
    color: rgba(255, 255, 255, 0.3);
    line-height: 1;
    z-index: 2;
    top: 1rem;
    left: 1rem;
}

.card .quote-start {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    z-index: 2;
}

.carousel-container {
    display: flex;
    left: 1em;
    width: 90%;
    max-width: 1600px;
    margin: 0 auto;
    gap: 4rem;
    position: relative;
    z-index: 3;
}

.left-section {
    flex: 0 0 30%;
    position: relative;
    /* border-right: 1px solid rgba(255, 255, 255, 0.1); */
}

.title-content {
    position: absolute;
    top: 50%;
    left: 0;
    right: 0;
    transform: translateY(-50%);
    text-align: right;
    padding-right: 2rem;
    height: 100px;
    overflow: hidden;
}

.title-wrapper {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
}

.title-content h3 {
    transition: opacity 0.6s ease;
    margin: 0;
    line-height: 1.4;
}

.title-content .subtitle {
    transition: opacity 0.6s ease;
    transition-delay: 0.2s;
    margin: 0.7rem 0 0 0;
    line-height: 1.4;
}

.right-section {
    flex: 0 0 50%;
    text-align: left;
    padding-left: 2rem;
    min-height: 200px;
    position: relative;
    height: 500px;
    display: flex;
    align-items: center;
    padding-right: 2rem;
}

.content-wrapper {
    position: absolute;
    width: 100%;
    box-sizing: border-box;
    padding: 2rem 2rem;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    transition: all 0.8s ease;
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
    font-family: 'Poppins', 'Noto Sans SC', sans-serif;
    letter-spacing: 0.02em;
}

.card h3 span {
    display: inline-block;
}

.card h3 span:not(:last-child) {
    margin-right: 0.3em;
}

.card p {
    font-size: 1rem;
    margin: 0.2rem 0;
    color: #d0d0d0;
    font-family: 'Noto Sans SC', sans-serif;
    letter-spacing: 0.02em;
    word-spacing: 0.1em;
    line-height: 1.6;
}

.card p span {
    display: inline-block;
}

.card p span:not(:last-child) {
    margin-right: 0.3em;
}

.card p.subtitle {
    color: #909090;
    font-weight: 400;
    font-style: italic;
    margin-bottom: 1rem;
    font-family: 'Noto Sans SC', sans-serif;
    line-height: 1.6;
}

.card p:last-child {
    font-size: 0.95rem;
    color: #e0e0e0;
    font-family: 'Noto Sans SC', sans-serif;
    line-height: 1.6;
}

.arrow {
    background: none;
    border: none;
    color: rgba(255, 255, 255, 0.7);
    font-size: 3rem;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    position: absolute;
    z-index: 20;
    padding: 1rem;
    width: auto;
    height: auto;
    pointer-events: auto;
}

.arrow.left {
    left: 240px;
    top: 50%;
    transform: translateY(-50%);
}

.arrow.right {
    right: 240px;
    top: 50%;
    transform: translateY(-50%);
}

.arrow:hover {
    color: rgba(255, 255, 255, 0.9);
    transform: translateY(-50%) scale(1.05);
    background: none;
    box-shadow: none;
}

.arrow:disabled {
    opacity: 0.2;
    cursor: not-allowed;
    transform: translateY(-50%);
}

@media (max-width: 900px) {
    .card {
        padding: 1.5rem;
        height: auto;
        min-height: 500px;
        max-height: none;
    }

    .card h3 {
        font-size: 1.5rem;
        margin-bottom: 0.5rem;
    }

    .card p {
        font-size: 0.9rem;
    }

    .card p.subtitle {
        font-size: 0.85rem;
        margin-bottom: 0.8rem;
    }

    .content-wrapper {
        width: 100%;
        flex-direction: column;
        gap: 1.5rem;
        padding: 0;
    }

    .left-section,
    .right-section {
        flex: 0 0 100%;
        padding: 0;
        border-right: none;
        text-align: center;
    }
}

.indicators,
.indicator-item,
.hover-title,
.current-title,
.indicator-dot {
    display: none;
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

.vspace {
    height: 1.5rem;
    margin: 0;
}

.slide-left-enter-active,
.slide-left-leave-active,
.slide-right-enter-active,
.slide-right-leave-active {
    display: none;
}

.slide-left-enter-from,
.slide-left-leave-to,
.slide-right-enter-from,
.slide-right-leave-to,
.slide-left-enter-to,
.slide-right-enter-to,
.slide-left-leave-from,
.slide-right-leave-from {
    display: none;
}

.content-wrapper > p {
    margin: 0.2rem 0;
    text-align: left;
    font-family: 'Noto Sans SC', sans-serif;
    font-size: 1rem;
    line-height: 1.6;
    color: #e0e0e0;
    letter-spacing: 0.02em;
    word-spacing: 0.1em;
    transition: all 0.8s ease;
}

.slide-left-enter-active > p,
.slide-left-leave-active > p,
.slide-right-enter-active > p,
.slide-right-leave-active > p {
    margin: 0.2rem 0;
    text-align: left;
}

.fade-content-enter-active {
    transition: all 0.8s ease;
    transition-delay: 0.6s;
}

.fade-content-enter-from {
    opacity: 0;
}

.fade-content-leave-active {
    transition: all 0.4s ease;
}

.fade-content-leave-to {
    opacity: 0;
}

.content-wrapper::-webkit-scrollbar {
    display: none;
}

.content-wrapper {
    -ms-overflow-style: none;
    scrollbar-width: none;
}

.fade-enter-active,
.fade-leave-active {
    transition: all 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
    opacity: 0;
    transform: translateY(10px);
}

.fade-enter-to,
.fade-leave-from {
    opacity: 1;
    transform: translateY(0);
}

.fade-title-enter-active,
.fade-title-leave-active {
    transition: opacity 0.6s ease;
    position: absolute;
    width: 100%;
}

.fade-title-enter-from,
.fade-title-leave-to {
    opacity: 0;
}

.fade-title-enter-to,
.fade-title-leave-from {
    opacity: 1;
}

.page-list {
    position: absolute;
    top: 10rem;
    left: 10rem;
    z-index: 10;
    display: flex;
    flex-direction: column;
    gap: 0.3rem;
    padding: 0.8rem;
    border-radius: 12px;
}

.page-item {
    color: rgba(255, 255, 255, 0.7);
    font-size: 0.85rem;
    cursor: pointer;
    padding: 0.4rem 0.8rem;
    border-radius: 8px;
    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 200px;
    font-family: 'Poppins', sans-serif;
    letter-spacing: 0.02em;
}

.page-item:hover {
    color: rgba(255, 255, 255, 0.95);
    transform: translateX(2px);
}

.page-item.active {
    color: #ffffff;
    font-weight: 500;
}
</style>