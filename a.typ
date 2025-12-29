// [typst 0.13]
#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.4" as fletcher: node, edge
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

#import "@preview/grayness:0.2.0": *

// #let data = read("img/ignoreme-19.jpg", encoding: none)

// #set page(background: transparent-image(data, alpha: 50%, width: 100%, height: 100%))

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  // config-common(handout: true),
  config-common(frozen-counters: (theorem-counter,)), // freeze theorem counter for animation
  config-info(
    title: [],
    subtitle: [],
    author: [方俊杰.SJTU],
    date: datetime.today(),
    institution: [],
  ),
)

// [my]
// [my.config]
#let tea = false
#let tbl = it => {
  if tea {
    it
  }
}

// [my.heading]
#show heading.where(level: 1): set heading(numbering: numbly("{1}.", default: "1.1"))

// [my.code]
#show raw.where(lang: "cpp"): it => {
  set text(12pt)
  it
}
#show raw.where(block: false): it => box(
  fill: rgb(248, 248, 248),
  outset: 4pt,
  radius: 3pt,
  stroke: 0.5pt + gray,
  it,
)
#show raw.where(block: true): it => box(
  fill: rgb(248, 248, 248),
  outset: 8pt,
  radius: 3pt,
  stroke: 0.5pt + gray,
  it,
)
#show raw: it => box()[
  #set text(font: ("0xProto Nerd Font Mono"))
  #it
]

// [my.text]
#set text(12pt)
#set text(font: ("Comic Sans MS", "Heiti SC"))
#show strong: set text(weight: 900) // Songti SC 700 不够粗

#set list(indent: 0.8em)
#show link: underline

// [my.util]
#let box-img(img, width, radius) = {
  box(
    image(img, width: width),
    radius: radius,
    clip: true,
  )
}

#let grids(imgs, col: auto) =  {
    figure(
      grid(
        columns: col,
        rows: auto,
        gutter: 3pt,
        ..imgs,
      ),
  )
}

#let emp = it => {
  strong(text(fill: red)[#it])
}

#let alert(body, fill: yellow) = {
  // set text(fill: white)
  rect(
    fill: fill,
    inset: 8pt,
    radius: 4pt,
    [*注意:\ #body*],
  )
}

#let hint(body, fill: blue) = {
  rect(
    fill: fill,
    inset: 8pt,
    radius: 4pt,
    [*#body*],
  )
}

#let lin = line(length: 100%)
#let im(p, h: auto) = {
  if p == 0 {
    figure(image("img/image.png", height: h))
  } else if p == 1 {
    figure(image("img/image copy.png", height: h))
  } else {
    figure(image("img/image copy " + str(p) + ".png", height: h))
  }
}
// [my.end]

