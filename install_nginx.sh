# Installing Ninx on an EC2 instance

# Update the package list
sudo apt-get update

# Install Nginx
sudo apt-get install nginx -y

# Start Nginx
sudo systemctl start nginx

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Check Nginx status
sudo systemctl status nginx

echo "<h1> Nginx Deployed via Terraform </h1>" | sudo tee /var/www/html/index.html