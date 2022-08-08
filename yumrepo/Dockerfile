FROM centos:7 as builder

RUN yum install -y yum-utils
RUN yum install -y centos-release-scl epel-release
RUN yum install -y nginx createrepo


FROM centos:7

RUN useradd -s /sbin/nologin -m -d /var/lib/nginx nginx
COPY --from=builder /usr/lib/ /usr/lib/
COPY --from=builder /usr/lib64/ /usr/lib64/
COPY --from=builder /usr/bin/createrepo /usr/bin/
COPY --from=builder /usr/share/createrepo/ /usr/share/createrepo/
COPY --from=builder /usr/sbin/nginx /usr/sbin/
COPY --from=builder /etc/nginx/ /etc/nginx
COPY runtime/ / 

EXPOSE 80
VOLUME ["/yumrepo"]
COPY scripts/entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh
ENTRYPOINT ["/sbin/entrypoint.sh"]

