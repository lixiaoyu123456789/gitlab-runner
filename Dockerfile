# 使用官方GitLab Runner镜像作为基础镜像
FROM gitlab/gitlab-runner:latest
 
# 安装任何需要的软件包
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    wget \
    unzip \
    ca-certificates \
    jq \
    && rm -rf /var/lib/apt/lists/*
 
# 设置非交互式环境变量以允许无密码安装某些软件包
ENV DEBIAN_FRONTEND noninteractive
 
# 安装其他依赖项
RUN apt-get update && apt-get install -y \
    <your-additional-dependencies> \
    && rm -rf /var/lib/apt/lists/*
 
# 清理缓存并设置GitLab Runner为服务
RUN gitlab-runner verify \
    && gitlab-runner stop \
    && gitlab-runner uninstall -f \
    && rm -rf /etc/gitlab-runner/config.toml
 
# 设置环境变量
ENV CI_SERVER_URL="<your-gitlab-instance-url>"
 
# 设置开机启动GitLab Runner服务
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]