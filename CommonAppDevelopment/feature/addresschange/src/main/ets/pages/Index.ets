import { Position } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  @State animate: boolean = false;
  @State addressLeftOffset: Position = { x: 0, y: 0 }
  @State addressRightOffset: Position = { x: 0, y: 0 }
  @State addressRotate: RotateOptions = {angle: 0}

  build() {
    Column() {
      Column() {
        // 地址栏
        Row() {
          Text('北京').fontSize(18).offset(this.addressLeftOffset)
          Stack() {
            Image($r('app.media.address_exchange_recycle')).width(30)
              .rotate(this.addressRotate)
            Image($r('app.media.address_exchange_airplane')).width(20)
          }.onClick(_ => {
            console.log('xx')
            this.getUIContext()?.animateTo({duration: 500},()=>{
              this.animate = !this.animate
              this.addressLeftOffset = this.animate ? {x:260,y:0} :  {x:0,y:0}
              this.addressRightOffset = this.animate ? {x:-260,y:0} :  {x:0,y:0}
              this.addressRotate = this.animate ? {angle: 360} :  {angle: 0}
            })

          })
          Text('上海').fontSize(18).offset(this.addressRightOffset)
        }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({ top: 20 })

        // 日期显示
        Text() {
          Span('2月8日').fontSize(24).fontWeight(700)
          Span('   ')
          Span('周四').fontSize(18)
        }.textAlign(TextAlign.Start).width('100%')

        // 按钮
        Button('查询车票')
          .width('100%')
      }
      .backgroundColor('#F2F3F5')
      .width('100%')
      .height(200)
      .borderRadius(10)
      .padding(10)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .height('100%')
    .width('100%')
    .padding({
      left: 20,
      right: 20,
      top: 30,
      bottom: 30
    })
  }
}