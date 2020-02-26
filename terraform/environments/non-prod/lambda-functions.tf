module "newsletter-lambda" {
  source        = "../../modules/lambda"
  bucket        = "newsletter.codefiction.tech"
  function_name = "slack_newsletter_lambda"
  handler       = "slack_newsletter_lambda.handler"
  runtime       = "nodejs12.x"
  timeout       = 300

  source_path = "${path.module}/lambda.py"

  web_page_user = "newsletter-static-bucket-user"
}