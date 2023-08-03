terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "high_5xx_errors_on_traffic_server" {
  source    = "./modules/high_5xx_errors_on_traffic_server"

  providers = {
    shoreline = shoreline
  }
}