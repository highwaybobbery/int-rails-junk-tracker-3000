FROM ruby:2.7.2
MAINTAINER eng@spaceback.me

# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  vim \
  default-jre \
  less \
  patch \
  ruby-dev \
  zlib1g-dev \
  liblzma-dev


# Install Node.js and Yarn for Webpack(er)
RUN \
  curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
  apt-get install -y nodejs && \
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install yarn


# Install pngout support for image_optim. From what I gather this is the only way to do it
# binary pulled from: http://www.jonof.id.au/kenutils
# RUN \
#     curl -s -o pngout.tar.gz http://www.jonof.id.au/files/kenutils/pngout-20200115-linux-static.tar.gz && \
#     tar -xf ./pngout.tar.gz && \
#     mv pngout-20200115-linux-static/i686/pngout-static /usr/local/bin/pngout

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /app
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5


# Copy the main application.
COPY . ./

# Configure an entry point, so we don't need to specify
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

ENV EDITOR /usr/bin/vim
