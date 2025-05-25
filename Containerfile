FROM debian:bookworm-slim as install

ARG DEBIAN_FRONTEND=noninteractive

#SHELL ["/bin/bash", "-c"]
RUN rm /bin/sh \
  && ln -s /bin/bash /bin/sh

# install dependencies
RUN apt update && apt upgrade -y \
  && apt install -y --no-install-recommends --no-install-suggests ca-certificates git curl libyaml-dev build-essential libssl-dev zlib1g-dev \
  && rm -rf "/var/lib/apt/lists/*" \
  && rm -rf /var/cache/apt/archives

# add user and set home directory
ARG USER=rails
RUN useradd --create-home --shell /bin/bash $USER
ARG HOME="/home/$USER"
WORKDIR $HOME
USER $USER

# install Ruby, Node.js, Yarn
ENV NODE_VERSION=22.16.0
RUN git clone https://github.com/nvm-sh/nvm.git --depth 1 ~/.nvm \
  && cd .nvm \
  && . $HOME/.nvm/nvm.sh \
  && nvm --version \
  && nvm install $NODE_VERSION \
  && npm --version \
  && npm install --global yarn \
  && which yarn \
  && yarn --version
ENV PATH="$HOME/.nvm/versions/node/v$NODE_VERSION/bin/:$PATH"

# install Ruby using rbenv
ENV PATH="$HOME/.rbenv/bin:$PATH"
RUN git clone https://github.com/rbenv/rbenv.git --depth 1 ~/.rbenv \
  && ~/.rbenv/bin/rbenv init \
  && rbenv --version \
  && mkdir "$(rbenv root)"/plugins/ \
  && git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build \
  && rbenv install 3.4.4 \
  && rbenv global 3.4.4
ENV PATH="$HOME/.rbenv/shims:$PATH"

WORKDIR /rails/demo

# install Rails and initialize a new Rails app
RUN bundle init \
  && bundle add rails --version "~> 8.0.2" \
  && bundle exec rails new . --force --skip-git --database=sqlite3 --javascript=esbuild --css=bootstrap --asset-pipeline=propshaft \
  && bundle exec rails generate controller welcome index \
  && sed -i 's/# root/root to: "welcome#index"\n  # root/g' config/routes.rb \
  && sed -i '/def index/a \ \ \ \ @name = params[:name] || "World"' app/controllers/welcome_controller.rb \
  && echo '<div class="d-flex justify-content-center align-items-center vh-100"><h1 class="text-primary text-center">Hello <%= @name %>!</h1></div>' > app/views/welcome/index.html.erb \
  && bundle exec rails assets:precompile

ENV RAILS_ENV=production

EXPOSE 3000

HEALTHCHECK --interval=35s --timeout=4s CMD curl -f http://localhost:3000/up || exit 1

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
