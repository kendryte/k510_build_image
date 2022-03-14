# 勘智K510编译环境

[![镜像](https://github.com/kendryte/k510_build_image/actions/workflows/create-container.yml/badge.svg)](https://github.com/kendryte/k510_build_image/actions/workflows/create-container.yml)


# 下载最新镜像
> docker pull ghcr.io/kendryte/k510_env:latest

# 运行容器
```bash
# 假设SDK代码存放在 $(pwd)/k510_buildroot 中
mkdir -p "$HOME/.cache/ccache"
sudo docker run --name k510build --rm -it -v "$(pwd)/k510_buildroot:/opt/k510_buildroot" -v "$HOME/.cache/ccache:/opt/build-cache" ghcr.io/kendryte/k510_env:latest bash
```
你会看到： ![view](./docs/pic/1.png)

参数中的`$HOME/.cache/ccache`是缓存目录，可以随意修改。

**除通过-v挂载的目录外，容器内进行的一切修改将丢失！**

## 以非root用户运行：
当前用户应在docker组内，否则docker无法连接

```bash
docker run \
	--name k510build \
	--rm -it \
	--user "$(id -u):$(id -g)" \
	--env "HOME=/root" \
	-v "$(pwd)/k510_buildroot:/opt/k510_buildroot" \
	-v "$HOME/.cache/ccache:/opt/build-cache" \
	-v "/etc/passwd:/etc/passwd:ro" \
	-v "/etc/group:/etc/group:ro" \
	ghcr.io/kendryte/k510_env:latest bash
```

## 持久化容器
将`--rm`改成`-d`
> sudo docker run --name k510build **-d** -it ......

容器内启动新终端：
```bash
sudo docker exec -it k510build bash
```

如果提示：
> Error response from daemon: Container *XXXXX* is not running

说明容器处于停止状态，运行`sudo docker start k510build`启动它。

# 卸载
```bash
docker rmi ghcr.io/kendryte/k510_env
```

编译过程通过ccache工具加速，代价是占用更多磁盘空间，你可能需要手动删除 `$HOME/.cache/ccache` 文件夹。

# 常见问题

**TODO**
