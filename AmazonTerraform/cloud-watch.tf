#Resoruce: CPU Metric Monitoring 
resource "aws_cloudwatch_metric_alarm" "CPU-Monitoring" {
  alarm_name                = "EC2-CPU-Monitoring"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "ELB-Monitoring" {
  alarm_name                = "EC2-CPU-Monitoring"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "UnHealthyHostCount"
  namespace                 = "AWS/ELB"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "1"
  alarm_description         = "This metric monitors ELB Unheathly"
  insufficient_data_actions = []
}