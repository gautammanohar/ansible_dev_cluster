# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "gautam"
client_key               "#{current_dir}/gautam.pem"
validation_client_name   "serendio-validator"
validation_key           "#{current_dir}/serendio-validator.pem"
chef_server_url          "https://ec2-52-32-249-127.us-west-2.compute.amazonaws.com/organizations/serendio"
cookbook_path            ["#{current_dir}/../cookbooks"]
