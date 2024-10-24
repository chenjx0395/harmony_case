import { curves, promptAction } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  //是否已交换
  @State isSwap: boolean = false;
  // X轴偏移量
  @State translateX: number = 0;
  // 旋转角度
  @State rotateAngle: number = 0
  // 整体内容区宽度
  private rowWidth: number = 300;

  build() {
    Column({ space: 15 }) {
      // 地址栏
      Row() {
        Text('北京')
          .width('40%')
          .translate({ x: this.translateX })
          .textAlign(this.isSwap ? TextAlign.End : TextAlign.Start)
        // 层叠图片
        Stack() {
          Image($r('app.media.address_exchange_recycle'))
            .width(28)
            .rotate({ angle: this.rotateAngle })
            // animation 实现图片动画
            .animation({
              curve: curves.springMotion(),
              playMode: PlayMode.Normal
            })
          Image($r('app.media.address_exchange_airplane')).width(16)
        }
        .width('20%')
        .onClick(_ => {
          this.isSwap = !this.isSwap
          animateTo({duration: 500 , curve: Curve.Linear},()=>{
          this.translateX = this.isSwap ? 180 : 0
          })
          this.rotateAngle += 180
        })

        Text('上海')
          .width('40%')
          .translate({ x: -this.translateX })
          .textAlign(this.isSwap ? TextAlign.Start : TextAlign.End)
      }.width(this.rowWidth).height(60)

      // 日期显示
      Row({ space: 20 }) {
        Text('10月24日').fontSize(24).fontWeight(500).height(30)
        Text('周四').fontSize(18).height(30)
      }.width(this.rowWidth)

      // 按钮
      Button('查询车票')
        .width(this.rowWidth)
        .height(40)
        .onClick(_ => {
          promptAction.showToast({
            message: "演示效果，业务未实现",
          })
        })
    }
    .backgroundColor('#F2F3F5')
    .borderRadius(10)
    .height('180')
    .width('95%')
    .margin(10)
  }
}