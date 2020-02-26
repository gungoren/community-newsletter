module "newsletter-cloudwatch" {
  source            = "../../modules/cloudwatch"
  function_name     = "slack_newsletter_lambda"
  function_arn      = "${module.newsletter-lambda.function_arn}"
  schedule_midnight = "cron(0 0 * * ? *)"
  event_name        = "slack-newsletter-event"
  web_page_user = "newsletter-static-bucket-user"
}