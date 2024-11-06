/**
 * 类别类型
 * 组件含多级类型分类。固采用多级类别来作为数据标识
 */
export interface FirstLevelCategory {
  childNodes: SecondLevelCategory[] | ThirdLevelCategory[],
  selectedImage: Resource,
  unselectedImage: Resource,
  tabBarName: Resource
}

export interface SecondLevelCategory {
  title: Resource,
  childNodes: ThirdLevelCategory[],
  image?: Resource
}

export interface ThirdLevelCategory {
  image: Resource,
  title: Resource,
  url?: string,
  childNodes?: FourthLevelCategory[]
}

export interface FourthLevelCategory {
  title: Resource,
  url: string
}