#slide[
=== Gamma
#im(0)
#im(2, h: 15%)
#im(3)
#lin
#im(4)
=== $X^2$
一个自由度为 n 的卡方分布（χ²ₙ）被定义为 n 个独立同分布（i.i.d.）的标准正态随机变量的平方和。
#im(5)
][
=== Fisher F-D
X ~ χ²ₖ = Γ(k/2, 1/2) （自由度为 k 的卡方分布）
Y ~ χ²ₘ = Γ(m/2, 1/2) （自由度为 m 的卡方分布）
定义一个新的随机变量： F = (X/k) / (Y/m)
当 k 很大时，根据大数定律， X/k = (1/k)(X₁² + ... + Xₖ²) → E[X₁²] = 1
文本接着给出了一个关于F分布分位数的重要对称性质：
F_{k,m}(c, ∞) = F_{m,k}(0, 1/c) 可以理解:

P(F_{k,m} ≥ c) = P(F_{m,k} ≤ 1/c)
=== 学生t分布 (Student t-Distribution)
T = X₁ / √[ (Y₁² + ... + Yₙ²) / n ]\ 
X₁, Y₁, ..., Yₙ 是独立同分布（i.i.d.）的标准正态随机变量 N(0,1)。
分子 X₁ 是一个标准正态变量。
分母是 n 个标准正态变量平方和（即自由度为 n 的卡方变量 χ²ₙ）除以 n 后再开平方，这相当于样本标准差的估计（当总体方差为1时）。
#im(6)
=== 单样本性质 (Single Sample Properties)
样本均值 (X̄ₙ) 服从正态分布
X̄ₙ = (1/n) Σᵢ₌₁ⁿ Xᵢ ~ N(μ, σ²/n)
][
标准化的样本方差 ((n-1)Sₙ²/σ²) 服从卡方分布
(n-1)Sₙ² / σ² = (1/σ²) Σᵢ₌₁ⁿ (Xᵢ - X̄ₙ)² ~ χ² {n-1}
#im(7)
=== 两独立样本性质
1. 标准化样本方差之比 (F) 服从F分布
F = (S₁² / σ₁²) / (S₂² / σ₂²) = (S₁² / S₂²) \* (σ₂² / σ₁²) ~ F\_{m-1, n-1}

2. 当方差相等时，合并t统计量 (T_pooled) 服从t分布
T_pooled = [ (X̄ₘ - Ȳₙ) - (μ₁ - μ₂) ] / [ Sₚ √(1/m + 1/n) ] ~ t\_{m+n-2}
其中，合并方差 (pooled variance) 定义为：
Sₚ² = [ (m-1)S₁² + (n-1)S₂² ] / (m + n - 2)
3. T_Welch = [ (X̄ₘ - Ȳₙ) - (μ₁ - μ₂) ] / √(S₁²/m + S₂²/n) ~ tᵥ
这个公式与合并t检验非常相似，但关键区别在于：
分母没有使用合并方差 Sₚ，而是直接使用了两个样本的方差 S₁² 和 S₂² 的加权和 √(S₁²/m + S₂²/n)。
]
#slide[
自由度 ν 不是简单的 m+n-2，而是一个由 Welch-Satterthwaite 方程计算出的近似值。
Welch-Satterthwaite 自由度公式
ν = [ (S₁²/m + S₂²/n)² ] / [ (S₁²/m)²/(m-1) + (S₂²/n)²/(n-1) ]

置信水平（如95%）指的是重复抽样的过程：如果我们从同一个总体中抽取100个样本，并为每个样本构建一个95%的置信区间，那么大约有95个区间会包含真实的总体参数。
如果 X₁, ..., Xₙ 是 i.i.d. 标准正态变量，那么样本均值 X̄ 和样本方差 X̄² - (X̄)² 是相互独立的。此外：
√n X̄ ~ N(0,1)
n(X̄² - (X̄)²) ~ χ²\_{n-1}
=== [method] 标准化变量法
#im(8, h: 30%)
][
定义 8.1 (置信区间):
给定一个置信水平 α ∈ [0, 1]，设 S₁ = S₁(X₁, ..., Xₙ) 和 S₂ = S₂(X₁, ..., Xₙ) 是两个统计量，满足： P_θ₀(S₁ ≤ θ₀ ≤ S₂) = α (或 ≥ α)。
那么，区间 [S₁, S₂] 被称为未知参数 θ₀ 的一个置信水平为 α 的置信区间。
想象你有一个固定的靶心（真实参数 θ₀）。每次你射一支箭（抽取一个样本），然后根据这支箭的位置画一个范围（置信区间）。置信水平 α 就是说，如果你射100支箭，大约有 α \* 100 个范围会包含靶心。

置信区间 [S₁, S₂] 是随机的，因为它依赖于随机样本

#im(9)
][
#im(10)  
=== 估计 $sigma$ 置信区间
#im(11)
]

#slide[
μ 的 (1-α) 置信区间 = X̄ ± t\_{α/2, n-1} \* (s / √n)
σ² 的 (1-α) 置信区间 = [ nσ̂² / χ²\_{n-1, 1-α/2} , nσ̂² / χ²\_{n-1, α/2} ]

#im(12)
#im(13)

Step 1 Select a Good Point Estimate:
][

][

]