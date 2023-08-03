resource "shoreline_notebook" "high_5xx_errors_on_traffic_server" {
  name       = "high_5xx_errors_on_traffic_server"
  data       = file("${path.module}/data/high_5xx_errors_on_traffic_server.json")
  depends_on = [shoreline_action.invoke_traffic_inspector,shoreline_action.invoke_traffic_server_diagnostic_info,shoreline_action.invoke_hpa_setup]
}

resource "shoreline_file" "traffic_inspector" {
  name             = "traffic_inspector"
  input_file       = "${path.module}/data/traffic_inspector.sh"
  md5              = filemd5("${path.module}/data/traffic_inspector.sh")
  description      = "Cyber attack or malicious activity targeting the Traffic Server."
  destination_path = "/agent/scripts/traffic_inspector.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "traffic_server_diagnostic_info" {
  name             = "traffic_server_diagnostic_info"
  input_file       = "${path.module}/data/traffic_server_diagnostic_info.sh"
  md5              = filemd5("${path.module}/data/traffic_server_diagnostic_info.sh")
  description      = "Traffic Server overloaded due to high traffic."
  destination_path = "/agent/scripts/traffic_server_diagnostic_info.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "hpa_setup" {
  name             = "hpa_setup"
  input_file       = "${path.module}/data/hpa_setup.sh"
  md5              = filemd5("${path.module}/data/hpa_setup.sh")
  description      = "Implement HPA to handle increased traffic load."
  destination_path = "/agent/scripts/hpa_setup.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_traffic_inspector" {
  name        = "invoke_traffic_inspector"
  description = "Cyber attack or malicious activity targeting the Traffic Server."
  command     = "`chmod +x /agent/scripts/traffic_inspector.sh && /agent/scripts/traffic_inspector.sh`"
  params      = ["POD_NAME","NAMESPACE"]
  file_deps   = ["traffic_inspector"]
  enabled     = true
  depends_on  = [shoreline_file.traffic_inspector]
}

resource "shoreline_action" "invoke_traffic_server_diagnostic_info" {
  name        = "invoke_traffic_server_diagnostic_info"
  description = "Traffic Server overloaded due to high traffic."
  command     = "`chmod +x /agent/scripts/traffic_server_diagnostic_info.sh && /agent/scripts/traffic_server_diagnostic_info.sh`"
  params      = ["POD_NAME","NAMESPACE"]
  file_deps   = ["traffic_server_diagnostic_info"]
  enabled     = true
  depends_on  = [shoreline_file.traffic_server_diagnostic_info]
}

resource "shoreline_action" "invoke_hpa_setup" {
  name        = "invoke_hpa_setup"
  description = "Implement HPA to handle increased traffic load."
  command     = "`chmod +x /agent/scripts/hpa_setup.sh && /agent/scripts/hpa_setup.sh`"
  params      = ["DEPLOYMENT_NAME","NAMESPACE"]
  file_deps   = ["hpa_setup"]
  enabled     = true
  depends_on  = [shoreline_file.hpa_setup]
}

