<template>
  <div class="thoughts-view">
    <div class="title-section">
      <h1>thoughts</h1>
    </div>

    <div class="main-sections">
      <section class="main-section">
        <div class="sub-title">thoughts 诞生幕后</div>
        <!-- <div class="cover-section"> -->
        <img
          class="cover"
          src="@/assets/special/thoughts_cover.jpg"
          alt="Thoughts Cover"
          @click="openPreview('@/assets/special/thoughts_cover_high.jpg')"
        />
        <!-- </div> -->
        <div class="section-spacing"></div>
        <div class="content">
          <div class="story-item">
            <h3>制作历程</h3>
            <p>
              <b>thoughts</b> 这个系列的想法大约在两年前开始浮现。
              我们一直是比较胡来的创作思路，五年间，几乎是想到哪里就做到哪里。
              但随着时间的推移，渐渐地也想分享给你属于我们自己的声音。
            </p>

            <p>
              <b>thoughts</b> 的创作逻辑是一种逆向思维。
              先征集成员们想实现怎样的声音方向，汇总后经过讨论和细微的调整，得出专辑的主题和方向。
              这样的好处在于可以不用被主题所限制，可以最大程度的发挥所思所想，专辑也不会过于发散。
              可以说是真正的展现出我们的 "thoughts"。
            </p>

            <p>
              当然，作为首张专辑，还是不可避免地出现了一些过于命题作文的情况，在未来会逐渐调整。
            </p>

            <p>
              总之，<b>thoughts</b> 今后将作为 Thoughost
              "直接"传达给你们我们所构想声音的系列，也就是所谓的
              <i>Thoughost Compilation Series</i> 。 当然，这不意味着 Thoughost
              的胡来结束了，我们正准备更尽情的发疯。
            </p>

            <p>
              第一张顺理成章地将主题定为了 "rebirth"。 既象征这是 Thoughost
              的下一步，也说明了本次整体的声音方向。
              听起来有些忧伤，仿佛被灰色笼罩的世界，在这之中抓住了一丝光亮。
              虽然是很不具象的画面，但大家都从不同的角度诠释了这一主题。
            </p>

            <p>更详细的创作幕后，请见下方各位的自我说明。</p>
            <p>感谢你们的支持。</p>
          </div>
        </div>
      </section>

      <section class="main-section scrollable">
        <div class="sub-title">音乐制作幕后</div>
        <!-- <div class="section-spacing"></div> -->
        <SimpleCarousel :items="musicCards" :autoRotateInterval="30000" />
      </section>

      <section class="main-section scrollable">
        <div class="sub-title">艺术设计幕后</div>

        <div class="section-spacing"></div>

        <div
          style="
            font-size: 1.2rem;
            font-weight: 500;
            line-height: 2.2rem;
            margin-bottom: 2rem;
          "
        >
          初期概念图
        </div>

        <div class="design-images">
          <div class="design-image-item">
            <img
              src="@/assets/special/封面艺术全过程/1.初期概念图/8EE8656FFD2263354F90D963C53CD778.png"
              alt="Thoughts Art Initial 1"
              @click="
                openPreview(
                  '@/assets/special/封面艺术全过程/1.初期概念图/8EE8656FFD2263354F90D963C53CD778.png'
                )
              "
            />
            <p>图：初期概念图 1</p>
          </div>
          <div class="design-image-item">
            <img
              src="@/assets/special/封面艺术全过程/1.初期概念图/01897AF2C4D4A4C8BAA5128DBADECB29.jpg"
              alt="Thoughts Art Initial 1"
              @click="
                openPreview(
                  '@/assets/special/封面艺术全过程/1.初期概念图/01897AF2C4D4A4C8BAA5128DBADECB29.jpg'
                )
              "
            />
            <p>图：初期概念图 2</p>
          </div>
        </div>

        <div
          style="
            font-size: 1.2rem;
            font-weight: 500;
            line-height: 2.2rem;
            margin: 4rem 0 2rem 0;
          "
        >
          人设三视图
        </div>

        <div class="design-images">
          <div class="design-image-item wide">
            <img
              src="@/assets/special/封面艺术全过程/2.人设三视图.png"
              alt="Thoughts Art Character Design"
              @click="openPreview('@/assets/special/封面艺术全过程/2.人设三视图.png')"
            />
            <p>图：人设三视图</p>
          </div>
        </div>

        <div
          style="
            font-size: 1.2rem;
            font-weight: 500;
            line-height: 2.2rem;
            margin: 4rem 0 2rem 0;
          "
        >
          构图探索
        </div>

        <div class="design-images">
          <div class="design-image-item">
            <img
              src="@/assets/special/封面艺术全过程/3.构图探索/4BB5645680F82733BAC4AE0798D13826.jpg"
              alt="Thoughts Art Composition 1"
              @click="
                openPreview(
                  '@/assets/special/封面艺术全过程/3.构图探索/4BB5645680F82733BAC4AE0798D13826.jpg'
                )
              "
            />
            <p>图：构图探索 1</p>
          </div>
          <div class="design-image-item">
            <img
              src="@/assets/special/封面艺术全过程/3.构图探索/055CBD158985E875845001C1222AD5A1.jpg"
              alt="Thoughts Art Composition 2"
              @click="
                openPreview(
                  '@/assets/special/封面艺术全过程/3.构图探索/055CBD158985E875845001C1222AD5A1.jpg'
                )
              "
            />
            <p>图：构图探索 2</p>
          </div>
          <div class="design-image-item">
            <img
              src="@/assets/special/封面艺术全过程/3.构图探索/0DC666F49BE6BBF547931E9155588CE6.jpg"
              alt="Thoughts Art Composition 3"
              @click="
                openPreview(
                  '@/assets/special/封面艺术全过程/3.构图探索/0DC666F49BE6BBF547931E9155588CE6.jpg'
                )
              "
            />
            <p>图：构图探索 3</p>
          </div>
        </div>

        <div
          style="
            font-size: 1.2rem;
            font-weight: 500;
            line-height: 2.2rem;
            margin: 4rem 0 2rem 0;
          "
        >
          完成过程
        </div>

        <div class="design-images">
          <div class="design-image-item">
            <img
              src="@/assets/special/封面艺术全过程/4.完成过程/1.png"
              alt="Thoughts Art Final 1"
              @click="openPreview('@/assets/special/封面艺术全过程/4.完成过程/1.png')"
            />
            <p>图：完成过程 1</p>
          </div>
          <div class="design-image-item">
            <img
              src="@/assets/special/封面艺术全过程/4.完成过程/2.png"
              alt="Thoughts Art Final 2"
              @click="openPreview('@/assets/special/封面艺术全过程/4.完成过程/2.png')"
            />
            <p>图：完成过程 2</p>
          </div>
          <div class="design-image-item">
            <img
              src="@/assets/special/封面艺术全过程/4.完成过程/3.png"
              alt="Thoughts Art Final 3"
              @click="openPreview('@/assets/special/封面艺术全过程/4.完成过程/3.png')"
            />
            <p>图：完成过程 3</p>
          </div>
          <div class="design-image-item">
            <img
              src="@/assets/special/封面艺术全过程/4.完成过程/4.png"
              alt="Thoughts Art Final 4"
              @click="openPreview('@/assets/special/封面艺术全过程/4.完成过程/4.png')"
            />
            <p>图：完成过程 4</p>
          </div>
        </div>

        <div
          style="
            font-size: 1.2rem;
            font-weight: 500;
            line-height: 2.2rem;
            margin: 4rem 0 2rem 0;
          "
        >
          封面设计
        </div>

        <div class="design-images">
          <div class="design-image-item">
            <img
              src="@/assets/special/thoughts_cover.jpg"
              alt="Thoughts Art Cover Design"
              @click="openPreview('@/assets/special/thoughts_cover.jpg')"
            />
            <p>图：封面设计</p>
          </div>
          <div class="design-image-item">
            <img
              src="@/assets/special/thoughts_background.png"
              alt="Thoughts Art Cover Background"
              @click="openPreview('@/assets/special/thoughts_background.png')"
            />
            <p>图：封面背景</p>
          </div>
        </div>

        <SimpleCarousel :items="artCards" :autoRotateInterval="30000" />
      </section>

      <section class="main-section">
        <!-- <div class="sub-title">Konseki Takane</div> -->
        <div style="margin-top: 3rem"></div>
        <span
          style="
            font-size: 1.7rem;
            font-weight: 1000;
            line-height: 2.2rem;
            font-family: 'Poppins', sans-serif;
          "
          >Konseki Takane</span
        >
        <br />
        <span
          style="
            font-size: 0.8rem;
            color: #666666;
            font-style: italic;
            font-family: 'Poppins', sans-serif;
          "
          >Art Direction & Design</span
        >
        <!-- margin -->
        <div style="margin-bottom: 3rem"></div>
        <div class="story-item">
          <p>
            从一开始，我就想找一位"系列画家"。同这个系列共同成长，直观地感受到我们的成长。为此物色了很多人，最终决定让
            TARA#376 担任系列画家。
          </p>
          <p>
            TARA#376 曾以 illness_liquor 的名义为我们提供过音乐，也为我们绘制过
            fanart。虽然谈不上是那种第一眼就留下深刻印象的风格，但胜在复古、经典，是耐看的类型，符合我对这个系列的整体印象。从另一方面来说潜力很大，是可以一起并肩进步的伙伴，为此敲定了人选。
          </p>
          <p>
            这也是她第一次做系列角色的角色设计，为此较劲了脑汁，在深夜和我讨论角色呈现的方向时压力太大而落泪，对此我真的很愧疚和抱歉，也很感谢。最后呈现的角色是一位不花哨、不显眼、不突出，只是安静呆在那里，有点神秘，又有点神圣，谜团很多，像一张白纸一样的角色，甚至没有名字，我觉得很符合这个系列整体的氛围。
          </p>
          <p>我只提出了最初期的猜想，剩下的全是 TARA#376 一个人的构想，实在是了不起。</p>
          <p>下面有几个不同的构图方向。</p>

          <div class="small-design-images">
            <div class="small-design-image-item">
              <img
                src="@/assets/special/封面艺术全过程/3.构图探索/4BB5645680F82733BAC4AE0798D13826.jpg"
                alt="Thoughts Art Composition 1"
                @click="
                  openPreview(
                    '@/assets/special/封面艺术全过程/3.构图探索/4BB5645680F82733BAC4AE0798D13826.jpg'
                  )
                "
              />
            </div>

            <div class="small-design-image-item">
              <img
                src="@/assets/special/封面艺术全过程/3.构图探索/055CBD158985E875845001C1222AD5A1.jpg"
                alt="Thoughts Art Composition 2"
                @click="
                  openPreview(
                    '@/assets/special/封面艺术全过程/3.构图探索/055CBD158985E875845001C1222AD5A1.jpg'
                  )
                "
              />
            </div>

            <div class="small-design-image-item">
              <img
                src="@/assets/special/封面艺术全过程/3.构图探索/0DC666F49BE6BBF547931E9155588CE6.jpg"
                alt="Thoughts Art Composition 3"
                @click="
                  openPreview(
                    '@/assets/special/封面艺术全过程/3.构图探索/0DC666F49BE6BBF547931E9155588CE6.jpg'
                  )
                "
              />
            </div>
          </div>

          <p>我选择了其中的一个版本，在一点一点的沟通和交流中推进了下去。</p>
          <p>
            我特意没有往复杂的方向做后期设计部分的工作，相反，从一开始我的脑子里只有"怎样让
            TARA#376
            的作品更出挑"，"让整体的氛围更融洽"。以干净，简洁的印象推进，最后的效果看起来像是什么都没有加。
          </p>
          <p>
            我希望封面看起来就像碟片里收录的音乐一样，不浮躁，不惹人眼球，只是安静地躺在那里，等待你们的静静聆听，能作为一副一直看下去的作品。
          </p>
          <p>
            这么想的话，似乎在现在的浪潮中，显得有些不够惹人眼球，连我自己都觉得应该很难注意到它。
          </p>
          <p>最后的结果，个人来说我很满意，也希望你们会喜欢。</p>
        </div>
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
          <div class="credit-group">
            <h3>Special Page Web Design</h3>
            <div class="credit-list">
              <span>wheatfox</span>
            </div>
          </div>
        </div>
      </section>
    </div>
    <ImagePreview
      :is-open="previewOpen"
      :image-src="previewImage"
      :alt="previewAlt"
      @close="closePreview"
    />
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";
import SimpleCarousel from "@/components/SimpleCarousel.vue";
import ImagePreview from "@/components/ImagePreview.vue";

