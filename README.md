# これは何か

kofuk/pixel-terrain のDockerイメージを作るDockerfile

https://github.com/kofuk/pixel-terrain

# 使い方

## ビルド

```bash
docker build . -t terrain2png
```

### 実行

```bash
docker run -v `pwd`/world:/world -v `pwd`/output:/output  -v `pwd`/cache:/cache terrain2png -o /output /world/region
```

