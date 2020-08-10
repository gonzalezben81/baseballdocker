

FROM rocker/shiny:latest

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev 
  
  

# install R packages required 
# (change it dependeing on the packages you need)
RUN R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('DT', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('readr', repos='http://cran.rstudio.com/')"



# copy the app to the image
COPY app.R /srv/shiny-server/
COPY Master.csv /srv/shiny-server/
COPY Batting.csv /srv/shiny-server/
COPY Pitching.csv /srv/shiny-server/
COPY google-analytics.js /srv/shiny-server/

# select port
EXPOSE 3838

# allow permission
#RUN sudo chown -R shiny:shiny /srv/shiny-server
#RUN chmod -R 755 /srv/shiny-server/

# run app
#CMD ["/usr/bin/shiny-server.sh"]