// Import all images
import thoughtsCoverHigh from "@/assets/special/thoughts_cover_high.jpg";
import thoughtsCover from "@/assets/special/thoughts_cover.jpg";
import thoughtsBackground from "@/assets/special/thoughts_background.png";
import thoughtsBackgroundHigh from "@/assets/special/thoughts_background_high.png";

// Import design process images
import designInitial1 from "@/assets/special/封面艺术全过程/1.初期概念图/8EE8656FFD2263354F90D963C53CD778.png";
import designInitial1High from "@/assets/special/封面艺术全过程/1.初期概念图/8EE8656FFD2263354F90D963C53CD778_high.png";
import designInitial2 from "@/assets/special/封面艺术全过程/1.初期概念图/01897AF2C4D4A4C8BAA5128DBADECB29.jpg";
import designInitial2High from "@/assets/special/封面艺术全过程/1.初期概念图/01897AF2C4D4A4C8BAA5128DBADECB29_high.jpg";
import designCharacter from "@/assets/special/封面艺术全过程/2.人设三视图.png";
import designCharacterHigh from "@/assets/special/封面艺术全过程/2.人设三视图_high.png";
import designComposition1 from "@/assets/special/封面艺术全过程/3.构图探索/4BB5645680F82733BAC4AE0798D13826.jpg";
import designComposition1High from "@/assets/special/封面艺术全过程/3.构图探索/4BB5645680F82733BAC4AE0798D13826_high.jpg";
import designComposition2 from "@/assets/special/封面艺术全过程/3.构图探索/055CBD158985E875845001C1222AD5A1.jpg";
import designComposition2High from "@/assets/special/封面艺术全过程/3.构图探索/055CBD158985E875845001C1222AD5A1_high.jpg";
import designComposition3 from "@/assets/special/封面艺术全过程/3.构图探索/0DC666F49BE6BBF547931E9155588CE6.jpg";
import designComposition3High from "@/assets/special/封面艺术全过程/3.构图探索/0DC666F49BE6BBF547931E9155588CE6_high.jpg";
import designFinal1 from "@/assets/special/封面艺术全过程/4.完成过程/1.png";
import designFinal1High from "@/assets/special/封面艺术全过程/4.完成过程/1_high.png";
import designFinal2 from "@/assets/special/封面艺术全过程/4.完成过程/2.png";
import designFinal2High from "@/assets/special/封面艺术全过程/4.完成过程/2_high.png";
import designFinal3 from "@/assets/special/封面艺术全过程/4.完成过程/3.png";
import designFinal3High from "@/assets/special/封面艺术全过程/4.完成过程/3_high.png";
import designFinal4 from "@/assets/special/封面艺术全过程/4.完成过程/4.png";
import designFinal4High from "@/assets/special/封面艺术全过程/4.完成过程/4_high.png";

