#
# apache install
#
sudo -i
yum install -y httpd24
chkconfig httpd on
service httpd start
touch /var/www/html/check.html
exit


#
# edit route53 alias target as test-elb
#

#
# edit domain's nameservers
#
