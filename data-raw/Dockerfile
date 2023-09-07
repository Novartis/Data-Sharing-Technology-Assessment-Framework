# Custom image for Shiny
FROM divadnojnarg/shiny-docker

# Copy necessary files
RUN mkdir -p ./dstaf/app_cache/sass
COPY ["app.R", "renv.lock", "NAMESPACE", "DESCRIPTION", "./dstaf"]
COPY R ./dstaf/R
COPY inst ./dstaf/inst

# Go inside app folder
WORKDIR ./dstaf

# install renv & restore packages 
# See https://rstudio.github.io/renv/articles/docker.html#creating-docker-images-with-renv
ENV RENV_PATHS_LIBRARY_ROOT=~/.renv/library \
    RENV_VERSION=0.15.2
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"
RUN R -e "renv::restore(repos = c(CRAN = 'https://packagemanager.rstudio.com/cran/__linux__/focal/latest'))"

# expose port
EXPOSE 3838

# run app on container start
CMD ["R", "-e", "source('./app.R')"]

