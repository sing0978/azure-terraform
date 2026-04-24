resource "azurerm_network_security_group" "guacnsg" {
  name                = "guacnsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow_rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.my_ip
    destination_address_prefix = "*"
  }

   security_rule {
    name                       = "allow_ssh"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.my_ip
    destination_address_prefix = "*"
  }
   security_rule {
    name                       = "allow_http"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = var.my_ip
    destination_address_prefix = "*"
  }
  tags = {
    environment = "guacamole"
  }
}


resource "azurerm_subnet_network_security_group_association" "nsgasso" {
  subnet_id                 = azurerm_subnet.guacsubnet.id
  network_security_group_id = azurerm_network_security_group.guacnsg.id
}
