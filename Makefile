$(CURDIR)/tls-gen/basic/result/ca_certificate.pem:
	$(MAKE) -C tls-gen/basic CN=localhost
certs: $(CURDIR)/tls-gen/basic/result/ca_certificate.pem
