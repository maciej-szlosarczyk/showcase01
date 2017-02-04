FROM elixir:1.4
ENV MIX_ENV dev

# Install dependencies
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - > /dev/null \
    && apt-get install nodejs -y > /dev/null \
    && apt-get upgrade -y > /dev/null \
    && apt-get install postgresql-client -y > /dev/null

# Create folders
RUN mkdir -p /opt/webapps/showcase01
WORKDIR /opt/webapps/showcase01

# Run the mix setup
COPY . .
RUN mix local.rebar --force > /dev/null
RUN mix local.hex --force > /dev/null 
RUN mix deps.get > /dev/null
RUN mix deps.compile > /dev/null
WORKDIR /opt/webapps/showcase01/apps/web
RUN npm install > /dev/null

WORKDIR /opt/webapps/showcase01

EXPOSE 4000
CMD mix phoenix.server
