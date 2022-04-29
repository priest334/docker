FROM centos:7 as yumrepo-builder

RUN yum install -y yum-utils
RUN yum install -y centos-release-scl epel-release
RUN yum install -y nginx createrepo


FROM centos:7

RUN useradd -s /sbin/nologin -m -d /var/lib/nginx nginx
COPY --from=yumrepo-builder /usr/lib/ /usr/lib/
COPY --from=yumrepo-builder /usr/lib64/ /usr/lib64/
COPY --from=yumrepo-builder /usr/bin/createrepo /usr/bin/
COPY --from=yumrepo-builder /usr/share/createrepo/ /usr/share/createrepo/
COPY --from=yumrepo-builder /usr/sbin/nginx /usr/sbin/
COPY --from=yumrepo-builder /usr/share/nginx/ /usr/share/nginx/
COPY --from=yumrepo-builder /etc/nginx/ /etc/nginx
COPY --from=yumrepo-builder /etc/yum.repos.d/ /etc/yum.repos.d/
COPY ./etc/ /etc/ 

EXPOSE 80
VOLUME ["/etc/yum.repos.d", "/var/cache/yum", "/usr/share/nginx/html/7"]
COPY scripts/entrypoint.sh /sbin/entrypoint.sh
COPY scripts/download /sbin/download
RUN chmod 755 /sbin/entrypoint.sh
ENTRYPOINT ["/sbin/entrypoint.sh"]

