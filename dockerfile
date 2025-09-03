FROM python:3.12-slim-trixie
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*


# 创建工作目录
WORKDIR /app

# 复制项目文件
COPY . .

RUN uv sync --locked

# 对于可选依赖，可以使用以下命令：
RUN uv pip install --system "investor-agent[ta,playwright]"
RUN playwright install-deps chromium
RUN playwright install chromium

# 暴露端口
EXPOSE 8080

# 启动命令
CMD ["sh"]
