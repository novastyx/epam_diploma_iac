resource "aws_cloudwatch_dashboard" "eks-cluster-application" {
  dashboard_name = "eks-cluster-application"
  dashboard_body = <<EOF
{
    "widgets": [
        {
            "height": 6,
            "width": 12,
            "y": 0,
            "x": 0,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "AWS/EC2", "CPUUtilization", "InstanceId", "*", { "visible": false } ],
                    [ "ContainerInsights", "pod_cpu_utilization", "PodName", "webapp", "ClusterName", "eks", "Namespace", "test" ],
                    [ "...", "main" ],
                    [ ".", "pod_cpu_utilization_over_pod_limit", ".", ".", ".", ".", ".", "." ],
                    [ "...", "test" ]
                ],
                "period": 300,
                "stat": "Average",
                "region": "eu-central-1",
                "title": "EC2 Instance CPU",
                "view": "timeSeries",
                "stacked": true,
                "legend": {
                    "position": "right"
                }
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 0,
            "width": 12,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": true,
                "metrics": [
                    [ "ContainerInsights", "pod_memory_utilization", "PodName", "webapp", "ClusterName", "eks", "Namespace", "test" ],
                    [ "...", "main" ],
                    [ ".", "pod_memory_reserved_capacity", ".", ".", ".", ".", ".", "test" ],
                    [ "...", "main" ],
                    [ ".", "pod_memory_utilization_over_pod_limit", ".", ".", ".", ".", ".", "test" ],
                    [ "...", "main" ]
                ],
                "region": "eu-central-1",
                "liveData": true,
                "legend": {
                    "position": "right"
                },
                "setPeriodToTimeRange": true,
                "title": "Pod memory utilization"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 6,
            "width": 12,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": true,
                "metrics": [
                    [ "ContainerInsights", "pod_network_tx_bytes", "PodName", "webapp", "ClusterName", "eks", "Namespace", "test" ],
                    [ ".", "pod_network_rx_bytes", ".", ".", ".", ".", ".", "." ],
                    [ ".", "pod_network_tx_bytes", ".", ".", ".", ".", ".", "main" ],
                    [ ".", "pod_network_rx_bytes", ".", ".", ".", ".", ".", "." ]
                ],
                "region": "eu-central-1",
                "legend": {
                    "position": "right"
                },
                "title": "Network traffic over pods"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 12,
            "width": 12,
            "height": 3,
            "properties": {
                "view": "singleValue",
                "stacked": true,
                "metrics": [
                    [ "ContainerInsights", "pod_number_of_container_restarts", "PodName", "webapp", "ClusterName", "eks", "Namespace", "test" ],
                    [ "...", "main" ]
                ],
                "region": "eu-central-1",
                "setPeriodToTimeRange": true,
                "singleValueFullPrecision": true,
                "title": "Pods restarts"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 15,
            "width": 18,
            "height": 3,
            "properties": {
                "view": "singleValue",
                "metrics": [
                    [ "ContainerInsights", "service_number_of_running_pods", "ClusterName", "eks", "Service", "internal-webapp-service", "Namespace", "test" ],
                    [ "...", "webapp-external-service", ".", "." ],
                    [ "...", "internal-webapp-service", ".", "main" ],
                    [ "...", "webapp-external-service", ".", "." ]
                ],
                "region": "eu-central-1",
                "setPeriodToTimeRange": true,
                "stacked": true,
                "singleValueFullPrecision": false,
                "liveData": false,
                "period": 300,
                "title": "NLB count"
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 6,
            "width": 12,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "ContainerInsights", "pod_network_tx_bytes", "ClusterName", "eks", "Service", "webapp-external-service", "Namespace", "test" ],
                    [ ".", "pod_network_rx_bytes", ".", ".", ".", ".", ".", "." ],
                    [ ".", "pod_network_tx_bytes", ".", ".", ".", "internal-webapp-service", ".", "." ],
                    [ ".", "pod_network_rx_bytes", ".", ".", ".", ".", ".", "." ],
                    [ "...", "main" ],
                    [ ".", "pod_network_tx_bytes", ".", ".", ".", ".", ".", "." ]
                ],
                "region": "eu-central-1",
                "legend": {
                    "position": "right"
                },
                "title": "Traffic over NLB"
            }
        }
    ]
}
EOF
}