export default defineComponent({
  name: "SpecialViewThoughts",
  components: { SimpleCarousel, ImagePreview },
  setup() {
    const previewOpen = ref(false);
    const previewImage = ref("");
    const previewAlt = ref("");

    // Create a map of image paths to imported images
    const imageMap: Record<string, string> = {
      "@/assets/special/thoughts_cover.jpg": thoughtsCover,
      "@/assets/special/thoughts_cover_high.jpg": thoughtsCoverHigh,
      "@/assets/special/thoughts_background.png": thoughtsBackground,
      "@/assets/special/thoughts_background_high.png": thoughtsBackgroundHigh,
      "@/assets/special/封面艺术全过程/1.初期概念图/8EE8656FFD2263354F90D963C53CD778.png": designInitial1,
      "@/assets/special/封面艺术全过程/1.初期概念图/8EE8656FFD2263354F90D963C53CD778_high.png": designInitial1High,
      "@/assets/special/封面艺术全过程/1.初期概念图/01897AF2C4D4A4C8BAA5128DBADECB29.jpg": designInitial2,
      "@/assets/special/封面艺术全过程/1.初期概念图/01897AF2C4D4A4C8BAA5128DBADECB29_high.jpg": designInitial2High,
      "@/assets/special/封面艺术全过程/2.人设三视图.png": designCharacter,
      "@/assets/special/封面艺术全过程/2.人设三视图_high.png": designCharacterHigh,
      "@/assets/special/封面艺术全过程/3.构图探索/4BB5645680F82733BAC4AE0798D13826.jpg": designComposition1,
      "@/assets/special/封面艺术全过程/3.构图探索/4BB5645680F82733BAC4AE0798D13826_high.jpg": designComposition1High,
      "@/assets/special/封面艺术全过程/3.构图探索/055CBD158985E875845001C1222AD5A1.jpg": designComposition2,
      "@/assets/special/封面艺术全过程/3.构图探索/055CBD158985E875845001C1222AD5A1_high.jpg": designComposition2High,
      "@/assets/special/封面艺术全过程/3.构图探索/0DC666F49BE6BBF547931E9155588CE6.jpg": designComposition3,
      "@/assets/special/封面艺术全过程/3.构图探索/0DC666F49BE6BBF547931E9155588CE6_high.jpg": designComposition3High,
      "@/assets/special/封面艺术全过程/4.完成过程/1.png": designFinal1,
      "@/assets/special/封面艺术全过程/4.完成过程/1_high.png": designFinal1High,
      "@/assets/special/封面艺术全过程/4.完成过程/2.png": designFinal2,
      "@/assets/special/封面艺术全过程/4.完成过程/2_high.png": designFinal2High,
      "@/assets/special/封面艺术全过程/4.完成过程/3.png": designFinal3,
      "@/assets/special/封面艺术全过程/4.完成过程/3_high.png": designFinal3High,
      "@/assets/special/封面艺术全过程/4.完成过程/4.png": designFinal4,
      "@/assets/special/封面艺术全过程/4.完成过程/4_high.png": designFinal4High,
    };

    const openPreview = (imagePath: string) => {
      const highResPath = imagePath.includes("_high")
        ? imagePath
        : imagePath.replace(".jpg", "_high.jpg").replace(".png", "_high.png");
      console.log(highResPath, imagePath);
      const image = imageMap[highResPath];
      if (image) {
        previewImage.value = image;
        previewAlt.value = "Image preview";
        previewOpen.value = true;
      }
    };

    const closePreview = () => {
      previewOpen.value = false;
      previewImage.value = "";
      previewAlt.value = "";
    };

    const musicCards = [
      {
        title: "VeetaCrush",
        content: ["没什么好说的，给大家表演一个冥想吧. 。o O (sb...)"],
        subtitle: "TR 1: palette ii",
      },
      {
        title: "Joulez",
        content: [
          "这次写 Drum'n'Bass 貌似和其他其他人有些风格重合。",
          "最初的时候写出来了一个很好听的动机，于是就把曲子的目标定为 thoughts 的发行曲目。",
          "这一次尝试用自己的声音唱 vocal，我想效果还可以。",
        ],
        subtitle: "TR 2: Awake",
      },
      {
        title: "潮音きつね",
        content: [
          "最近写 techno 都比较 trance… 总之是以某款酒为灵感写的幻之乐曲，",
          "最后取了鲁米诺的微光为要传达的意象。",
        ],
        subtitle: "TR 3: 幽けきルミノールライト",
      },
      {
        title: "望月真白",
        content: [
          "企划本身去年秋 M3 之前应该就有在说了，构思到实际开始写沉淀了好几个月，一直在听 I've sound 还有各种 galgame 配乐",
          "慢慢地就把 reference track 定成了这两首——",
          "Taishi 写给すぽコンの Jet Loser, 以及和青葉りんご合作砖的 inst 曲 The Inner Gaze-Will-",
          "冲劲满满的碎拍和飘渺悠远的氛围感，虚幻飘渺的合成器与钢琴是我一直想试着做的声音",
          "花了很多心血，但做出来后离想实现的效果还有距离，所以还会继续努力的。",
        ],
        subtitle: "TR 4: Lucidandelion",
      },
      // {
      //   title: 'Aki Sz',
      //   content: [
      //     '占位段落',
      //     '占位段落',
      //     '占位段落'
      //   ],
      //   subtitle: 'TR 5: Titania'
      // },
      // {
      //   title: 'かたぎり',
      //   content: [
      //     '占位段落',
      //     '占位段落',
      //     '占位段落'
      //   ],
      //   subtitle: 'TR 6: December'
      // },
      {
        title: "wheatfox",
        content: [
          "尝试做了一点 atmospheric 的 liquid funk，",
          "在采样和音色上主要考虑了 urban 的氛围感，声音参考：DualSide 的 impressesky 系列。",
          "（PS：这个社团的大部分作品我还蛮喜欢的，但是从 bandcamp 上来看听众并不多，大家有兴趣可以关注一下他们的 bandcamp 和 M3 现场活动）",
          "最后，这首曲子还塞了一个小彩蛋（划掉）。",
          "谢谢大家♥",
        ],
        subtitle: "TR 7: 6 p.m.",
      },
      {
        title: "Nirotiy",
        content: [
          "自我demo库的一首 Tribal Techno 改变而成。",
          "当我了解到专辑封面的看板设定之后灵光一闪，于是试图用 Techno 作为载体进行叙事音乐的书写。",
          "Tribal 节奏象征混沌初开的人类足迹，后续由合成音捏造的 Key 以及 Woodwind 标识着人类对尚无法解释的事物的神化描写。 Choir 和 Synth 的爆发将本曲推向高潮，经天灾或是人祸而逝去的生命又开始了新的轮转，而她身着一袭白衣，纤尘不染却只言不语。琴声结束，她将继续是悄无声息的见证者。",
          "如果你觉得我在 Neta 异度神剑（尤其是3）的话，恭喜你和我对上电波。",
        ],
        subtitle: "TR 8: Voix sacrée",
      },
      {
        title: "桃罐",
        content: [
          "最开始我想写的是一个与曇天完全不一样的曲子，但当我看到TARA#376老师的插画时，我完全调转了我的方向，写了一首与所有人都完全不同的曲子",
          "词是听了三天的陈奕迅写出来的，但显然写出来的粤语并没有广东人听得懂",
          "希望下次能做出更多的音乐",
          "",
          "Tara老师画的怎么这么好啊啊啊啊啊啊啊啊啊啊！！！！@！@！！！！",
        ],
        subtitle: "TR 9: 曇天",
      },
      // {
      //   title: 'Rayven',
      //   content: [
      //     '占位段落',
      //     '占位段落',
      //     '占位段落'
      //   ],
      //   subtitle: 'TR 10: Epilogue'
      // }
    ];
    const artCards = [
      {
        title: "TARA#376",
        subtitle: "Illustration",
        content: [
          "很高兴负责了本次专辑的封面插画和角色设计。",
          '自三年前开始了解 Thoughost 和他们的作品，并以公募形式参与过 2022 年的"蒼"合集，也画过一些 fanart。',
          "这次能参与新作的插画，真的非常高兴。",
          "",
          "因为是想灵的新系列，未来有着以同一角色展现不同的专辑主题的目的，所以先决定了角色设计。Konseki 给出的设计方向非常明确，所以没有花太长时间得出最终结果。如你所见非常合适！",
          "封面插图方面，由于这是首次针对专辑考虑构图，加上我并不算擅长这次需求的风格，尝试了非常非常多次。总之最后还是努力地找到了适合的美术方向。",
          "",
          "虽然最终结果可能仍旧不尽人意，看得出来缺乏专业的经验和技术，但我觉得是一个好的开始。",
          "希望今后也能和想灵，还有 thoughts 系列一起进步！",
        ],
      },
      // {
      //   title: 'Konseki Takane',
      //   subtitle: 'Art Direction & Design',
      //   content: [
      //     '从一开始，我就想找一位"系列画家"。同这个系列共同成长，直观地感受到我们的成长。为此物色了很多人，最终决定让TARA#376担任系列画家。',
      //     'TARA#376曾以illness_liquor的名义为我们提供过音乐，也为我们绘制过fanart。虽然谈不上是那种第一眼就留下深刻印象的风格，但胜在复古、经典，是耐看的类型，符合我对这个系列的整体印象。从另一方面来说潜力很大，是可以一起并肩进步的伙伴，为此敲定了人选。',
      //     '这也是她第一次做系列角色的角色设计，为此较劲了脑汁，在深夜和我讨论角色呈现的方向时压力太大而落泪，对此我真的很愧疚和抱歉，也很感谢。最后呈现的角色是一位不花哨、不显眼、不突出，只是安静呆在那里，有点神秘，又有点神圣，谜团很多，像一张白纸一样的角色，甚至没有名字，我觉得很符合这个系列整体的氛围。',
      //     '我只提出了最初期的猜想，剩下的全是TARA#376一个人的构想，实在是了不起。',
      //     '下面有几个不同的构图方向。我选择了其中的一个版本，在一点一点的沟通和交流中推进了下去。',
      //     '我特意没有往复杂的方向做后期设计部分的工作，相反，从一开始我的脑子里只有"怎样让TARA#376的作品更出挑"，"让整体的氛围更融洽"。以干净，简洁的印象推进，最后的效果看起来像是什么都没有加。',
      //     '我希望封面看起来就像碟片里收录的音乐一样，不浮躁，不惹人眼球，只是安静地躺在那里，等待你们的静静聆听，能作为一副一直看下去的作品。',
      //     '这么想的话，似乎在现在的浪潮中，显得有些不够惹人眼球，连我自己都觉得应该很难注意到它。',
      //     '最后的结果，个人来说我很满意，也希望你们会喜欢。'
      //   ]
      // }
    ];
    return {
      musicCards,
      artCards,
      previewOpen,
      previewImage,
      previewAlt,
      openPreview,
      closePreview,
    };
  },
});
</script>

