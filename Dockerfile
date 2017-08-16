FROM centos:centos6.7

MAINTAINER Steven Ayers

COPY sensu.repo /etc/yum.repos.d/

RUN yum -y install sensu initscripts wget
RUN wget http://peak.telecommunity.com/dist/ez_setup.py;python ez_setup.py
RUN easy_install supervisor
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-disk-checks sensu-plugins-load-checks sensu-plugins-memory-checks
RUN sed -i.bak s/LOG_LEVEL=info/LOG_LEVEL=debug/g /etc/init.d/sensu-service

ADD supervisord.conf /etc/supervisord.conf

EXPOSE 4567

CMD ["/usr/bin/supervisord"]