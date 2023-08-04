require 'awspec'

describe route53_hosted_zone('cdicohorts.team11.') do
  it { should exist }
end

describe route53_hosted_zone('dev.cdicohorts.team11.') do
  it { should exist }
end

describe route53_hosted_zone('qa.cdicohorts.team11.') do
  it { should exist }
end

describe route53_hosted_zone('sandbox-us-east-2.cdicohorts.team11.') do
  it { should exist }
end

describe route53_hosted_zone('prod.cdicohorts.team11.') do
  it { should exist }
end

describe route53_hosted_zone('prod-us-east-1.cdicohorts.team11.') do
  it { should exist }
end