<style scoped>
.small-design-image-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.small-design-image-item img {
  width: 90%;
  max-width: 400px;
}

.small-design-images {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
}

.section-spacing {
  height: 2rem;
}

.title-section {
  margin-top: 2rem;
  margin-bottom: 2rem;
  background: linear-gradient(135deg, #000000 0%, #1a1a1a 50%, #000000 100%);
  padding: 4rem;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
  position: relative;
  overflow: hidden;
}

.title-section::after {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(
    45deg,
    rgba(255, 255, 255, 0.1) 0%,
    rgba(255, 255, 255, 0) 100%
  );
  pointer-events: none;
}

.title-section h1 {
  color: #ffffff;
  margin: 0;
  font-size: 2.2rem;
  font-weight: 700;
  font-family: "Poppins", sans-serif;
}

.thoughts-view {
  padding: 0;
  max-width: 100%;
  margin: 0;
  font-family: "Nunito Sans", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
    "Helvetica Neue", Arial, sans-serif;
  text-align: center;
  background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 50%, #f8f9fa 100%);
  color: #333333;
  font-size: 0.9rem;
}

.cover-section {
  margin-bottom: 0;
  text-align: center;
  padding: 4rem;
  background: #ffffff;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
  position: relative;
}

.cover {
  max-width: 400px;
  width: 100%;
  transition: transform 0.3s ease;
}

.cover:hover {
  transform: scale(1.02);
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
  padding: 3rem;
  width: 100%;
  max-width: 100%;
  border-top: 1px solid rgba(0, 0, 0, 0.05);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
  position: relative;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.main-section.scrollable {
  color: #000000;
  padding: 0;
  margin-top: 1rem;
  position: relative;
}

.main-section.scrollable > *:not(.sub-title) {
  position: relative;
  z-index: 1;
}

.sub-title {
  font-size: 1.4rem;
  font-weight: 1000;
  line-height: 2rem;
  margin-bottom: 2rem;
  text-align: center;
  color: #333333;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  background: rgba(255, 255, 255, 0.95);
  padding: 1.5rem 0;
  z-index: 10;
  transition: all 0.3s ease;
  width: 100%;
  margin-left: 0;
  margin-right: 0;
  font-family: "Poppins", sans-serif;
}

.main-section.scrollable .sub-title {
  color: #000000;
  background: rgba(255, 255, 255, 0.95);
  z-index: 10;
  transition: all 0.3s ease;
  margin-bottom: 0;
  width: 100%;
  margin-left: 0;
  margin-right: 0;
}

.content {
  font-size: 1rem;
  font-weight: 400;
  line-height: 1.6;
  text-align: center;
  color: #666666;
  max-width: 1600px;
  margin: 0 auto;
}

.story-item {
  margin-bottom: 2rem;
  text-align: left;
  max-width: 1000px;
  margin-left: auto;
  margin-right: auto;
  font-family: "Nunito Sans", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
    "Helvetica Neue", Arial, sans-serif;
}

.story-item h3 {
  font-size: 1.2rem;
  font-weight: 800;
  margin-bottom: 1rem;
  color: #333333;
  text-align: left;
  font-family: "Poppins", sans-serif;
}

.story-item p {
  font-size: 0.9rem;
  line-height: 1.6;
  color: #666666;
  text-align: left;
  margin: 0.5rem 0;
  font-family: "Nunito Sans", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
    "Helvetica Neue", Arial, sans-serif;
}

.credits {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  align-items: center;
}

.credit-group {
  /* border-bottom: 1px solid rgba(0, 0, 0, 0.1);c */
  padding-bottom: 1rem;
  width: 100%;
  text-align: center;
}

.credit-group:last-child {
  border-bottom: none;
}

.credit-group h3 {
  font-size: 1rem;
  color: #333333;
  margin-bottom: 0.5rem;
  font-family: "Poppins", sans-serif;
}

.credit-list {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
  justify-content: center;
}

.credit-list span {
  font-size: 0.85rem;
  color: #666666;
}

.design-images {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  align-items: flex-start;
  justify-content: center;
  gap: 2rem;
  width: 100%;
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 2rem;
}

.design-image-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  flex: 0 1 auto;
  min-width: 300px;
}

.design-image-item img {
  width: 100%;
  max-width: 300px;
  transition: transform 0.3s ease;
  cursor: pointer;
}

.design-image-item img:hover {
  transform: scale(1.02);
}

.design-image-item p {
  font-size: 0.9rem;
  /* font-weight: 00; */
  line-height: 1.8rem;
  margin-top: 1rem;
  text-align: center;
  color: #666666;
}

.design-image-item.wide {
  flex: 0 1 100%;
  max-width: 1000px;
}

.design-image-item.wide img {
  max-width: 100%;
  width: 100%;
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

  .design-images {
    flex-direction: column;
    align-items: center;
    padding: 0 1rem;
  }

  .design-image-item {
    width: 100%;
    min-width: auto;
  }

  .design-image-item img {
    width: 80%;
    max-width: 250px;
  }

  .design-image-item.wide {
    max-width: 100%;
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
