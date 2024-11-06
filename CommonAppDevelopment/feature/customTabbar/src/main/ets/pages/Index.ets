import { TABINFO } from '../model/TabBarData';
import { TabBarDataType } from '../model/DataType';

const HOME_TAB_BAR_INDEX: number = 0; // 初始化社区的tab下标
const COMMUNITY_TAB_BAR_INDEX: number = 2; // 初始化社区的tab下标
const ARC_MARGIN_TOP: number = -15; // 圆弧的上外间距为-15

@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  @State offsetY: number = 0
  @State homeExist: boolean = true;



  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End ,index: $$this.currentIndex}) {
        TabContent() {
          Text('首页的内容').fontSize(30)
        }
        TabContent() {
          Text('新品的内容').fontSize(30)
        }
        TabContent() {
          Text('社区的内容').fontSize(30)
        }
        TabContent() {
          Text('购物车内容').fontSize(30)
        }
        TabContent() {
          Text('我的').fontSize(30)
        }
      }
      .scrollable(false)
      .barHeight(0)
      .backgroundColor('#DBD9DA')
      .onChange((index: number) => {
        this.currentIndex = index;
      })

      // 自定义TabBar组件
      CustomTabBar({ selectedIndex: $selectedIndex })


    }
    .height('100%')
    .width('100%')
  }


}

@Component
struct CustomTabBar {
  @Link selectedIndex: number; // 初始化被选定的tabBar下标
  @State iconOffset: number = 0; // 初始化tabBar图片的偏移量

  build() {
    Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
      // 数据量比较少的情况下推荐使用ForEach，遇到数据量比较多的场景，如列表场景、瀑布流场景等，推荐使用LazyForEach(https://docs.openharmony.cn/pages/v4.0/zh-cn/application-dev/quick-start/arkts-rendering-control-lazyforeach.md/)
      ForEach(TABINFO, (item: TabBarDataType, tabIndex: number) => {
        // 单独一个TabBar组件
        TabItem({
          iconOffset: this.iconOffset,
          tabBarIndex: tabIndex,
          selectedIndex: $selectedIndex,
        })

      })
    }
    .height(60)
  }
}

@Component
struct TabItem {
  @Prop iconOffset: number; // 初始化tabBar图片的偏移量
  @Prop tabBarIndex: number; // tabBar下标
  @Link selectedIndex: number; // 初始化被选定的tabBar下标

  build() {
    Column() {
      Stack() {
        // 判断tab的下标是否为2
        if (this.tabBarIndex === COMMUNITY_TAB_BAR_INDEX) {
          Column() {
            Image(this.selectedIndex === this.tabBarIndex ? TABINFO[this.tabBarIndex].selectedIcon :
            TABINFO[this.tabBarIndex].defaultIcon)
              .size({
                width: $r('app.integer.custom_tab_community_image_size'),
                height: $r('app.integer.custom_tab_community_image_size')
              })
              .interpolation(ImageInterpolation.High) // TODO：知识点：使用interpolation属性对图片进行插值，使图片显示得更清晰
          }
          .width($r('app.integer.custom_tab_community_image_container_size'))
          .height($r('app.integer.custom_tab_community_image_container_size'))
          // TODO：知识点：通过设置borderRadius以及margin的top值实现圆弧外轮廓效果。
          .borderRadius($r('app.integer.custom_tab_community_image_container_border_radius_size'))
          .margin({ top: ARC_MARGIN_TOP })
          .backgroundColor(Color.White)
          .justifyContent(FlexAlign.Center)
        } else {
          Column() {
            // 通过被选中的tabBar下标值和tabBar的默认下标值来改变图片显示
            Image(this.selectedIndex === this.tabBarIndex ? TABINFO[this.tabBarIndex].selectedIcon :
            TABINFO[this.tabBarIndex].defaultIcon)// TODO：知识点：使用interpolation属性对图片进行插值，使图片显示得更清晰
              .interpolation(ImageInterpolation.High)
              .size(this.selectedIndex === HOME_TAB_BAR_INDEX && this.selectedIndex === this.tabBarIndex ?
                {
                  width: $r('app.integer.custom_tab_community_image_size'),
                  height: $r('app.integer.custom_tab_community_image_size')
                } :
                {
                  width: $r('app.integer.custom_tab_image_size'),
                  height: $r('app.integer.custom_tab_image_size')
                })// TODO：知识点：通过offset控制图片的纵向偏移。
              .offset({
                y: (this.selectedIndex === this.tabBarIndex && this.selectedIndex !== COMMUNITY_TAB_BAR_INDEX) ?
                this.iconOffset : $r('app.integer.custom_tab_common_size_0')
              })// TODO：知识点：组件的某些通用属性变化时，可以通过属性动画animation实现过渡效果。本示例的动画效果是tabBar的图片向上偏移一小段距离
              .animation({
                duration: 400,
                curve: Curve.Ease,
                iterations: 1,
                playMode: PlayMode.Normal
              })
          }
          .width(this.selectedIndex === HOME_TAB_BAR_INDEX && this.selectedIndex === this.tabBarIndex ?
          $r('app.integer.custom_tab_community_image_size') : $r('app.integer.custom_tab_image_container_size'))
          .height(this.selectedIndex === HOME_TAB_BAR_INDEX && this.selectedIndex === this.tabBarIndex ?
          $r('app.integer.custom_tab_community_image_size') : $r('app.integer.custom_tab_image_container_size'))
          .justifyContent(FlexAlign.Center)
        }
      }

      Text(TABINFO[this.tabBarIndex].title)
        .fontSize($r('app.integer.custom_tab_text_font_size'))
        .fontColor(this.selectedIndex === this.tabBarIndex ? $r('app.color.custom_tab_selected_text_color') :
        Color.Black)
        .visibility(this.selectedIndex === HOME_TAB_BAR_INDEX && this.selectedIndex === this.tabBarIndex ?
        Visibility.None : Visibility.Visible)
    }
    .width($r('app.integer.custom_tab_height_size'))
    .onClick(() => {
      // 更新被选中的tabBar下标
      this.selectedIndex = this.tabBarIndex;
      // 此处控制tabBar的Image图片向上偏移
      this.iconOffset = -3;
    })
  }
}