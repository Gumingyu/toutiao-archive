# Toutiao Archive

这是 **头条英语角 · 词汇档案** 的静态网页项目，用来归档每一期新闻英语内容。每一期包含话题背景、核心词汇、重点句子、仿写框架、参考答案和总结，适合做长期积累和复习。

主页面是 [`archive_viewer.html`](archive_viewer.html)。https://gumingyu.github.io/toutiao-archive/archive_viewer.html 它是一个单文件静态网页，CSS、数据和 JavaScript 都写在这个 HTML 文件里，不需要安装依赖，也不需要构建。

## 功能

- 按期数/日期浏览英语学习内容。
- 查看每期的新闻标题、中文背景和分类。
- 学习核心词汇，包括音标、词性、难度、中文释义和例句。
- 查看重点句子精讲和短语拆解。
- 使用仿写框架练习表达。
- 在“全部词汇”里统一搜索词汇。
- 按难度筛选：初中、高中、四级、六级、考研、GRE。

## 文件说明

```text
.
|-- archive_viewer.html   # 主页面，包含界面、样式、数据和交互逻辑
|-- index.html            # GitHub Pages 默认入口文件
|-- deploy.bat            # Windows 一键部署脚本
`-- README.md             # 项目说明文件
```

## 本地查看

直接用浏览器打开：

```text
archive_viewer.html
```

这个项目是纯静态页面，不需要运行服务器，也不需要 Node.js、npm 或其他构建工具。

## 如何新增一期内容

所有内容数据都在 `archive_viewer.html` 的 `EPISODES` 数组里。

在文件中搜索：

```js
const EPISODES = [
```

然后按照已有格式新增一个对象。基础结构如下：

```js
{
  "ep": "2026-05-19",
  "topic_en": "English topic title",
  "topic_cn": "中文话题标题",
  "category": "话题分类",
  "source": "新闻来源或内容来源",
  "headline_en": "English headline",
  "headline_cn": "中文标题",
  "context_cn": "中文背景说明",
  "vocab": [
    {
      "word": "example",
      "ipa": "/ɪɡˈzæmpəl/",
      "pos": "N. NOUN",
      "level": "高中",
      "meaning_cn": "例子",
      "example_en": "This is an example sentence."
    }
  ],
  "key_sentence": {
    "en": "A useful sentence from the episode.",
    "cn": "对应中文翻译。",
    "chunks": [
      {
        "phrase": "useful phrase",
        "cn": "短语讲解"
      }
    ]
  },
  "writing_frame": {
    "template": "Use ___ to express ___.",
    "pattern_cn": "句型说明。",
    "answer_en": "Reference answer in English.",
    "answer_cn": "参考答案中文翻译。"
  },
  "takeaway": {
    "en": "One short English takeaway.",
    "cn": "一句中文总结。"
  },
  "china_relevance": "与中国语境的关联说明。"
}
```

编辑时注意：

- `ep` 建议使用 `YYYY-MM-DD` 格式，这样侧边栏排序更稳定。
- `level` 尽量使用已有等级：`初中`、`高中`、`四级`、`六级`、`考研`、`GRE`。
- 每个字段之间要有英文逗号，字符串要用英文引号。
- 新增后先本地打开 `archive_viewer.html`，确认页面没有变空或报错。

## 部署

Windows 下直接双击运行：

```bat
deploy.bat
```

脚本会自动完成：

1. 检查/初始化 Git 仓库。
2. 设置 GitHub 远程仓库地址。
3. 提交本地修改。
4. 推送到 GitHub 的 `main` 分支。

部署成功后访问：

```text
https://Gumingyu.github.io/toutiao-archive/
```

GitHub Pages 有时需要几十秒到几分钟才会刷新。

## GitHub 代理设置

如果 Git 访问 GitHub 失败，而 Clash Verge 已经开启，可以让 Git 走本地代理。当前 Clash 端口是 `7897`：

```bat
git config --global http.proxy http://127.0.0.1:7897
git config --global https.proxy http://127.0.0.1:7897
```

测试 GitHub 是否可访问：

```bat
git ls-remote https://github.com/Gumingyu/toutiao-archive.git
```

如果看到 `HEAD` 和 `refs/heads/main`，说明 Git 已经能连上 GitHub。

取消代理：

```bat
git config --global --unset http.proxy
git config --global --unset https.proxy
```

## 常见问题

### push 被拒绝，提示 fetch first

如果看到：

```text
! [rejected] main -> main (fetch first)
```

说明 GitHub 上有本地没有的提交。先运行：

```bat
git pull --rebase origin main
git push -u origin main
```

### 首页空白

GitHub Pages 默认打开 `index.html`。如果首页空白，需要确认 `index.html` 是否正确跳转或指向 `archive_viewer.html`。

### 页面文字乱码

确认文件保存为 UTF-8。`archive_viewer.html` 里已经有：

```html
<meta charset="UTF-8">
```

如果中文仍然乱码，通常是文件本身保存编码不正确，需要重新以 UTF-8 保存。

## 维护建议

- 每次新增内容后，先本地打开页面检查，再运行 `deploy.bat`。
- 不要随意删除 `EPISODES` 里的逗号、括号和引号。
- 如果一次要新增很多期，建议每新增几期就预览一次，方便定位格式错误。
- 数据继续增大后，可以考虑把 `EPISODES` 拆成单独的 JSON 文件，减少维护难度。
